"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.saveFcmToken = exports.onRiderLocationUpdate = exports.onOrderStatusChanged = exports.onDispatchJobAccepted = exports.stripeWebhook = exports.placeOrder = exports.getPaymentMethodType = exports.createPaymentIntent = exports.googleMapsDetails = exports.googleMapsAutocomplete = void 0;
const https = require("firebase-functions/v2/https");
const fsEvents = require("firebase-functions/v2/firestore");
const params_1 = require("firebase-functions/params");
const admin = require("firebase-admin");
const stripe_1 = require("stripe");
const axios_1 = require("axios");
admin.initializeApp();
const db = admin.firestore();
// Secrets (Firebase Secret Manager)
const stripeSecretKey = (0, params_1.defineSecret)("STRIPE_SECRET_KEY");
const stripePublishableKey = (0, params_1.defineSecret)("STRIPE_PUBLISHABLE_KEY");
const stripeWebhookSecret = (0, params_1.defineSecret)("STRIPE_WEBHOOK_SECRET");
const googleMapsKey = (0, params_1.defineSecret)("GOOGLE_MAPS_KEY");
const REGION = "europe-west1";
const APP_CHECK = false;
/* ---------------------------------------------- */
/* -------------- Helper Functions --------------
/* ----------------------------------------------*/
const getStripe = () => new stripe_1.default(stripeSecretKey.value(), { apiVersion: "2023-10-16" });
function haversineKm(lat1, lng1, lat2, lng2) {
    const R = 6371;
    const dLat = ((lat2 - lat1) * Math.PI) / 180;
    const dLng = ((lng2 - lng1) * Math.PI) / 180;
    const a = Math.sin(dLat / 2) ** 2 +
        Math.cos((lat1 * Math.PI) / 180) *
            Math.cos((lat2 * Math.PI) / 180) *
            Math.sin(dLng / 2) ** 2;
    return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
}
async function getDirections(fromLat, fromLng, toLat, toLng, mapsKey, mode = "driving") {
    try {
        const { data } = await axios_1.default.get("https://maps.googleapis.com/maps/api/directions/json", {
            params: {
                origin: `${fromLat},${fromLng}`,
                destination: `${toLat},${toLng}`,
                mode,
                key: mapsKey,
            },
        });
        if (data.status !== "OK")
            return null;
        const leg = data.routes[0].legs[0];
        return {
            durationSeconds: leg.duration.value,
            polyline: data.routes[0].overview_polyline.points,
        };
    }
    catch {
        return null;
    }
}
// Write in-app notification
async function writeNotification(uid, title, body, source) {
    await db
        .collection("users")
        .doc(uid)
        .collection("notifications")
        .add({
        title,
        body,
        source,
        isRead: false,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });
}
// FCM push + in-app notification
async function notifyUser(uid, fcmToken, title, body, source, data) {
    await writeNotification(uid, title, body, source);
    if (fcmToken) {
        try {
            await admin.messaging().send({
                token: fcmToken,
                notification: { title, body },
                data: data ?? {},
                android: { priority: "high" },
                apns: { payload: { aps: { sound: "default", badge: 1 } } },
            });
        }
        catch (e) {
            console.warn("FCM send failed for", uid, e);
        }
    }
}
async function createOrderAndDispatch({ quoteId, userId, restaurantID, paymentMethod, paymentDetails, }) {
    const [quoteDoc, userDoc, restaurantDoc] = await Promise.all([
        db.collection("quotes").doc(quoteId).get(),
        db.collection("users").doc(userId).get(),
        db.collection("restaurants").doc(restaurantID).get(),
    ]);
    if (!quoteDoc.exists)
        throw new Error("Quote not found: " + quoteId);
    const quote = quoteDoc.data();
    const user = userDoc.data();
    const restaurant = restaurantDoc.data();
    const orderID = db.collection("orders").doc().id;
    const orderRef = db.collection("orders").doc(orderID);
    const userOrderRef = db
        .collection("users")
        .doc(userId)
        .collection("orders")
        .doc(orderID);
    // Status flow:
    //   Pending     -> restaurant sees new order
    //   In Progress -> rider assigned, heading to restaurant
    //   Ready       -> rider picked up, heading to customer
    //   Delivered   -> complete
    // Resolve address from users/{uid}/addresses/{addressID}
    // The client only sends addressID — full address data lives 
    let resolvedAddress = {};
    if (quote.orderType !== "pickup" && quote.addressID) {
        const addrDoc = await db
            .collection("users")
            .doc(userId)
            .collection("addresses")
            .doc(quote.addressID)
            .get();
        if (addrDoc.exists) {
            resolvedAddress = { ...addrDoc.data(), addressID: quote.addressID };
        }
    }
    else if (quote.orderType === "pickup") {
        resolvedAddress = { type: "pickup" };
    }
    const orderData = {
        orderID,
        userID: userId,
        restaurantID,
        restaurantName: restaurant.name ?? "",
        restaurantLat: restaurant.lat ?? null,
        restaurantLng: restaurant.lng ?? null,
        itemIDs: quote.itemIDs ?? [],
        address: resolvedAddress, // full address resolved server-side
        addressID: quote.addressID ?? null,
        orderType: quote.orderType ?? "delivery",
        paymentMethod,
        paymentDetails,
        subtotal: String(quote.itemsTotal ?? "0.00"),
        deliveryFee: String(quote.deliveryFee ?? "0.00"),
        totalAmount: String(quote.finalTotal ?? "0.00"),
        status: "Pending",
        isSuccess: true,
        driverUID: "",
        orderTime: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };
    const batch = db.batch();
    batch.set(orderRef, orderData);
    batch.set(userOrderRef, orderData);
    batch.update(db.collection("quotes").doc(quoteId), {
        status: "USED",
        orderID,
        paymentStatus: paymentMethod === "stripe" ? "PAID" : "PENDING_COD",
    });
    await batch.commit();
    // Notify restaurant
    if (restaurant.fcmToken) {
        try {
            const cashLabel = paymentMethod === "cash" ? " 💵 Cash" : "";
            await admin.messaging().send({
                token: restaurant.fcmToken,
                notification: {
                    title: "🔔 New Order!",
                    body: `Order #${orderID.slice(0, 8)} received${cashLabel}`,
                },
                data: { type: "NEW_ORDER", orderID },
                android: { priority: "high" },
            });
        }
        catch (e) {
            console.warn("Restaurant FCM failed", e);
        }
    }
    // In-app notification for customer
    await writeNotification(userId, "Order Placed! 🎉", `Your order from ${restaurant.name ?? "the restaurant"} has been received.`, "order");
    await dispatchToRider(orderID, orderData, restaurant, user);
    return orderID;
}
async function dispatchToRider(orderID, order, restaurant, customer) {
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
    // MVP: first available rider
    // V2: sort by distance to restaurant using riders/{uid}.location
    const riderDoc = ridersSnap.docs[0];
    const rider = riderDoc.data();
    const pickupLat = restaurant.lat ?? 0;
    const pickupLng = restaurant.lng ?? 0;
    const dropoffLat = parseFloat(order.address?.lat?.toString() ?? order.address?.latitude?.toString() ?? "0");
    const dropoffLng = parseFloat(order.address?.lng?.toString() ?? order.address?.longitude?.toString() ?? "0");
    const distanceKm = haversineKm(pickupLat, pickupLng, dropoffLat, dropoffLng);
    const deliveryFee = parseFloat(order.deliveryFee ?? "0");
    const riderEarnings = parseFloat(Math.max(3.5, deliveryFee * 0.75).toFixed(2));
    const isCash = (order.paymentMethod ?? "cash") === "cash";
    await db.collection("dispatch_jobs").doc().set({
        riderId: riderDoc.id,
        orderID,
        storeName: restaurant.name ?? "",
        storeAddress: restaurant.address ?? "",
        customerAddress: order.address?.fullAddress ?? "",
        customerName: customer.name ?? "",
        items: [],
        finalTotal: parseFloat(order.totalAmount ?? "0"),
        deliveryFee,
        riderEarnings,
        distanceKm: Math.round(distanceKm * 10) / 10,
        paymentMethod: order.paymentMethod ?? "cash",
        orderType: order.orderType ?? "delivery",
        collectPayment: isCash, // rider must collect cash from customer
        status: "pending",
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        expiresAt: admin.firestore.Timestamp.fromDate(new Date(Date.now() + 30000)),
    });
    if (rider.fcmToken) {
        try {
            const paymentLabel = isCash ? "💵 Collect cash" : "✅ Card paid";
            await admin.messaging().send({
                token: rider.fcmToken,
                notification: {
                    title: "🛵 New Delivery!",
                    body: `${restaurant.name ?? "Restaurant"} · zł${riderEarnings} · ${paymentLabel}`,
                },
                data: { type: "DISPATCH_JOB", orderID },
                android: { priority: "high" },
                apns: { payload: { aps: { sound: "default", badge: 1 } } },
            });
        }
        catch (e) {
            console.warn("Rider FCM failed", e);
        }
    }
}
/* ---------------------------------------------- */
/* ---------- Used by the Merchant App ----------
/* ----------------------------------------------*/
/* Address autocomplete for the merchant app settings screen. */
exports.googleMapsAutocomplete = https.onRequest({ region: REGION, secrets: [googleMapsKey], cors: true }, async (req, res) => {
    const input = req.query.input;
    if (!input) {
        res.status(400).json({ error: "Missing input parameter" });
        return;
    }
    try {
        const url = `https://maps.googleapis.com/maps/api/place/autocomplete/json` +
            `?input=${encodeURIComponent(input)}&key=${googleMapsKey.value()}`;
        const response = await fetch(url);
        const data = await response.json();
        res.status(200).json(data);
    }
    catch (error) {
        console.error("Autocomplete Error:", error);
        res.status(500).json({ error: "Failed to fetch autocomplete data" });
    }
});
/* Function for getting the (lat/lng) of a given place chosen by the user (Web) */
exports.googleMapsDetails = https.onRequest({ region: REGION, secrets: [googleMapsKey], cors: true }, async (req, res) => {
    const placeId = req.query.placeId;
    if (!placeId) {
        res.status(400).json({ error: "Missing placeId parameter" });
        return;
    }
    try {
        const url = `https://maps.googleapis.com/maps/api/place/details/json` +
            `?place_id=${placeId}&key=${googleMapsKey.value()}`;
        const response = await fetch(url);
        const data = await response.json();
        res.status(200).json(data);
    }
    catch (error) {
        console.error("Details Error:", error);
        res.status(500).json({ error: "Failed to fetch place details" });
    }
});
/* ---------------------------------------------- */
/* ---------- Used by the Customer App ----------
/* ----------------------------------------------*/
/* Creates Payment Intent for Stripe transactions */
exports.createPaymentIntent = https.onCall({ region: REGION, secrets: [stripeSecretKey, stripePublishableKey], enforceAppCheck: APP_CHECK }, async (req) => {
    if (!req.auth)
        throw new https.HttpsError("unauthenticated", "Login required");
    const { quoteId } = req.data;
    if (!quoteId)
        throw new https.HttpsError("invalid-argument", "quoteId required");
    const quoteDoc = await db.collection("quotes").doc(quoteId).get();
    if (!quoteDoc.exists)
        throw new https.HttpsError("not-found", "Quote not found");
    const quote = quoteDoc.data();
    if (quote.userId !== req.auth.uid)
        throw new https.HttpsError("permission-denied", "Not your quote");
    if (quote.expiresAt.toDate() < new Date())
        throw new https.HttpsError("failed-precondition", "Quote expired");
    const stripe = getStripe();
    const amountInGrosze = Math.round(quote.finalTotal * 100);
    try {
        const paymentIntent = await stripe.paymentIntents.create({
            amount: amountInGrosze,
            currency: "pln",
            metadata: {
                quoteId,
                userId: req.auth.uid,
                restaurantID: quote.restaurantID,
            },
            automatic_payment_methods: { enabled: true },
        });
        await db.collection("quotes").doc(quoteId).update({
            stripePaymentIntentId: paymentIntent.id,
            paymentStatus: "PENDING",
        });
        return {
            clientSecret: paymentIntent.client_secret,
            paymentIntentId: paymentIntent.id,
            publishableKey: stripePublishableKey.value()
        };
    }
    catch (error) {
        console.error("Stripe Error:", error);
        throw new https.HttpsError("internal", error.message);
    }
});
/* Gets Paymnet Methods (credit card/blik) after successfull transaction in Stripe */
exports.getPaymentMethodType = https.onCall({ region: REGION, secrets: [stripeSecretKey], enforceAppCheck: APP_CHECK }, async (req) => {
    const { paymentIntentId } = req.data;
    if (!paymentIntentId || typeof paymentIntentId !== "string")
        throw new https.HttpsError("invalid-argument", "paymentIntendId is required and must be a string");
    const stripe = getStripe();
    try {
        const paymentIntent = await stripe.paymentIntents.retrieve(paymentIntentId, {
            expand: ["payment_method"],
        });
        if (!paymentIntent) {
            throw new https.HttpsError("not-found", "PaymentIntent not found");
        }
        const paymentMethod = paymentIntent.payment_method;
        return {
            paymentMethodType: paymentMethod?.type ?? "unknown",
            status: paymentIntent.status,
        };
    }
    catch (error) {
        console.error("getPaymentMethodType error:", error);
        throw new https.HttpsError("internal", error.message);
    }
});
/**
 * Places a cash-on-delivery order. Identical order structure to Stripe flow.
 * The dispatch job is flagged collectPayment: true so the rider knows to
 * collect cash from the customer.
 */
exports.placeOrder = https.onCall({ region: REGION, enforceAppCheck: APP_CHECK }, async (req) => {
    const { data, auth } = req;
    if (!req.auth) {
        throw new https.HttpsError("unauthenticated", "Login required");
    }
    const { quoteId } = req.data;
    if (!quoteId) {
        throw new https.HttpsError("invalid-argument", "quoteId required");
    }
    const quoteDoc = await db.collection("quotes").doc(quoteId).get();
    if (!quoteDoc.exists) {
        throw new https.HttpsError("not-found", "Quote not found");
    }
    const quote = quoteDoc.data();
    if (quote.status === "USED") {
        throw new https.HttpsError("already-exists", "Order already placed for this quote");
    }
    const orderID = await createOrderAndDispatch({
        quoteId,
        userId: req.auth.uid,
        restaurantID: quote.restaurantID,
        paymentMethod: "cash",
        paymentDetails: "cash",
    });
    return { success: true, orderID };
});
exports.stripeWebhook = https.onRequest({ region: REGION, secrets: [stripeSecretKey, stripeWebhookSecret] }, async (req, res) => {
    const sig = req.headers["stripe-signature"];
    let event;
    try {
        const stripe = new stripe_1.default(stripeSecretKey.value(), { apiVersion: "2023-10-16" });
        event = stripe.webhooks.constructEvent(req.rawBody, sig, stripeWebhookSecret.value());
    }
    catch (err) {
        console.error("Webhook signature failed:", err);
        res.status(400).send("Invalid signature");
        return;
    }
    if (event.type === "payment_intent.succeeded") {
        const pi = event.data.object;
        await handlePaymentSuccess(pi);
    }
    res.json({ received: true });
});
async function handlePaymentSuccess(paymentIntent) {
    const { quoteId, userId, restaurantID } = paymentIntent.metadata;
    const existing = await db
        .collection("orders")
        .where("stripePaymentIntentId", "==", paymentIntent.id)
        .limit(1)
        .get();
    if (!existing.empty) {
        console.log("Order already created for PI:", paymentIntent.id);
        return;
    }
    await createOrderAndDispatch({
        quoteId,
        userId,
        restaurantID,
        paymentMethod: "stripe",
        paymentDetails: paymentIntent.id,
    });
}
/* ---------------------------------------------- */
/* ------------ Used by the Rider App -----------
/* ----------------------------------------------*/
// Trigger: dispatch_jobs/{id}.status → 'accepted'
// sets order to 'In Progress', marks rider busy, notifies customer
// 
exports.onDispatchJobAccepted = fsEvents.onDocumentUpdated({ document: "dispatch_jobs/{jobId}", region: REGION }, async (event) => {
    const before = event.data?.before.data();
    const after = event.data?.after.data();
    if (!before || !after)
        return;
    if (before.status === after.status)
        return;
    if (after.status !== "accepted")
        return;
    const { riderId, orderID } = after;
    const orderDoc = await db.collection("orders").doc(orderID).get();
    if (!orderDoc.exists)
        return;
    const orderData = orderDoc.data();
    const userID = orderData.userID;
    const orderUpdate = {
        status: "In Progress",
        driverUID: riderId,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };
    const batch = db.batch();
    batch.update(db.collection("orders").doc(orderID), orderUpdate);
    batch.update(db.collection("users").doc(userID).collection("orders").doc(orderID), orderUpdate);
    // Mark rider busy — matches RiderModel fields
    batch.update(db.collection("riders").doc(riderId), {
        hasActiveOrder: true,
        currentOrderID: orderID,
        lastSeenAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    await batch.commit();
    // Notify customer
    const userDoc = await db.collection("users").doc(userID).get();
    const user = userDoc.data();
    await notifyUser(userID, user.fcmToken, "Rider on the way! 🛵", "Your rider is heading to the restaurant.", "order", { type: "ORDER_STATUS", orderID, status: "In Progress" });
});
exports.onOrderStatusChanged = fsEvents.onDocumentUpdated({ document: "orders/{orderID}", region: REGION }, async (event) => {
    const before = event.data?.before.data();
    const after = event.data?.after.data();
    if (!before || !after)
        return;
    if (before.status === after.status)
        return;
    const orderID = event.params.orderID;
    const userID = after.userID;
    const status = after.status;
    const messages = {
        "In Progress": {
            title: "Order Accepted ✅",
            body: "The restaurant is preparing your order.",
        },
        "Ready": {
            title: "On the Way! 🛵",
            body: "Your rider has picked up your order.",
        },
        "Delivered": {
            title: "Delivered! 🎉",
            body: "Your order has arrived. Enjoy your meal!",
        },
    };
    const msg = messages[status];
    if (msg) {
        const userDoc = await db.collection("users").doc(userID).get();
        const user = userDoc.data();
        await notifyUser(userID, user.fcmToken, msg.title, msg.body, "order", { type: "ORDER_STATUS", orderID, status });
    }
    // Free up rider on delivery completion
    if (status === "Delivered") {
        const driverUID = after.driverUID;
        if (driverUID) {
            await db.collection("riders").doc(driverUID).update({
                hasActiveOrder: false,
                currentOrderID: null,
                lastSeenAt: admin.firestore.FieldValue.serverTimestamp(),
            });
        }
    }
});
exports.onRiderLocationUpdate = fsEvents.onDocumentUpdated({ document: "riders/{riderUID}", region: REGION, secrets: [googleMapsKey] }, async (event) => {
    const before = event.data?.before.data();
    const after = event.data?.after.data();
    if (!before || !after)
        return;
    if (!after.location)
        return;
    if (before.locationUpdatedAt?.isEqual(after.locationUpdatedAt))
        return;
    if (!after.hasActiveOrder || !after.currentOrderID)
        return;
    const orderID = after.currentOrderID;
    const riderLat = after.location.lat;
    const riderLng = after.location.lng;
    const orderDoc = await db.collection("orders").doc(orderID).get();
    if (!orderDoc.exists)
        return;
    const order = orderDoc.data();
    const isToPickup = order.status === "In Progress";
    const targetLat = isToPickup
        ? (order.restaurantLat ?? 0)
        : parseFloat(order.address?.lat ?? "0");
    const targetLng = isToPickup
        ? (order.restaurantLng ?? 0)
        : parseFloat(order.address?.lng ?? "0");
    const directions = await getDirections(riderLat, riderLng, targetLat, targetLng, googleMapsKey.value(), "driving");
    if (!directions)
        return;
    const durationMinutes = Math.ceil(directions.durationSeconds / 60);
    const bufferMin = isToPickup ? 2 : 3;
    await db.collection("orders").doc(orderID).update({
        eta: {
            minMinutes: Math.max(1, durationMinutes - 1),
            maxMinutes: durationMinutes + bufferMin,
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
            source: "GOOGLE_DIRECTIONS",
        },
    });
});
// ALL APPS — Save FCM token
// Called by customer app (role: 'user') and rider app (role: 'rider') on launch
exports.saveFcmToken = https.onCall({ region: REGION, enforceAppCheck: APP_CHECK }, async (req) => {
    if (!req.auth)
        return { success: false };
    const { token, role } = req.data;
    if (!token) {
        throw new https.HttpsError("invalid-argument", "token required");
    }
    const collection = role === "rider" ? "riders" : "users";
    await db.collection(collection).doc(req.auth.uid).set({ fcmToken: token, fcmUpdatedAt: admin.firestore.FieldValue.serverTimestamp() }, { merge: true });
    return { success: true };
});
//# sourceMappingURL=index.js.map