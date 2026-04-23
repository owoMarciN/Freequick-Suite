"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.saveFcmToken = exports.onRiderLocationUpdate = exports.onOrderStatusChanged = exports.onDispatchJobAccepted = exports.stripeWebhook = exports.placeOrder = exports.getPaymentMethodType = exports.createPaymentIntent = exports.googleMapsDetails = exports.googleMapsAutocomplete = exports.sendAdminNotification = void 0;
const https = __importStar(require("firebase-functions/v2/https"));
const fsEvents = __importStar(require("firebase-functions/v2/firestore"));
const params_1 = require("firebase-functions/params");
const firestore_1 = require("firebase-admin/firestore");
const admin = __importStar(require("firebase-admin"));
const stripe_1 = __importDefault(require("stripe"));
const axios_1 = __importDefault(require("axios"));
const emoji = __importStar(require("node-emoji"));
admin.initializeApp();
const db = admin.firestore();
// === Secrets (Firebase Secret Manager) =======================================
// These are stored securely in Google Secret Manager and injected at runtime.
// Set them via: firebase functions:secrets:set SECRET_NAME
const stripeSecretKey = (0, params_1.defineSecret)("STRIPE_SECRET_KEY");
const stripePublishableKey = (0, params_1.defineSecret)("STRIPE_PUBLISHABLE_KEY");
const stripeWebhookSecret = (0, params_1.defineSecret)("STRIPE_WEBHOOK_SECRET");
const googleMapsKey = (0, params_1.defineSecret)("GOOGLE_MAPS_KEY");
const REGION = "europe-west1";
const APP_CHECK = false;
// === Emoji Definitions ========================================================
// Centralised emoji references used in push notification titles/bodies.
// Using node-emoji to ensure consistent rendering across platforms.
const EMOJI = {
    CASH: emoji.get('dollar'),
    CHECK: emoji.get('white_check_mark'),
    SUCCESS: emoji.get('tada'),
    BELL: emoji.get('bell'),
    SCOOTER: emoji.get('motor_scooter'),
    STORE: emoji.get('convenience_store'),
};
const MESSAGES = {
    en: {
        order_placed_title: `Order Placed! ${EMOJI.SUCCESS}`,
        order_placed_body: "Your order from {restaurant} has been received.",
        order_accepted_title: `Order Accepted ${EMOJI.CHECK}`,
        order_accepted_body: "The restaurant is preparing your order.",
        order_accepted_pickup_body: "The restaurant is preparing your order. We'll notify you when it's ready.",
        rider_on_way_title: `Rider on the way! ${EMOJI.SCOOTER}`,
        rider_on_way_body: "Your rider is heading to the restaurant.",
        food_ready_title: "Food is Ready!",
        food_ready_body: "The restaurant has finished your order. Your rider will pick it up shortly.",
        ready_for_pickup_title: `Ready for Collection! ${EMOJI.STORE}`,
        ready_for_pickup_body: "Your order is ready. See you soon!",
        delivered_title: `Delivered! ${EMOJI.SUCCESS}`,
        delivered_body: "Your order has arrived!",
        pickup_collected_title: `Enjoy! ${EMOJI.SUCCESS}`,
        pickup_collected_body: "Order collected. Enjoy your meal!",
        new_order_title: `${EMOJI.BELL} New Order!`,
        new_order_body: "Order #{id} received.",
        order_ready_rider_title: `Order Ready for Pickup ${EMOJI.STORE}`,
        order_ready_rider_body: "{restaurant} has the order ready.",
        new_delivery_title: `${EMOJI.SCOOTER} New Delivery!`,
        new_delivery_body: "{restaurant} · zł{earnings} · {payment}",
        admin_notif_default_title: "New Notification",
        admin_notif_default_body: "You have a new message from the platform.",
    },
    pl: {
        order_placed_title: `Zamówienie złożone! ${EMOJI.SUCCESS}`,
        order_placed_body: "Twoje zamówienie z {restaurant} zostało przyjęte.",
        order_accepted_title: `Zamówienie przyjęte ${EMOJI.CHECK}`,
        order_accepted_body: "Restauracja przygotowuje Twoje zamówienie.",
        order_accepted_pickup_body: "Restauracja przygotowuje Twoje zamówienie. Powiadomimy Cię gdy będzie gotowe.",
        rider_on_way_title: `Kurier w drodze! ${EMOJI.SCOOTER}`,
        rider_on_way_body: "Kurier jedzie do restauracji.",
        food_ready_title: "Jedzenie gotowe!",
        food_ready_body: "Restauracja skończyła Twoje zamówienie. Kurier wkrótce je odbierze.",
        ready_for_pickup_title: `Gotowe do odbioru! ${EMOJI.STORE}`,
        ready_for_pickup_body: "Twoje zamówienie jest gotowe. Do zobaczenia!",
        delivered_title: `Dostarczone! ${EMOJI.SUCCESS}`,
        delivered_body: "Twoje zamówienie dotarło!",
        pickup_collected_title: `Smacznego! ${EMOJI.SUCCESS}`,
        pickup_collected_body: "Zamówienie odebrane. Smacznego!",
        new_order_title: `${EMOJI.BELL} Nowe zamówienie!`,
        new_order_body: "Zamówienie #{id} otrzymane.",
        order_ready_rider_title: `Zamówienie gotowe do odbioru ${EMOJI.STORE}`,
        order_ready_rider_body: "{restaurant} ma gotowe zamówienie.",
        new_delivery_title: `${EMOJI.SCOOTER} Nowa dostawa!`,
        new_delivery_body: "{restaurant} · zł{earnings} · {payment}",
        admin_notif_default_title: "Nowe powiadomienie",
        admin_notif_default_body: "Masz nową wiadomość od platformy.",
    },
    uk: {
        order_placed_title: `Замовлення оформлено! ${EMOJI.SUCCESS}`,
        order_placed_body: "Ваше замовлення з {restaurant} отримано.",
        order_accepted_title: `Замовлення прийнято ${EMOJI.CHECK}`,
        order_accepted_body: "Ресторан готує ваше замовлення.",
        order_accepted_pickup_body: "Ресторан готує ваше замовлення. Ми повідомимо, коли воно буде готове.",
        rider_on_way_title: `Курʼєр у дорозі! ${EMOJI.SCOOTER}`,
        rider_on_way_body: "Курʼєр прямує до ресторану.",
        food_ready_title: "Їжа готова!",
        food_ready_body: "Ресторан завершив ваше замовлення. Курʼєр незабаром його забере.",
        ready_for_pickup_title: `Готово до отримання! ${EMOJI.STORE}`,
        ready_for_pickup_body: "Ваше замовлення готове. До зустрічі!",
        delivered_title: `Доставлено! ${EMOJI.SUCCESS}`,
        delivered_body: "Ваше замовлення доставлено!",
        pickup_collected_title: `Смачного! ${EMOJI.SUCCESS}`,
        pickup_collected_body: "Замовлення отримано. Смачного!",
        new_order_title: `${EMOJI.BELL} Нове замовлення!`,
        new_order_body: "Замовлення #{id} отримано.",
        order_ready_rider_title: `Замовлення готове до видачі ${EMOJI.STORE}`,
        order_ready_rider_body: "{restaurant} підготував замовлення.",
        new_delivery_title: `${EMOJI.SCOOTER} Нова доставка!`,
        new_delivery_body: "{restaurant} · zł{earnings} · {payment}",
        admin_notif_default_title: "Нове сповіщення",
        admin_notif_default_body: "У вас нове повідомлення від платформи.",
    },
    de: {
        order_placed_title: `Bestellung aufgegeben! ${EMOJI.SUCCESS}`,
        order_placed_body: "Deine Bestellung bei {restaurant} wurde erhalten.",
        order_accepted_title: `Bestellung bestätigt ${EMOJI.CHECK}`,
        order_accepted_body: "Das Restaurant bereitet deine Bestellung vor.",
        order_accepted_pickup_body: "Das Restaurant bereitet deine Bestellung vor. Wir benachrichtigen dich, wenn sie fertig ist.",
        rider_on_way_title: `Fahrer unterwegs! ${EMOJI.SCOOTER}`,
        rider_on_way_body: "Der Fahrer ist auf dem Weg zum Restaurant.",
        food_ready_title: "Essen fertig!",
        food_ready_body: "Das Restaurant hat deine Bestellung fertiggestellt. Der Fahrer holt sie gleich ab.",
        ready_for_pickup_title: `Abholbereit! ${EMOJI.STORE}`,
        ready_for_pickup_body: "Deine Bestellung ist bereit. Bis gleich!",
        delivered_title: `Geliefert! ${EMOJI.SUCCESS}`,
        delivered_body: "Deine Bestellung ist angekommen!",
        pickup_collected_title: `Guten Appetit! ${EMOJI.SUCCESS}`,
        pickup_collected_body: "Bestellung abgeholt. Guten Appetit!",
        new_order_title: `${EMOJI.BELL} Neue Bestellung!`,
        new_order_body: "Bestellung #{id} erhalten.",
        order_ready_rider_title: `Bestellung abholbereit ${EMOJI.STORE}`,
        order_ready_rider_body: "{restaurant} hat die Bestellung fertig.",
        new_delivery_title: `${EMOJI.SCOOTER} Neue Lieferung!`,
        new_delivery_body: "{restaurant} · zł{earnings} · {payment}",
        admin_notif_default_title: "Neue Benachrichtigung",
        admin_notif_default_body: "Du hast eine neue Nachricht von der Plattform.",
    },
    ko: {
        order_placed_title: `주문 완료! ${EMOJI.SUCCESS}`,
        order_placed_body: "{restaurant}에서 주문이 접수되었습니다.",
        order_accepted_title: `주문 승인됨 ${EMOJI.CHECK}`,
        order_accepted_body: "레스토랑에서 주문을 준비 중입니다.",
        order_accepted_pickup_body: "레스토랑에서 주문을 준비 중입니다. 준비가 완료되면 알려드립니다.",
        rider_on_way_title: `배달 중! ${EMOJI.SCOOTER}`,
        rider_on_way_body: "라이더가 레스토랑으로 이동 중입니다.",
        food_ready_title: "음식 준비 완료!",
        food_ready_body: "레스토랑에서 주문을 완료했습니다. 곧 픽업됩니다.",
        ready_for_pickup_title: `픽업 준비 완료! ${EMOJI.STORE}`,
        ready_for_pickup_body: "주문이 준비되었습니다. 곧 뵙겠습니다!",
        delivered_title: `배달 완료! ${EMOJI.SUCCESS}`,
        delivered_body: "주문이 도착했습니다!",
        pickup_collected_title: `맛있게 드세요! ${EMOJI.SUCCESS}`,
        pickup_collected_body: "주문이 픽업되었습니다. 맛있게 드세요!",
        new_order_title: `${EMOJI.BELL} 신규 주문!`,
        new_order_body: "주문 #{id} 접수됨.",
        order_ready_rider_title: `픽업 준비 완료 ${EMOJI.STORE}`,
        order_ready_rider_body: "{restaurant}에서 주문이 준비되었습니다.",
        new_delivery_title: `${EMOJI.SCOOTER} 신규 배달!`,
        new_delivery_body: "{restaurant} · zł{earnings} · {payment}",
        admin_notif_default_title: "새 알림",
        admin_notif_default_body: "플랫폼에서 새 메시지가 있습니다.",
    },
};
/**
 * Translates a message key into the user's language.
 *
 * @param locale   - BCP-47 language code stored in the user's Firestore doc ('en', 'pl', etc.)
 * @param key      - One of the MessageKey union type values
 * @param vars     - Optional interpolation variables, e.g. { restaurant: "Pizza Palace" }
 *                   Placeholders in message strings use the format {varName}
 * @returns        - Translated string with all placeholders replaced
 *
 * Falls back to English if the locale is unsupported or the key is missing.
 *
 * Example:
 *   t('pl', 'order_placed_body', { restaurant: 'Pizza Palace' })
 *   → "Twoje zamówienie z Pizza Palace zostało przyjęte."
 */
function t(locale, key, vars) {
    const lang = MESSAGES[locale ?? 'en'] ?? MESSAGES['en'];
    let str = lang[key] ?? MESSAGES['en'][key] ?? key;
    if (vars) {
        Object.entries(vars).forEach(([k, v]) => {
            str = str.replace(`{${k}}`, v);
        });
    }
    return str;
}
/**
 * Reads the preferred locale of a user from their Firestore document.
 * Used before sending push notifications to ensure the message is in
 * the correct language.
 *
 * @param uid - Firebase Auth UID of the user
 * @returns   - Locale code string ('en', 'pl', etc.), defaults to 'en'
 */
async function getUserLocale(uid) {
    try {
        const doc = await db.collection("users").doc(uid).get();
        return doc.data()?.locale ?? 'en';
    }
    catch {
        return 'en';
    }
}
// /**
//  * Reads the preferred locale of a rider from their Firestore document.
//  * Separate from getUserLocale because riders are stored in the 'riders'
//  * collection, not 'users'.
//  *
//  * @param uid - Firebase Auth UID of the rider
//  * @returns   - Locale code string ('en', 'pl', etc.), defaults to 'en'
//  */
// async function getRiderLocale(uid: string): Promise<string> {
//   try {
//     const doc = await db.collection("riders").doc(uid).get();
//     return (doc.data()?.locale as string) ?? 'en';
//   } catch {
//     return 'en';
//   }
// }
// === Helper Functions =========================================================
/**
 * Returns a configured Stripe instance using the secret key from Secret Manager.
 * Called lazily (not at module load time) so the secret is always available.
 */
const getStripe = () => new stripe_1.default(stripeSecretKey.value(), { apiVersion: "2023-10-16" });
/**
 * Rounds a number to 2 decimal places using banker's rounding.
 * Used for all monetary calculations to avoid floating point drift.
 *
 * @param num - Number, string, or undefined value to round
 * @returns   - Rounded number, or 0 if input is null/undefined
 */
function roundToTwo(num) {
    if (num === undefined || num === null)
        return 0;
    return Math.round(Number(num) * 100) / 100;
}
/**
 * Calculates the straight-line distance between two GPS coordinates using
 * the Haversine formula. Used to estimate delivery distance for dispatch jobs.
 *
 * @param lat1 - Latitude of point A (restaurant)
 * @param lng1 - Longitude of point A
 * @param lat2 - Latitude of point B (customer)
 * @param lng2 - Longitude of point B
 * @returns    - Distance in kilometres
 */
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
/**
 * Fetches turn-by-turn directions from the Google Maps Directions API.
 * Used by onRiderLocationUpdate to calculate live ETA for the customer.
 *
 * @param fromLat  - Rider's current latitude
 * @param fromLng  - Rider's current longitude
 * @param toLat    - Destination latitude (restaurant for pickup leg, customer for dropoff)
 * @param toLng    - Destination longitude
 * @param mapsKey  - Google Maps API key from Secret Manager
 * @param mode     - Travel mode: 'driving' (default) or 'bicycling'
 * @returns        - Object with durationSeconds and encoded polyline, or null on failure
 */
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
/**
 * Writes an in-app notification document to a user's or rider's
 * notifications subcollection in Firestore.
 *
 * This is always called — even when FCM push fails — so that the
 * notification appears in the in-app notification centre.
 *
 * @param uid            - Firebase Auth UID of the recipient
 * @param collectionName - 'users' for customers/restaurants, 'riders' for riders
 * @param title          - Notification title (already translated)
 * @param body           - Notification body (already translated)
 * @param source         - Category tag used by the app to filter/display notifications
 */
async function writeNotification(uid, collectionName, title, body, source) {
    await db
        .collection(collectionName)
        .doc(uid)
        .collection("notifications")
        .add({
        title,
        body,
        source,
        isRead: false,
        timestamp: firestore_1.FieldValue.serverTimestamp(),
    });
}
/**
 * Sends a push notification via FCM and writes an in-app notification
 * to Firestore. This is the primary notification function used throughout
 * the codebase.
 *
 * FCM delivery is best-effort — if the token is missing or FCM fails,
 * the in-app notification is still written. FCM errors are logged as
 * warnings, not thrown, to avoid breaking the parent operation.
 *
 * @param uid            - Firebase Auth UID of the recipient
 * @param fcmToken       - Device FCM registration token (nullable — in-app only if null)
 * @param title          - Push notification title (already translated via t())
 * @param body           - Push notification body (already translated via t())
 * @param source         - Notification category ('order', 'admin', etc.)
 * @param collectionName - Firestore collection to write the in-app notification to
 * @param data           - Optional key-value pairs sent as FCM data payload.
 *                         The Flutter app uses these to navigate on tap,
 *                         e.g. { type: "ORDER_STATUS", orderID: "abc123" }
 */
async function notifyUser(uid, fcmToken, title, body, source, collectionName = "users", data) {
    await writeNotification(uid, collectionName, title, body, source);
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
            console.warn(`FCM failed for ${collectionName} ID: ${uid}`, e);
        }
    }
}
// === Cloud Functions ==========================================================
/**
 * sendAdminNotification
 *
 * Callable function — invoked from the Merchant App admin panel.
 * Sends a push notification and in-app notification to a selected audience.
 *
 * Auth: Required. Caller must have role === 'admin' in their Firestore user doc.
 *
 * Request data:
 *   - title      {string}   Notification title (written by admin, not translated)
 *   - body       {string}   Notification body
 *   - audience   {string}   'all' | 'restaurants' | 'specific'
 *   - targetUIDs {string[]} Required when audience === 'specific'
 *
 * Returns: { success: boolean, sentCount: number }
 *
 * Note: Admin-authored notifications are intentionally NOT translated —
 * the admin writes them in the intended language. The locale field is
 * read but not used here.
 */
exports.sendAdminNotification = https.onCall({ region: REGION, enforceAppCheck: APP_CHECK }, async (req) => {
    if (!req.auth) {
        throw new https.HttpsError("unauthenticated", "Must be signed in.");
    }
    const callerDoc = await db.collection("users").doc(req.auth.uid).get();
    if (!callerDoc.exists || callerDoc.data()?.role !== "admin") {
        throw new https.HttpsError("permission-denied", "The admin role is required.");
    }
    const { title, body, audience, targetUIDs } = req.data;
    let usersToNotify = [];
    if (audience === "specific") {
        const snaps = await Promise.all(targetUIDs.map((uid) => db.collection("users").doc(uid).get()));
        usersToNotify = snaps.map(s => ({
            uid: s.id,
            fcmToken: s.data()?.fcmToken,
        }));
    }
    else {
        let query = db.collection("users");
        if (audience === "restaurants") {
            query = query.where("role", "==", "restaurant");
        }
        const snap = await query.get();
        usersToNotify = snap.docs.map((d) => ({
            uid: d.id,
            fcmToken: d.data()?.fcmToken,
        }));
    }
    await Promise.all(usersToNotify.map(user => notifyUser(user.uid, user.fcmToken ?? null, title, body, "admin")));
    // Write a history record for the admin panel's notification history tab
    await db.collection("adminNotificationHistory").add({
        title,
        body,
        audience,
        sentCount: usersToNotify.length,
        timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });
    return { success: true, sentCount: usersToNotify.length };
});
/**
 * createOrderAndDispatch (internal helper — not exported)
 *
 * Core order creation logic shared between placeOrder (cash) and
 * stripeWebhook (card). Creates the order document, mirrors it to
 * the user's subcollection, marks the quote as USED, notifies both
 * the restaurant and customer, then dispatches to an available rider.
 *
 * @param quoteID        - ID of the quote document to fulfil
 * @param userID         - Firebase Auth UID of the ordering customer
 * @param restaurantID   - Firestore ID of the restaurant
 * @param paymentMethod  - 'cash' | 'stripe'
 * @param paymentDetails - 'cash' for COD, or Stripe PaymentIntent ID for card
 * @returns              - The newly created orderID string
 */
async function createOrderAndDispatch({ quoteID, userID, restaurantID, paymentMethod, paymentDetails, }) {
    const [quoteDoc, userDoc, restaurantDoc] = await Promise.all([
        db.collection("quotes").doc(quoteID).get(),
        db.collection("users").doc(userID).get(),
        db.collection("restaurants").doc(restaurantID).get(),
    ]);
    if (!quoteDoc.exists)
        throw new Error("Quote not found: " + quoteID);
    const quote = quoteDoc.data();
    const user = userDoc.data();
    const restaurant = restaurantDoc.data();
    // Read the customer's preferred locale for notification translation
    const locale = user.locale ?? 'en';
    // Decode item strings: format is "restaurantID:menuID:itemID:quantity"
    const rawItemIDs = quote.itemIDs || [];
    const items = await Promise.all(rawItemIDs.map(async (encodedString) => {
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
            originalPrice,
            price: discountedPrice,
            discount: discountPercent,
            quantity: parseInt(qty) || 1,
            itemID: itemId,
        };
    }));
    const orderID = db.collection("orders").doc().id;
    const orderRef = db.collection("orders").doc(orderID);
    const userOrderRef = db.collection("users").doc(userID).collection("orders").doc(orderID);
    // Resolve delivery address — for pickup orders, address is a placeholder object
    let resolvedAddress = {};
    if (quote.orderType !== "pickup" && quote.addressID) {
        const addrDoc = await db
            .collection("users").doc(userID)
            .collection("addresses").doc(quote.addressID).get();
        if (addrDoc.exists) {
            resolvedAddress = { ...addrDoc.data(), addressID: quote.addressID };
        }
    }
    else if (quote.orderType === "pickup") {
        resolvedAddress = { type: "pickup" };
    }
    const subtotal = roundToTwo(quote.itemsTotal);
    const deliveryFee = roundToTwo(quote.deliveryFee);
    const totalAmount = roundToTwo(quote.finalTotal);
    const orderData = {
        orderID,
        userID,
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
        orderTime: firestore_1.FieldValue.serverTimestamp(),
        updatedAt: firestore_1.FieldValue.serverTimestamp(),
    };
    // Write order to both top-level collection and user subcollection atomically
    const batch = db.batch();
    batch.set(orderRef, orderData);
    batch.set(userOrderRef, orderData);
    batch.update(db.collection("quotes").doc(quoteID), {
        status: "USED",
        orderID,
        paymentStatus: paymentMethod === "stripe" ? "PAID" : "PENDING_COD",
    });
    await batch.commit();
    // Notify restaurant (always English — restaurant sets its own locale separately)
    await notifyUser(restaurantID, restaurant.fcmToken ?? null, t('en', 'new_order_title'), t('en', 'new_order_body', { id: orderID.slice(0, 8) }), "order", "users", { type: "NEW_ORDER", orderID });
    // Notify customer in their preferred language
    await notifyUser(userID, user.fcmToken ?? null, t(locale, 'order_placed_title'), t(locale, 'order_placed_body', { restaurant: restaurant.name ?? '' }), "order", "users", { type: "ORDER_STATUS", orderID, status: "Pending" });
    // Skip rider dispatch for pickup orders
    if (quote.orderType === "pickup") {
        console.log(`[DISPATCH] Skipping dispatch for pickup order ${orderID}`);
        return orderID;
    }
    await dispatchToRider(orderID, orderData, restaurant, user, locale);
    return orderID;
}
/**
 * dispatchToRider (internal helper — not exported)
 *
 * Finds the nearest available online rider and creates a dispatch_job
 * document that the Rider App listens to. The rider receives a push
 * notification with the job details.
 *
 * Rider selection: currently takes the first available rider (limit 10,
 * sorted by Firestore default). Future improvement: sort by proximity.
 *
 * Rider earnings: max(3.50 PLN, 75% of delivery fee)
 *
 * @param orderID        - Firestore order document ID
 * @param order          - Full order data map
 * @param restaurant     - Restaurant document data
 * @param customer       - Customer (user) document data
 * @param customerLocale - Customer's locale (not used for rider — rider has own locale)
 */
async function dispatchToRider(orderID, order, restaurant, customer, customerLocale) {
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
    const riderLocale = rider.locale ?? 'en';
    const pickupLat = restaurant.lat ?? 0;
    const pickupLng = restaurant.lng ?? 0;
    const dropoffLat = parseFloat(order.address?.lat ?? "0");
    const dropoffLng = parseFloat(order.address?.lng ?? "0");
    const distanceKm = roundToTwo(haversineKm(pickupLat, pickupLng, dropoffLat, dropoffLng));
    const deliveryFee = roundToTwo(order.deliveryFee);
    const riderEarnings = roundToTwo(Math.max(3.5, deliveryFee * 0.75));
    const finalTotal = roundToTwo(order.totalAmount);
    const isCash = (order.paymentMethod ?? "cash") === "cash";
    // Translate the payment label for the rider's notification
    const paymentLabel = isCash
        ? (riderLocale === 'pl' ? "Pobierz gotówkę" : "Collect cash")
        : (riderLocale === 'pl' ? "Karta opłacona" : "Card paid");
    // dispatch_jobs are consumed by the Rider App — the rider accepts or rejects
    // within the expiresAt window (30 seconds). If rejected/expired, re-dispatch
    // logic should be triggered separately.
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
        createdAt: firestore_1.FieldValue.serverTimestamp(),
        expiresAt: firestore_1.Timestamp.fromDate(new Date(Date.now() + 30000)),
    });
    // Notify the rider in their preferred language
    await notifyUser(riderDoc.id, rider.fcmToken ?? null, t(riderLocale, 'new_delivery_title'), t(riderLocale, 'new_delivery_body', {
        restaurant: restaurant.name ?? '',
        earnings: riderEarnings.toString(),
        payment: paymentLabel,
    }), "order", "riders", { type: "DISPATCH_JOB", orderID });
}
/**
 * googleMapsAutocomplete
 *
 * HTTP function — called directly by the Merchant App's map address picker.
 * Proxies autocomplete suggestions from the Google Places API.
 * The API key is injected server-side so it is never exposed to the client.
 *
 * Usage (Flutter):
 *   GET https://{region}-{project}.cloudfunctions.net/googleMapsAutocomplete?input=Krak
 *
 * Query params:
 *   - input {string} Partial address string typed by the user
 *
 * Returns: Google Places Autocomplete JSON response
 */
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
/**
 * googleMapsDetails
 *
 * HTTP function — called by the Merchant App after the user selects a
 * suggestion from googleMapsAutocomplete. Returns the lat/lng and
 * formatted address for a given Google Place ID.
 *
 * Usage (Flutter):
 *   GET https://{region}-{project}.cloudfunctions.net/googleMapsDetails?placeId=ChIJ...
 *
 * Query params:
 *   - placeId {string} Google Place ID from an autocomplete prediction
 *
 * Returns: Google Place Details JSON response
 */
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
/**
 * createPaymentIntent
 *
 * Callable function — invoked by the Customer App when the user selects
 * card payment at checkout. Creates a Stripe PaymentIntent for the
 * amount specified in the quote and returns the client secret needed
 * by the Flutter Stripe SDK to present the payment sheet.
 *
 * Auth: Required.
 *
 * Request data:
 *   - quoteID {string} ID of a valid, non-expired quote document
 *
 * Returns:
 *   - clientSecret    {string} Used by flutter_stripe to confirm payment
 *   - paymentIntentId {string} Stored for webhook reconciliation
 *   - publishableKey  {string} Stripe publishable key for the SDK
 *
 * Flow:
 *   Customer App → createPaymentIntent → Stripe SDK confirms →
 *   Stripe webhook → stripeWebhook → createOrderAndDispatch
 */
exports.createPaymentIntent = https.onCall({ region: REGION, secrets: [stripeSecretKey, stripePublishableKey], enforceAppCheck: APP_CHECK }, async (req) => {
    if (!req.auth)
        throw new https.HttpsError("unauthenticated", "Login required");
    const { quoteID } = req.data;
    if (!quoteID)
        throw new https.HttpsError("invalid-argument", "quoteID required");
    const quoteDoc = await db.collection("quotes").doc(quoteID).get();
    if (!quoteDoc.exists)
        throw new https.HttpsError("not-found", "Quote not found");
    const quote = quoteDoc.data();
    if (quote.userID !== req.auth.uid)
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
            publishableKey: stripePublishableKey.value(),
        };
    }
    catch (error) {
        console.error("Stripe Error:", error);
        throw new https.HttpsError("internal", error.message);
    }
});
/**
 * getPaymentMethodType
 *
 * Callable function — invoked by the Customer App after a successful
 * Stripe payment to determine what payment method was used (card, blik, etc.)
 * so it can be displayed in the order confirmation screen.
 *
 * Auth: Required.
 *
 * Request data:
 *   - paymentIntentId {string} Stripe PaymentIntent ID returned by createPaymentIntent
 *
 * Returns:
 *   - paymentMethodType {string} e.g. 'card', 'blik', 'p24'
 *   - status            {string} Stripe PaymentIntent status
 */
exports.getPaymentMethodType = https.onCall({ region: REGION, secrets: [stripeSecretKey], enforceAppCheck: APP_CHECK }, async (req) => {
    const { paymentIntentId } = req.data;
    if (!paymentIntentId || typeof paymentIntentId !== "string") {
        throw new https.HttpsError("invalid-argument", "paymentIntentId is required and must be a string");
    }
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
 * placeOrder
 *
 * Callable function — invoked by the Customer App for cash-on-delivery orders.
 * For card orders, the equivalent entry point is the stripeWebhook handler.
 *
 * Validates the quote, then delegates to createOrderAndDispatch which
 * creates the order, notifies parties, and dispatches to a rider.
 *
 * Auth: Required.
 *
 * Request data:
 *   - quoteID {string} ID of a valid, non-USED quote document
 *
 * Returns: { success: boolean, orderID: string }
 */
exports.placeOrder = https.onCall({ region: REGION, enforceAppCheck: APP_CHECK }, async (req) => {
    if (!req.auth)
        throw new https.HttpsError("unauthenticated", "Login required");
    const { quoteID } = req.data;
    if (!quoteID)
        throw new https.HttpsError("invalid-argument", "quoteID required");
    const quoteDoc = await db.collection("quotes").doc(quoteID).get();
    if (!quoteDoc.exists)
        throw new https.HttpsError("not-found", "Quote not found");
    const quote = quoteDoc.data();
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
    await db.collection("quotes").doc(quoteID).update({ orderID, status: "USED" });
    return { success: true, orderID };
});
/**
 * stripeWebhook
 *
 * HTTP function — receives signed webhook events from Stripe.
 * Only handles 'payment_intent.succeeded' — all other event types are ignored.
 *
 * Stripe sends this event after the customer successfully completes payment
 * in the Flutter Stripe sheet. This triggers order creation equivalent to placeOrder.
 *
 * Security: The webhook signature is verified using the STRIPE_WEBHOOK_SECRET.
 * Requests with invalid signatures are rejected with 400.
 *
 * Idempotency: Checks whether an order already exists for the PaymentIntent ID
 * before creating a new one, preventing duplicate orders on webhook retries.
 *
 * Setup: Register this URL in the Stripe Dashboard → Webhooks:
 *   https://{region}-{project}.cloudfunctions.net/stripeWebhook
 */
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
/**
 * handlePaymentSuccess (internal helper — not exported)
 *
 * Called by stripeWebhook when a PaymentIntent succeeds.
 * Reads quoteID, userID, and restaurantID from the PaymentIntent metadata
 * (set during createPaymentIntent) and delegates to createOrderAndDispatch.
 *
 * @param paymentIntent - Stripe PaymentIntent object from the webhook event
 */
async function handlePaymentSuccess(paymentIntent) {
    const { quoteID, userID, restaurantID } = paymentIntent.metadata;
    // Idempotency check — prevent duplicate orders on webhook retries
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
    await db.collection("quotes").doc(quoteID).update({ orderID, status: "USED" });
}
/**
 * onDispatchJobAccepted
 *
 * Firestore trigger — fires when a dispatch_jobs/{jobId} document is updated.
 * Specifically handles the transition from any status → 'accepted'.
 *
 * When a rider accepts a job in the Rider App:
 *   1. Order status is updated to 'In Progress' in both collections
 *   2. Rider is marked as busy (hasActiveOrder: true)
 *   3. Customer is notified that their rider is heading to the restaurant
 *
 * The customer notification is sent in the customer's preferred locale.
 */
exports.onDispatchJobAccepted = fsEvents.onDocumentUpdated({ document: "dispatch_jobs/{jobId}", region: REGION }, async (event) => {
    const before = event.data?.before.data();
    const after = event.data?.after.data();
    if (!before || !after)
        return;
    if (before.status === after.status)
        return;
    if (after.status !== "accepted")
        return;
    const { riderUID, orderID } = after;
    const orderDoc = await db.collection("orders").doc(orderID).get();
    if (!orderDoc.exists)
        return;
    const orderData = orderDoc.data();
    const userID = orderData.userID;
    const locale = await getUserLocale(userID);
    const orderUpdate = {
        status: "In Progress",
        riderUID,
        updatedAt: firestore_1.FieldValue.serverTimestamp(),
    };
    const batch = db.batch();
    batch.update(db.collection("orders").doc(orderID), orderUpdate);
    batch.update(db.collection("users").doc(userID).collection("orders").doc(orderID), orderUpdate);
    // Mark rider as busy so they stop receiving new dispatch jobs
    batch.update(db.collection("riders").doc(riderUID), {
        hasActiveOrder: true,
        currentOrderID: orderID,
        lastSeenAt: firestore_1.FieldValue.serverTimestamp(),
    });
    await batch.commit();
    const userDoc = await db.collection("users").doc(userID).get();
    const user = userDoc.data();
    await notifyUser(userID, user.fcmToken ?? null, t(locale, 'rider_on_way_title'), t(locale, 'rider_on_way_body'), "order", "users", { type: "ORDER_STATUS", orderID, status: "In Progress" });
});
/**
 * onOrderStatusChanged
 *
 * Firestore trigger — fires on any update to an orders/{orderID} document.
 * Handles the full order lifecycle notification flow for all status changes.
 *
 * Status transitions handled:
 *   - Pending      → (no notification — handled at order creation)
 *   - In Progress  → Notify customer: restaurant accepted / rider on way
 *   - Ready        → Notify customer: food ready + notify rider to pick up (delivery)
 *                    Notify customer: ready for self-pickup (pickup orders)
 *   - Delivered    → Notify customer: order delivered + free up rider
 *
 * Also mirrors all status changes to users/{uid}/orders/{orderID} for
 * real-time order tracking in the Customer App.
 *
 * All customer notifications use the customer's stored locale.
 * All rider notifications use the rider's stored locale.
 */
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
    const orderType = after.orderType ?? "delivery";
    const isPickup = orderType === "pickup";
    const riderUID = after.riderUID;
    if (!userID) {
        console.error(`Order ${orderID} is missing userID. Skipping logic.`);
        return;
    }
    const userDoc = await db.collection("users").doc(userID).get();
    const customer = userDoc.data() ?? {};
    const locale = customer.locale ?? 'en';
    // Mirror status to user subcollection for real-time Customer App tracking
    const mirrorData = {
        status,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };
    if (status === "Delivered") {
        mirrorData.deliveredAt = admin.firestore.FieldValue.serverTimestamp();
    }
    await db
        .collection("users").doc(userID)
        .collection("orders").doc(orderID)
        .set(mirrorData, { merge: true });
    // In Progress: restaurant confirmed the order
    if (status === "In Progress") {
        await notifyUser(userID, customer.fcmToken ?? null, t(locale, 'order_accepted_title'), isPickup
            ? t(locale, 'order_accepted_pickup_body')
            : t(locale, 'order_accepted_body'), "order", "users", { type: "ORDER_STATUS", orderID, status });
    }
    // Ready: kitchen finished — different flow for pickup vs delivery
    if (status === "Ready") {
        if (isPickup) {
            // Tell customer to come collect their order
            await notifyUser(userID, customer.fcmToken ?? null, t(locale, 'ready_for_pickup_title'), t(locale, 'ready_for_pickup_body'), "order", "users", { type: "ORDER_STATUS", orderID, status });
        }
        else {
            // Tell customer their food is ready and rider will collect
            await notifyUser(userID, customer.fcmToken ?? null, t(locale, 'food_ready_title'), t(locale, 'food_ready_body'), "order", "users", { type: "ORDER_STATUS", orderID, status });
            // Tell rider to go to the restaurant — only if assigned
            if (riderUID && riderUID.length > 5) {
                const riderDoc = await db.collection("riders").doc(riderUID).get();
                if (!riderDoc.exists) {
                    console.error(`Rider not found: ${riderUID}`);
                    return;
                }
                const rider = riderDoc.data();
                const riderLocale = rider?.locale ?? 'en';
                await notifyUser(riderUID, rider?.fcmToken ?? null, t(riderLocale, 'order_ready_rider_title'), t(riderLocale, 'order_ready_rider_body', {
                    restaurant: after.restaurantName ?? '',
                }), "order", "riders", { type: "ORDER_READY", orderID });
            }
            else {
                console.log(`Order ${orderID} is Ready but no rider assigned yet.`);
            }
        }
    }
    // Delivered: order complete — free up the rider
    if (status === "Delivered") {
        await notifyUser(userID, customer.fcmToken ?? null, isPickup ? t(locale, 'pickup_collected_title') : t(locale, 'delivered_title'), isPickup ? t(locale, 'pickup_collected_body') : t(locale, 'delivered_body'), "order", "users", { type: "ORDER_STATUS", orderID, status });
        // Mark rider as available for new jobs
        if (!isPickup && riderUID && riderUID.length > 5) {
            await db.collection("riders").doc(riderUID).update({
                hasActiveOrder: false,
                currentOrderID: null,
                lastSeenAt: firestore_1.FieldValue.serverTimestamp(),
            });
        }
    }
});
/**
 * onRiderLocationUpdate
 *
 * Firestore trigger — fires whenever a riders/{riderUID} document is updated.
 * Recalculates the live ETA for the active order using Google Maps Directions API
 * and writes the result back to the order document.
 *
 * The Customer App listens to orders/{orderID}.eta in real time and displays
 * a countdown to the customer.
 *
 * Guards:
 *   - Skips if rider has no active order
 *   - Skips if locationUpdatedAt hasn't changed (prevents infinite loops)
 *   - Uses 'In Progress' status to determine which leg to calculate:
 *     pickup leg (rider → restaurant) or dropoff leg (restaurant → customer)
 *
 * ETA format written to Firestore:
 *   { minMinutes, maxMinutes, updatedAt, source: "GOOGLE_DIRECTIONS" }
 */
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
    // Determine which leg to calculate based on current order status
    const isToPickup = order.status === "In Progress";
    const targetLat = isToPickup ? (order.restaurantLat ?? 0) : parseFloat(order.address?.lat ?? "0");
    const targetLng = isToPickup ? (order.restaurantLng ?? 0) : parseFloat(order.address?.lng ?? "0");
    const directions = await getDirections(riderLat, riderLng, targetLat, targetLng, googleMapsKey.value(), "driving");
    if (!directions)
        return;
    const durationMinutes = Math.ceil(directions.durationSeconds / 60);
    // Buffer adds a small cushion to the upper estimate to avoid disappointment
    const bufferMin = isToPickup ? 2 : 3;
    await db.collection("orders").doc(orderID).update({
        eta: {
            minMinutes: Math.max(1, durationMinutes - 1),
            maxMinutes: durationMinutes + bufferMin,
            updatedAt: firestore_1.FieldValue.serverTimestamp(),
            source: "GOOGLE_DIRECTIONS",
        },
    });
});
/**
 * saveFcmToken
 *
 * Callable function — invoked by all three apps (Customer, Merchant, Rider)
 * on launch and whenever the FCM token is refreshed.
 *
 * Stores the device's FCM registration token in Firestore so that
 * notifyUser() can send targeted push notifications to specific devices.
 *
 * Auth: Required.
 *
 * Request data:
 *   - token {string} FCM registration token from FirebaseMessaging.instance.getToken()
 *   - role  {string} 'rider' writes to the 'riders' collection, anything else to 'users'
 *
 * Returns: { success: boolean }
 */
exports.saveFcmToken = https.onCall({ region: REGION, enforceAppCheck: APP_CHECK }, async (req) => {
    if (!req.auth)
        return { success: false };
    const { token, role } = req.data;
    if (!token)
        throw new https.HttpsError("invalid-argument", "token required");
    const collection = role === "rider" ? "riders" : "users";
    await db.collection(collection).doc(req.auth.uid).set({ fcmToken: token, fcmUpdatedAt: firestore_1.FieldValue.serverTimestamp() }, { merge: true });
    return { success: true };
});
//# sourceMappingURL=index.js.map