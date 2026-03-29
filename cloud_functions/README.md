# Freequick — Cloud Functions

TypeScript Firebase Cloud Functions handling all server-side business logic. Deployed to Firebase Functions on Node.js 18, europe-west1 region.

---

## Setup

### Required files

Secrets are loaded at runtime from `secrets.json` in the **project root** (one level above `cloud_functions/`). The compiled output at `cloud_functions/lib/index.js` resolves this path automatically.

```
freequick-suite/
└── secrets.json    ← must exist before deploying or running the emulator
```

```json
{
  "STRIPE_SECRET_KEY": "sk_live_...",
  "STRIPE_PUBLISHABLE_KEY": "pk_live_...",
  "STRIPE_WEBHOOK_SECRET": "whsec_...",
  "MAPS_API_KEY": "AIza..."
}
```

`STRIPE_WEBHOOK_SECRET` can be left empty until after first deployment — get it from the Stripe Dashboard after registering the webhook endpoint.

### Install dependencies

```bash
cd cloud_functions
npm install
```

### Build

```bash
npm run build
```

### Deploy

```bash
firebase deploy --only functions
```

Deploy a single function:
```bash
firebase deploy --only functions:onDispatchJobAccepted
```

### Local testing

```bash
# Start Firebase emulator
firebase emulators:start --only functions

# In a separate terminal — install Stripe CLI and forward webhooks
stripe login
stripe listen --forward-to localhost:5001/YOUR_PROJECT_ID/europe-west1/stripeWebhook
```

Copy the `whsec_...` key printed by `stripe listen` into `secrets.json` as `STRIPE_WEBHOOK_SECRET`.

### View logs

```bash
firebase functions:log
firebase functions:log --only onDispatchJobAccepted
```

---

## Functions

### `createPaymentIntent`
Called by the customer app at checkout. Reads `quotes/{quoteID}` server-side to determine the charge amount — the client never sends the price directly. Returns a Stripe `clientSecret` for the Flutter payment sheet.

### `stripeWebhook`
HTTP endpoint called by Stripe on `payment_intent.succeeded`. Verifies the Stripe signature, then calls `createOrderAndDispatch` to create order documents and dispatch a rider.

### `placeCashOrder`
Called by the customer app for cash on delivery orders. Uses the same `createOrderAndDispatch` helper as the Stripe flow — the order structure is identical. The dispatch job is flagged `collectPayment: true` so the rider knows to collect cash from the customer.

### `onDispatchJobAccepted`
Firestore trigger on `dispatch_jobs/{id}`. Fires when a rider sets `status: 'accepted'`. Sets order status to `'In Progress'`, marks the rider `hasActiveOrder: true` with `currentOrderID`, and sends the customer a push notification.

### `onOrderStatusChanged`
Firestore trigger on `orders/{id}`. Fires on every status change. Sends an in-app notification and FCM push to the customer with the appropriate message. On `'Delivered'` frees the rider by setting `hasActiveOrder: false`.

### `onRiderLocationUpdate`
Firestore trigger on `riders/{uid}`. Fires when the rider's GPS position changes. Calls the Google Directions API and writes a fresh ETA back to `orders/{orderID}.eta`.

### `saveFcmToken`
Called by both the customer and rider apps on launch. Accepts a `role` parameter — `'rider'` writes to the `riders` collection, anything else writes to `users`.

---

## Shared Helper: `createOrderAndDispatch`

Internal function used by both `stripeWebhook` and `placeCashOrder`. Handles:
- Creating `orders/{id}` and `users/{uid}/orders/{id}` in a single batch
- Marking the quote as used
- Notifying the restaurant via FCM
- Writing an in-app notification for the customer
- Finding an available rider and creating a `dispatch_jobs` document

This ensures the order structure and dispatch logic are identical regardless of payment method.

---

## Order Status Flow

```
Pending        ← created by createOrderAndDispatch
In Progress    ← set by onDispatchJobAccepted when rider accepts
Ready          ← set by rider app (picked up from restaurant)
Delivered      ← set by rider app (handed to customer)
```

---

## Firestore Indexes Required

| Collection | Fields |
|---|---|
| `orders` | `riderUID ASC` + `status ASC` + `deliveredAt DESC` |
| `orders` | `restaurantID ASC` + `status ASC` + `orderTime DESC` |
| `orders` | `stripePaymentIntentId ASC` |
| `riders` | `isOnline ASC` + `hasActiveOrder ASC` |
| `dispatch_jobs` | `riderUID ASC` + `status ASC` + `createdAt DESC` |

Firebase will print console links to create missing indexes on first query. You can also define them in `firestore.indexes.json` and deploy with:
```bash
firebase deploy --only firestore:indexes
```