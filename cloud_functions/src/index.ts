import * as https from "firebase-functions/v2/https";
import * as firestore from "firebase-functions/v2/firestore";
import { defineSecret } from "firebase-functions/params";
import * as admin from "firebase-admin";
import Stripe from "stripe";

admin.initializeApp();
const db = admin.firestore();

// Secret Manager for Stripe
const stripeSecretKey = defineSecret("STRIPE_SECRET_KEY");

// Secret manager for Google Maps Key
const GOOGLE_MAPS_KEY = defineSecret("GOOGLE_MAPS_KEY");

/* ---------------------------------------------- */
/* ---------- Used by the Merchant App ----------
/* ----------------------------------------------*/

// Shared configuration 
const sharedOptions: https.HttpsOptions = {
  region: "europe-west1",
  secrets: [GOOGLE_MAPS_KEY],
  cors: true,
};

/** 
 * Function for autocompletion of the address hints (Web)
 */
export const googleMapsAutocomplete = https.onRequest(sharedOptions, async (req, res) => {
  const input = req.query.input as string;

  if (!input) {
    res.status(400).json({ error: "Missing input parameter" });
    return;
  }

  try {
    const apiKey = GOOGLE_MAPS_KEY.value();
    const url = `https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${encodeURIComponent(input)}&key=${apiKey}`;
    
    const response = await fetch(url);
    const data = await response.json();
    
    res.status(200).json(data);
  } catch (error) {
    console.error("Autocomplete Error:", error);
    res.status(500).json({ error: "Failed to fetch autocomplete data" });
  }
});

/**
 * Function for getting the (lat/lng) of a given place chosen by the user (Web)
 */
export const googleMapsDetails = https.onRequest(sharedOptions, async (req, res) => {
  const placeId = req.query.placeId as string;

  if (!placeId) {
    res.status(400).json({ error: "Missing placeId parameter" });
    return;
  }

  try {
    const apiKey = GOOGLE_MAPS_KEY.value();
    const url = `https://maps.googleapis.com/maps/api/place/details/json?place_id=${placeId}&key=${apiKey}`;
    
    const response = await fetch(url);
    const data = await response.json();
    
    res.status(200).json(data);
  } catch (error) {
    console.error("Details Error:", error);
    res.status(500).json({ error: "Failed to fetch place details" });
  }
});

/* ---------------------------------------------- */
/* ---------- Used by the Customer App ----------
/* ----------------------------------------------*/

/**
 * Creates Payment Intent for Stripe transactions
 */
export const createPaymentIntent = https.onCall(
  { 
    secrets: [stripeSecretKey], 
    region: "europe-west1", 
    enforceAppCheck: false 
  },
  async (req) => {
    const { amount } = req.data;
    if (!amount) throw new https.HttpsError("invalid-argument", "Brak kwoty (amount).");

    const stripe = new Stripe(stripeSecretKey.value(), { apiVersion: "2023-10-16" });
    const amountInCents = Math.round(parseFloat(amount.toString()) * 100);

    try {
      const pi = await stripe.paymentIntents.create({
        amount: amountInCents,
        currency: "pln",
        automatic_payment_methods: { enabled: true },
      });
      return { clientSecret: pi.client_secret, paymentIntentId: pi.id };
    } catch (error: any) {
      console.error("Stripe Error:", error);
      throw new https.HttpsError("internal", error.message);
    }
  }
);

/**
 * Gets Paymnet Methods (credit card/blik) after successfull transaction in Stripe
 */
export const getPaymentMethodType = https.onCall(
  { 
    secrets: [stripeSecretKey], 
    region: "europe-west1", 
    enforceAppCheck: false 
  },
  async (req) => {
    const { paymentIntentId } = req.data;
    if (!paymentIntentId) throw new https.HttpsError("invalid-argument", "Brak paymentIntentId.");

    const stripe = new Stripe(stripeSecretKey.value(), { apiVersion: "2023-10-16" });
    
    try {
      const pi = await stripe.paymentIntents.retrieve(paymentIntentId, {
        expand: ["payment_method"],
      });
      const paymentMethod = pi.payment_method as Stripe.PaymentMethod;
      return { paymentMethodType: paymentMethod?.type ?? "card" };
    } catch (error: any) {
      throw new https.HttpsError("internal", error.message);
    }
  }
);

/**
 * Zapisuje zamówienie w Firestore
 */
export const placeOrder = https.onCall(
  { 
    region: "europe-west1", 
    enforceAppCheck: false 
  },
  async (req) => {
    const { data, auth } = req;
    if (!auth) throw new https.HttpsError("unauthenticated", "Wymagane logowanie.");

    const orderID = db.collection("orders").doc().id;
    const orderData = {
      ...data,
      orderID,
      userID: auth.uid,
      status: "Pending",
      orderTime: admin.firestore.FieldValue.serverTimestamp(),
    };

    const batch = db.batch();
    batch.set(db.collection("orders").doc(orderID), orderData);
    batch.set(db.collection("users").doc(auth.uid).collection("orders").doc(orderID), orderData);
    
    await batch.commit();
    
    // Próba wysłania do kuriera
    try {
      await dispatchToRider(orderID);
    } catch (e) {
      console.error("Dispatch Error:", e);
    }

    return { success: true, orderID };
  }
);

/* ---------------------------------------------- */
/* ------------ Used by the Rider App -----------
/* ----------------------------------------------*/

/**
 * Trigger: Gdy kurier zaakceptuje zadanie
 */
export const onDispatchAccepted = firestore.onDocumentUpdated(
  {
    document: "dispatch_jobs/{jobId}",
    region: "europe-west1",
  },
  async (event) => {
    const after = event.data?.after.data();
    if (!after || after.status !== "accepted") return;

    const { riderId, orderID } = after;

    await db.collection("orders").doc(orderID).update({
      status: "In Progress",
      driverUID: riderId,
    });

    await db.collection("riders").doc(riderId).update({
      hasActiveOrder: true,
      currentOrderID: orderID,
    });
  }
);

/**
 * Trigger: Gdy status zamówienia zmieni się na Delivered
 */
export const onOrderUpdated = firestore.onDocumentUpdated(
  {
    document: "orders/{orderID}",
    region: "europe-west1",
  },
  async (event) => {
    const after = event.data?.after.data();
    if (!after) return;

    if (after.status === "Delivered" && after.driverUID) {
      await db.collection("riders").doc(after.driverUID).update({
        hasActiveOrder: false,
        currentOrderID: null,
      });
    }
  }
);

/**
 * Funkcja pomocnicza: Szukanie kuriera
 */
async function dispatchToRider(orderID: string) {
  const riders = await db.collection("riders")
    .where("isOnline", "==", true)
    .where("hasActiveOrder", "==", false)
    .limit(1).get();

  if (riders.empty) return;
  const riderDoc = riders.docs[0];

  await db.collection("dispatch_jobs").add({
    riderId: riderDoc.id,
    orderID,
    status: "pending",
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });
}

/**
 * Zapisywanie tokena FCM
 */
export const saveFcmToken = https.onCall(
  { 
    region: "europe-west1", 
    enforceAppCheck: false 
  }, 
  async (req) => {
    const { token, role } = req.data;
    if (!req.auth) return { success: false };
    
    const coll = role === "rider" ? "riders" : "users";
    await db.collection(coll).doc(req.auth.uid).set({ fcmToken: token }, { merge: true });
    return { success: true };
});