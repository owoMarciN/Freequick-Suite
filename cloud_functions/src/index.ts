import * as https from "firebase-functions/v2/https";
import * as fsEvents from "firebase-functions/v2/firestore";
import { defineSecret } from "firebase-functions/params";
import { FieldValue, Timestamp } from "firebase-admin/firestore";
import * as admin from "firebase-admin";
import Stripe from "stripe";
import axios from "axios";
import * as emoji from 'node-emoji';

admin.initializeApp();
const db = admin.firestore();

// Secrets (Firebase Secret Manager)
const stripeSecretKey      = defineSecret("STRIPE_SECRET_KEY");
const stripePublishableKey = defineSecret("STRIPE_PUBLISHABLE_KEY");
const stripeWebhookSecret  = defineSecret("STRIPE_WEBHOOK_SECRET");
const googleMapsKey        = defineSecret("GOOGLE_MAPS_KEY");

const REGION = "europe-west1";
const APP_CHECK = false;

/* ---------------------------------------------- */
/* -------------- Emoji Definitions --------------
/* ----------------------------------------------*/
const EMOJI = {
  CASH:    emoji.get('dollar'),          
  CHECK:   emoji.get('white_check_mark'), 
  SUCCESS: emoji.get('tada'),           
  BELL:    emoji.get('bell'),             
  SCOOTER: emoji.get('motor_scooter'),    
};

/* ---------------------------------------------- */
/* -------------- Helper Functions --------------
/* ----------------------------------------------*/
const getStripe = () => new Stripe(stripeSecretKey.value(), { apiVersion: "2023-10-16" });

function roundToTwo(num: number | string | undefined): number {
  if (num === undefined || num === null) return 0;
  return Math.round(Number(num) * 100) / 100;
}

function haversineKm(
  lat1: number, lng1: number,
  lat2: number, lng2: number
): number {
  const R = 6371;
  const dLat = ((lat2 - lat1) * Math.PI) / 180;
  const dLng = ((lng2 - lng1) * Math.PI) / 180;
  const a =
    Math.sin(dLat / 2) ** 2 +
    Math.cos((lat1 * Math.PI) / 180) *
      Math.cos((lat2 * Math.PI) / 180) *
      Math.sin(dLng / 2) ** 2;
  return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
}
 
async function getDirections(
  fromLat: number, fromLng: number,
  toLat: number,   toLng: number,
  mapsKey: string,
  mode: "driving" | "bicycling" = "driving"
): Promise<{ durationSeconds: number; polyline: string } | null> {
  try {
    const { data } = await axios.get(
      "https://maps.googleapis.com/maps/api/directions/json",
      {
        params: {
          origin:      `${fromLat},${fromLng}`,
          destination: `${toLat},${toLng}`,
          mode,
          key: mapsKey,
        },
      }
    );
    if (data.status !== "OK") return null;
    const leg = data.routes[0].legs[0];
    return {
      durationSeconds: leg.duration.value,
      polyline:        data.routes[0].overview_polyline.points,
    };
  } catch {
    return null;
  }
}

// Write in-app notification
async function writeNotification(
  uid: string,
  title: string,
  body: string,
  source: "order" | "admin" | "nearby" | "news" | "welcome"
) {
  await db
    .collection("users")
    .doc(uid)
    .collection("notifications")
    .add({
      title,
      body,
      source,
      isRead: false,
      timestamp: FieldValue.serverTimestamp(),
    });
}

// FCM push + in-app notification
async function notifyUser(
  uid: string,
  fcmToken: string | null | undefined,
  title: string,
  body: string,
  source: "order" | "admin" | "nearby" | "news" | "welcome",
  data?: Record<string, string>
) {
  await writeNotification(uid, title, body, source);
 
  if (fcmToken) {
    try {
      await admin.messaging().send({
        token:        fcmToken,
        notification: { title, body },
        data:         data ?? {},
        android:      { priority: "high" },
        apns:         { payload: { aps: { sound: "default", badge: 1 } } },
      });
    } catch (e) {
      console.warn("FCM send failed for", uid, e);
    }
  }
}

export const sendAdminNotification = https.onCall(
  { region: REGION, enforceAppCheck: APP_CHECK },
  async (req) => {
  // Security Check
  if (!req.auth || req.auth.token.role !== 'admin') {
    throw new https.HttpsError("permission-denied", "Unauthorized");
  }

  const { title, body, audience, targetUIDs } = req.data;
  const db = admin.firestore();

  // 1. Get the list of people to notify
  let usersToNotify: { uid: string, fcmToken?: string }[] = [];

  if (audience === "specific") {
    // For specific users, we need to fetch their FCM tokens first
    const snaps = await Promise.all(
      targetUIDs.map((uid: string) => db.collection("users").doc(uid).get())
    );
    usersToNotify = snaps.map(s => ({ uid: s.id, fcmToken: s.data()?.fcmToken }));
  } else {
    // For "all" or "restaurants"
    let query: any = db.collection("users");
    if (audience === "restaurants") {
      query = query.where("role", "==", "restaurant");
    }
    const snap = await query.get();
    usersToNotify = snap.docs.map((d: any) => ({ uid: d.id, fcmToken: d.data()?.fcmToken }));
  }

  // 2. Loop through and use your existing helper!
  // We use Promise.all to send them all in parallel for speed
  await Promise.all(
    usersToNotify.map(user => 
      notifyUser(user.uid, user.fcmToken, title, body, "admin")
    )
  );

  // 3. Log to History
  await db.collection("adminNotificationHistory").add({
    title,
    body,
    audience,
    sentCount: usersToNotify.length,
    timestamp: admin.firestore.FieldValue.serverTimestamp(),
  });

  return { success: true, sentCount: usersToNotify.length };
});

async function createOrderAndDispatch({
  quoteID,
  userID,
  restaurantID,
  paymentMethod,
  paymentDetails,
}: {
  quoteID: string;
  userID: string;
  restaurantID: string;
  paymentMethod: "cash" | "stripe";
  paymentDetails: string;
}) {
  const [quoteDoc, userDoc, restaurantDoc] = await Promise.all([
    db.collection("quotes").doc(quoteID).get(),
    db.collection("users").doc(userID).get(),
    db.collection("restaurants").doc(restaurantID).get(),
  ]);
  if (!quoteDoc.exists) throw new Error("Quote not found: " + quoteID);

  const quote = quoteDoc.data()!;
  const user = userDoc.data()!;
  const restaurant = restaurantDoc.data()!;

  const rawItemIDs: string[] = quote.itemIDs || [];
  const items = await Promise.all(rawItemIDs.map(async (encodedString) => {
    // Format: restaurantID:menuID:itemID:quantity
    const [resId, menuId, itemId, qty] = encodedString.split(':');
    
    const itemDoc = await db
      .collection("restaurants").doc(resId)
      .collection("menus").doc(menuId)
      .collection("items").doc(itemId).get();

    const itemData = itemDoc.data();

    const originalPrice = itemData?.price || 0.0;
    const discountPercent = itemData?.discount || 0.0;
    const discountedPrice = roundToTwo(originalPrice * (1.0 - (discountPercent / 100.0)));

    return {
      name: itemData?.title || "Unknown Item",
      originalPrice: originalPrice,
      price: discountedPrice,
      discount: discountPercent,
      quantity: parseInt(qty) || 1,
      itemID: itemId
    };
  }));

  const orderID = db.collection("orders").doc().id;
  const orderRef = db.collection("orders").doc(orderID);
  const userOrderRef = db
    .collection("users")
    .doc(userID)
    .collection("orders")
    .doc(orderID);

  // Resolve address
  let resolvedAddress: Record<string, any> = {};
  if (quote.orderType !== "pickup" && quote.addressID) {
    const addrDoc = await db
      .collection("users")
      .doc(userID)
      .collection("addresses")
      .doc(quote.addressID)
      .get();
    if (addrDoc.exists) {
      resolvedAddress = { ...addrDoc.data()!, addressID: quote.addressID };
    }
  } else if (quote.orderType === "pickup") {
    resolvedAddress = { type: "pickup" };
  }

  const subtotal = roundToTwo(quote.itemsTotal);
  const deliveryFee = roundToTwo(quote.deliveryFee);
  const totalAmount = roundToTwo(quote.finalTotal);

  const orderData: Record<string, any> = {
    orderID,
    userID: userID,
    restaurantID,
    restaurantName: restaurant.name ?? "",
    restaurantLat: restaurant.lat ?? null,
    restaurantLng: restaurant.lng ?? null,
    items,
    address: resolvedAddress,
    addressID: quote.addressID ?? null,
    orderType: quote.orderType ?? "delivery",
    paymentMethod,
    paymentDetails,
    subtotal,
    deliveryFee,
    totalAmount,
    status: "Pending",
    isSuccess: true,
    riderUID: "",
    orderTime: FieldValue.serverTimestamp(),
    updatedAt: FieldValue.serverTimestamp(),
  };

  const batch = db.batch();
  batch.set(orderRef, orderData);
  batch.set(userOrderRef, orderData);
  batch.update(db.collection("quotes").doc(quoteID), {
    status: "USED",
    orderID,
    paymentStatus: paymentMethod === "stripe" ? "PAID" : "PENDING_COD",
  });
  await batch.commit();

  // Notify restaurant & customer
  if (restaurant.fcmToken) {
    try {
      const cashLabel = paymentMethod === "cash" ? `${EMOJI.CASH} Cash` : "";
      await admin.messaging().send({
        token: restaurant.fcmToken,
        notification: {
          title: `${EMOJI.BELL} New Order!`,
          body: `Order #${orderID.slice(0, 8)} received${cashLabel}`,
        },
        data: { type: "NEW_ORDER", orderID },
        android: { priority: "high" },
      });
    } catch (e) {
      console.warn("Restaurant FCM failed", e);
    }
  }

  await writeNotification(
    userID,
    `Order Placed! ${EMOJI.SUCCESS}`,
    `Your order from ${restaurant.name ?? "the restaurant"} has been received.`,
    "order"
  );

  await dispatchToRider(orderID, orderData, restaurant, user);

  return orderID;
}

async function dispatchToRider(
  orderID: string,
  order: Record<string, any>,
  restaurant: Record<string, any>,
  customer: Record<string, any>
) {
  const ridersSnap = await db
    .collection("riders")
    .where("isOnline", "==", true)
    .where("hasActiveOrder", "==", false)
    .limit(10)
    .get();

  if (ridersSnap.empty) {
    console.warn("No riders available for order:", orderID);
    return;
  }

  const riderDoc = ridersSnap.docs[0];
  const rider = riderDoc.data();

  const pickupLat = restaurant.lat ?? 0;
  const pickupLng = restaurant.lng ?? 0;
  const dropoffLat = parseFloat(order.address?.lat ?? "0");
  const dropoffLng = parseFloat(order.address?.lng ?? "0");

  const distanceKm = roundToTwo(haversineKm(pickupLat, pickupLng, dropoffLat, dropoffLng));
  const deliveryFee = roundToTwo(order.deliveryFee);
  const riderEarnings = roundToTwo(Math.max(3.5, deliveryFee * 0.75));
  const finalTotal = roundToTwo(order.totalAmount);

  const isCash = (order.paymentMethod ?? "cash") === "cash";

  await db.collection("dispatch_jobs").doc().set({
    riderUID: riderDoc.id,
    orderID,
    restaurantName: restaurant.name ?? "",
    restaurantAddress: restaurant.address ?? "",
    customerAddress: order.address?.fullAddress ?? "",
    customerName: customer.name ?? "",
    items: order.items || [],
    finalTotal,
    deliveryFee,
    riderEarnings,
    distanceKm,
    paymentMethod: order.paymentMethod ?? "cash",
    orderType: order.orderType ?? "delivery",
    collectPayment: isCash,
    status: "pending",
    createdAt: FieldValue.serverTimestamp(),
    expiresAt: Timestamp.fromDate(new Date(Date.now() + 30_000)),
  });

  if (rider.fcmToken) {
    try {
      const paymentLabel = isCash ? `${EMOJI.CASH} Collect cash` : `${EMOJI.CHECK} Card paid`;
      await admin.messaging().send({
        token: rider.fcmToken,
        notification: {
          title: `${EMOJI.SCOOTER} New Delivery!`,
          body: `${restaurant.name ?? "Restaurant"} · zł${riderEarnings} · ${paymentLabel}`,
        },
        data: { type: "DISPATCH_JOB", orderID },
        android: { priority: "high" },
        apns: { payload: { aps: { sound: "default", badge: 1 } } },
      });
    } catch (e) {
      console.warn("Rider FCM failed", e);
    }
  }
}

/* ---------------------------------------------- */
/* ---------- Used by the Merchant App ----------
/* ----------------------------------------------*/

/* Address autocomplete for the merchant app settings screen. */
export const googleMapsAutocomplete = https.onRequest(
  { region: REGION, secrets: [googleMapsKey], cors: true }, 
  async (req, res) => {
    const input = req.query.input as string;
    if (!input) {
      res.status(400).json({ error: "Missing input parameter" });
      return;
    }

    try {
      const url =
        `https://maps.googleapis.com/maps/api/place/autocomplete/json` +
        `?input=${encodeURIComponent(input)}&key=${googleMapsKey.value()}`;

      const response = await fetch(url);
      const data = await response.json();
      res.status(200).json(data);
    } catch (error) {
      console.error("Autocomplete Error:", error);
      res.status(500).json({ error: "Failed to fetch autocomplete data" });
    }
  }
);

/* Function for getting the (lat/lng) of a given place chosen by the user (Web) */
export const googleMapsDetails = https.onRequest(
  { region: REGION, secrets: [googleMapsKey], cors: true }, 
  async (req, res) => {
    const placeId = req.query.placeId as string;
    if (!placeId) {
      res.status(400).json({ error: "Missing placeId parameter" });
      return;
    }

    try {
      const url =
        `https://maps.googleapis.com/maps/api/place/details/json` +
        `?place_id=${placeId}&key=${googleMapsKey.value()}`;

      const response = await fetch(url);
      const data = await response.json();
      
      res.status(200).json(data);
    } catch (error) {
      console.error("Details Error:", error);
      res.status(500).json({ error: "Failed to fetch place details" });
    }
  }
);

/* ---------------------------------------------- */
/* ---------- Used by the Customer App ----------
/* ----------------------------------------------*/

/* Creates Payment Intent for Stripe transactions */
export const createPaymentIntent = https.onCall(
  { region: REGION, secrets: [stripeSecretKey, stripePublishableKey], enforceAppCheck: APP_CHECK },
  async (req) => {
    if (!req.auth) throw new https.HttpsError("unauthenticated", "Login required");

    const { quoteID } = req.data;
    if (!quoteID) throw new https.HttpsError("invalid-argument", "quoteID required");

    const quoteDoc = await db.collection("quotes").doc(quoteID).get();
    if (!quoteDoc.exists) throw new https.HttpsError("not-found", "Quote not found");

    const quote = quoteDoc.data()!;
    if (quote.userID !== req.auth.uid) throw new https.HttpsError("permission-denied", "Not your quote");

    if (quote.expiresAt.toDate() < new Date()) throw new https.HttpsError("failed-precondition", "Quote expired");

    const stripe = getStripe();
    const amountInGrosze = Math.round(quote.finalTotal * 100);

    try {
      const paymentIntent = await stripe.paymentIntents.create({
        amount: amountInGrosze,
        currency: "pln",
        metadata: {
          quoteID,
          userID: req.auth.uid,
          restaurantID: quote.restaurantID,
        },
        automatic_payment_methods: { enabled: true },
      });

      await db.collection("quotes").doc(quoteID).update({
        stripePaymentIntentId: paymentIntent.id,
        paymentStatus: "PENDING",
      });
      return { 
        clientSecret: paymentIntent.client_secret, 
        paymentIntentId: paymentIntent.id,
        publishableKey: stripePublishableKey.value()
      };
    } catch (error: any) {
      console.error("Stripe Error:", error);
      throw new https.HttpsError("internal", error.message);
    }
  }
);

/* Gets Paymnet Methods (credit card/blik) after successfull transaction in Stripe */
export const getPaymentMethodType = https.onCall(
  { region: REGION, secrets: [stripeSecretKey], enforceAppCheck: APP_CHECK },
  async (req) => {
    const { paymentIntentId } = req.data;
    if (!paymentIntentId || typeof paymentIntentId !== "string") throw new https.HttpsError("invalid-argument", "paymentIntendId is required and must be a string");

    const stripe = getStripe();
    
    try {
      const paymentIntent = await stripe.paymentIntents.retrieve(paymentIntentId, {
        expand: ["payment_method"],
      });

      if (!paymentIntent) {
        throw new https.HttpsError(
          "not-found", "PaymentIntent not found"
        );
      }

      const paymentMethod = paymentIntent.payment_method as Stripe.PaymentMethod | null;

      return {
        paymentMethodType: paymentMethod?.type ?? "unknown",
        status: paymentIntent.status,
      };
    } catch (error: any) {
      console.error("getPaymentMethodType error:", error);
      throw new https.HttpsError("internal", error.message);
    }
  }
);

/**
 * Places a cash-on-delivery order. Identical order structure to Stripe flow.
 * The dispatch job is flagged collectPayment: true so the rider knows to
 * collect cash from the customer.
 */
export const placeOrder = https.onCall(
  { region: REGION, enforceAppCheck: APP_CHECK },
  async (req) => {
    if (!req.auth) {
      throw new https.HttpsError("unauthenticated", "Login required");
    }

    const { quoteID } = req.data;
    if (!quoteID) {
      throw new https.HttpsError("invalid-argument", "quoteID required");
    }

    const quoteDoc = await db.collection("quotes").doc(quoteID).get();
    if (!quoteDoc.exists) {
      throw new https.HttpsError("not-found", "Quote not found");
    }

    const quote = quoteDoc.data()!;

    if (quote.status === "USED") {
      throw new https.HttpsError("already-exists", "Order already placed for this quote");
    }

    const orderID = await createOrderAndDispatch({
      quoteID,
      userID: req.auth.uid,
      restaurantID: quote.restaurantID,
      paymentMethod: "cash",
      paymentDetails: "cash",
    });

    await db.collection("quotes").doc(quoteID).update({
      orderID,
      status: "USED",
    });
 
    return { success: true, orderID };
  }
);

export const stripeWebhook = https.onRequest(
  { region: REGION, secrets: [stripeSecretKey, stripeWebhookSecret] },
  async (req, res) => {
    const sig = req.headers["stripe-signature"] as string;
 
    let event: Stripe.Event;
    try {
      const stripe = new Stripe(stripeSecretKey.value(), { apiVersion: "2023-10-16" });
      event = stripe.webhooks.constructEvent(
        req.rawBody,
        sig,
        stripeWebhookSecret.value()
      );
    } catch (err) {
      console.error("Webhook signature failed:", err);
      res.status(400).send("Invalid signature");
      return;
    }
 
    if (event.type === "payment_intent.succeeded") {
      const pi = event.data.object as Stripe.PaymentIntent;
      await handlePaymentSuccess(pi);
    }
 
    res.json({ received: true });
  }
);
 
async function handlePaymentSuccess(paymentIntent: Stripe.PaymentIntent) {
  const { quoteID, userID, restaurantID } = paymentIntent.metadata;
 
  const existing = await db
    .collection("orders")
    .where("stripePaymentIntentId", "==", paymentIntent.id)
    .limit(1)
    .get();
  if (!existing.empty) {
    console.log("Order already created for PI:", paymentIntent.id);
    return;
  }
 
  const orderID = await createOrderAndDispatch({
    quoteID,
    userID,
    restaurantID,
    paymentMethod: "stripe",
    paymentDetails: paymentIntent.id,
  });

  await db.collection("quotes").doc(quoteID).update({
    orderID,
    status: "USED",
  });
}

/* ---------------------------------------------- */
/* ------------ Used by the Rider App -----------
/* ----------------------------------------------*/

// Trigger: dispatch_jobs/{id}.status → 'accepted'
// sets order to 'In Progress', marks rider busy, notifies customer
// 
export const onDispatchJobAccepted = fsEvents.onDocumentUpdated(
  { document: "dispatch_jobs/{jobId}", region: REGION },
  async (event) => {
    const before = event.data?.before.data();
    const after  = event.data?.after.data();
    if (!before || !after) return;
    if (before.status === after.status) return;
    if (after.status !== "accepted") return;
 
    const { riderUID, orderID } = after;
 
    const orderDoc = await db.collection("orders").doc(orderID).get();
    if (!orderDoc.exists) return;
    const orderData = orderDoc.data()!;
    const userID    = orderData.userID as string;
 
    const orderUpdate = {
      status:    "In Progress",
      riderUID:  riderUID,
      updatedAt: FieldValue.serverTimestamp(),
    };
 
    const batch = db.batch();
    batch.update(db.collection("orders").doc(orderID), orderUpdate);
    batch.update(
      db.collection("users").doc(userID).collection("orders").doc(orderID),
      orderUpdate
    );
    // Mark rider busy — matches RiderModel fields
    batch.update(db.collection("riders").doc(riderUID), {
      hasActiveOrder:  true,
      currentOrderID:  orderID,
      lastSeenAt:      FieldValue.serverTimestamp(),
    });
    await batch.commit();
 
    // Notify customer
    const userDoc = await db.collection("users").doc(userID).get();
    const user    = userDoc.data()!;
    await notifyUser(
      userID,
      user.fcmToken,
      "Rider on the way! 🛵",
      "Your rider is heading to the restaurant.",
      "order",
      { type: "ORDER_STATUS", orderID, status: "In Progress" }
    );
  }
);

export const onOrderStatusChanged = fsEvents.onDocumentUpdated(
  { document: "orders/{orderID}", region: REGION },
  async (event) => {
    const before = event.data?.before.data();
    const after  = event.data?.after.data();
    if (!before || !after) return;
    if (before.status === after.status) return;
 
    const orderID = event.params.orderID;
    const userID  = after.userID  as string;
    const status  = after.status  as string;
 
    const messages: Record<string, { title: string; body: string }> = {
      "In Progress": {
        title: `Order Accepted ${EMOJI.CHECK}`,
        body:  "The restaurant is preparing your order.",
      },
      "Ready": {
        title: `On the Way! ${EMOJI.SCOOTER}`,
        body:  "Your rider has picked up your order.",
      },
      "Delivered": {
        title: `Delivered! ${EMOJI.SUCCESS}`,
        body:  "Your order has arrived. Enjoy your meal!",
      },
    };
 
    const msg = messages[status];
    if (msg) {
      const userDoc = await db.collection("users").doc(userID).get();
      const user    = userDoc.data()!;
      await notifyUser(
        userID,
        user.fcmToken,
        msg.title,
        msg.body,
        "order",
        { type: "ORDER_STATUS", orderID, status }
      );
    }
 
    // Free up rider on delivery completion
    if (status === "Delivered") {
      const riderUID = after.riderUID as string | undefined;
      if (riderUID) {
        await db.collection("riders").doc(riderUID).update({
          hasActiveOrder:  false,
          currentOrderID:  null,
          lastSeenAt:      FieldValue.serverTimestamp(),
        });
      }
    }
  }
);

export const onRiderLocationUpdate = fsEvents.onDocumentUpdated(
  { document: "riders/{riderUID}", region: REGION, secrets: [googleMapsKey] },
  async (event) => {
    const before = event.data?.before.data();
    const after  = event.data?.after.data();
    if (!before || !after) return;
    if (!after.location) return;
    if (before.locationUpdatedAt?.isEqual(after.locationUpdatedAt)) return;
    if (!after.hasActiveOrder || !after.currentOrderID) return;
 
    const orderID  = after.currentOrderID as string;
    const riderLat = after.location.lat   as number;
    const riderLng = after.location.lng   as number;
 
    const orderDoc = await db.collection("orders").doc(orderID).get();
    if (!orderDoc.exists) return;
    const order = orderDoc.data()!;
 
    const isToPickup = order.status === "In Progress";
    const targetLat  = isToPickup
      ? (order.restaurantLat ?? 0)
      : parseFloat(order.address?.lat ?? "0");
    const targetLng  = isToPickup
      ? (order.restaurantLng ?? 0)
      : parseFloat(order.address?.lng ?? "0");
 
    const directions = await getDirections(
      riderLat, riderLng,
      targetLat, targetLng,
      googleMapsKey.value(),
      "driving"
    );
    if (!directions) return;
 
    const durationMinutes = Math.ceil(directions.durationSeconds / 60);
    const bufferMin       = isToPickup ? 2 : 3;
 
    await db.collection("orders").doc(orderID).update({
      eta: {
        minMinutes: Math.max(1, durationMinutes - 1),
        maxMinutes: durationMinutes + bufferMin,
        updatedAt:  FieldValue.serverTimestamp(),
        source:     "GOOGLE_DIRECTIONS",
      },
    });
  }
);

// ALL APPS — Save FCM token
// Called by customer app (role: 'user') and rider app (role: 'rider') on launch
export const saveFcmToken = https.onCall(
  { region: REGION, enforceAppCheck: APP_CHECK },
  async (req) => {
    if (!req.auth) return { success: false };
    const { token, role } = req.data;
    if (!token) {
      throw new https.HttpsError("invalid-argument", "token required");
    }
    const collection = role === "rider" ? "riders" : "users";
    await db.collection(collection).doc(req.auth.uid).set(
      { fcmToken: token, fcmUpdatedAt: FieldValue.serverTimestamp() },
      { merge: true }
    );
    return { success: true };
  }
);