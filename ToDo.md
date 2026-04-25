**Customer App**

Auth
- [x] Email/password login
- [x] Email/password registration
- [ ] Google Sign-In
- [ ] Apple Sign-In
- [x] Phone OTP
- [ ] Password reset screen

Home Feed (dynamic, server-driven)
- [x] Address selector with current location + saved addresses on home
- [x] Search bar
- [x] Hero banner carousel (dynamic from backend)
- [x] Primary tabs: Delivery / Pickup / Grocery / Gifts / Benefits
- [x] Quick category grid (dynamic icons from Firestore)
- [x] Promo banners (dynamic, multiple)
- [ ] Deal shelves (discount items sections)
- [x] Sponsored store slots (paid placements)
- [x] Sections ordered from backend (no app update needed)

Store Page
- [x] Store header with rating and review count
- [x] Favorites toggle
- [ ] Delivery/Pickup toggle
- [ ] Minimum order, delivery fee, ETA display
- [ ] Open/closed status + open reminder
- [ ] Store-level promo banners (free delivery, coupon)

Menu & Cart
- [x] Menu item cards with image, name, price, discount badge
- [x] Add to cart
- [x] Quantity +/-
- [x] Remove item
- [ ] Menu categories with Popular/Recommended sections
- [ ] Item option groups (single choice, multiple choice, required/optional, min/max enforcement)
- [ ] Sold-out item/option handling
- [ ] Change options from cart
- [ ] Recommended add-ons upsell in cart
- [x] Price summary with delivery fee and discounts

Checkout
- [x] Delivery address selection
- [x] Stripe card payment
- [x] Cash on delivery payment method
- [ ] Rider instructions field with presets
- [ ] Store instructions field
- [ ] Cutlery toggle
- [ ] Coupon selection and apply/remove
- [x] Quote request before order creation (server-side pricing)
- [x] Order created from quote ID (prevent price tampering)
- [ ] Terms acceptance checkbox

Orders
- [x] Order history screen
- [x] Basic order status display
- [x] Post-order rating sheet
- [x] Full order status timeline (Confirmed → Preparing → Ready → Picked Up → Delivering → Completed)
- [ ] Live delivery tracking screen with Google Maps
- [ ] Rider location marker on map
- [ ] ETA display (min-max range)
- [ ] Order cancellation with reason

Promotions & Benefits
- [ ] Coupon wallet (available / used / expired)
- [ ] Auto-granted coupons (welcome, first order)
- [ ] Deals/discount item browsing screen

---

**Merchant App**

Store Management
- [ ] Store info editing (hours, description, photos)
- [ ] Temporary close toggle
- [ ] Delivery radius and minimum order settings
- [ ] Delivery/Pickup enable toggle

Menu & Inventory
- [ ] Menu category CRUD
- [x] Menu item CRUD (partial — in progress)
- [x] Photo upload per item
- [ ] Sold-out toggle per item

Options Management
- [ ] Option group CRUD (required, min/max)
- [ ] Option CRUD with price delta and sold-out flag

Orders
- [x] Order board / table view (in progress)
- [ ] New order push notification
- [ ] Accept / Reject order
- [ ] Status update: Accepted → Preparing → Ready → Handed to rider
- [ ] Partial refund / cancellation

Promotions
- [ ] Create store coupons
- [x] Mark items as discounted

Sponsored / Ads
- [ ] Buy sponsored placement slot
- [ ] View impressions/clicks metrics

---

**Rider App**

- [x] Receive dispatch job notification
- [x] Accept / Reject job
- [x] Navigate to store (Google Maps)
- [x] Confirm pickup
- [x] Navigate to customer
- [x] Confirm delivery
- [x] Background location updates during active delivery
- [x] Online / offline toggle
- [x] Earnings summary screen

---

**Cloud Functions**

- [x] Quote engine (calculate items + delivery + discounts server-side)
- [ ] Coupon validation engine
- [x] Order creation from quote ID
- [x] Payment confirmation webhook (Stripe)
- [x] Merchant order status transition enforcement
- [x] Rider dispatch and assignment
- [x] `onRiderLocationUpdate` — compute ETA and write back
- [x] `assignRiderToDelivery` — set rider, notify parties via FCM
- [x] `onStatusChange` — handle phase transitions, stop tracking on delivery
- [ ] Notification triggers for all status changes
- [ ] Account deletion cleanup
- [x] Algolia sync on restaurant/item write
- [ ] Scheduled jobs (expire promos, rotate sponsored slots)

---

**Delivery Tracking**

- [x] Rider writes location every 5–10 seconds on active job
- [ ] Customer app subscribes to delivery doc in real time
- [ ] Merchant app shows rider on map
- [ ] MVP ETA using Haversine distance + default city speed
- [ ] "Rider connection lost" warning if no update for 3+ minutes
- [ ] Stop tracking when status = Delivered or Cancelled
- [x] Security rules: customer reads own delivery only, rider writes own location only

---

**Admin CMS (Web)**

- [ ] Home sections builder (reorder, enable/disable, schedule)
- [ ] Banner manager (creative, deep link, schedule, targeting)
- [ ] Coupon campaign manager
- [ ] Sponsored placement manager
- [x] Store approval panel

---

**Localisation**

- [x] Flutter ARB files for PL / EN / KO / UK
- [x] User-selectable language in settings
- [ ] Database translation tables per collection (store names, menu items, banners)
- [x] Translation fallback chain (PL → EN → others)
- [ ] Auto-translation pipeline via Google Cloud Translation with MACHINE / REVIEWED status flag

---

**Non-functional**

- [x] Firestore security rules
- [x] App Check (debug tokens)
- [ ] App Check switched to Play Integrity / Device Check for production
- [ ] Firebase Crashlytics integration
- [ ] Structured logging in Cloud Functions
- [ ] Idempotency keys on order creation and payment
- [ ] Offline indicator UI when Firestore connection drops
- [ ] Image resizing on Storage upload

---
