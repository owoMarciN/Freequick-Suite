# Freequick Suite

A full-stack food delivery platform built with Flutter and Firebase. The suite consists of three client applications and a shared backend, all managed in a single mono repository.

---

## Repository Structure

```
freequick-suite/
├── customer_app/          # Mobile app for customers placing orders
├── merchant_app/          # Web dashboard for restaurant owners also a specialy integrated Admin side for managing users
├── rider_app/             # Mobile app for delivery riders
├── cloud_functions/       # Firebase Cloud Functions (TypeScript backend)
├── shared_assets/         # Shared fonts, images, and brand assets
├── firebase.json          # Firebase project configuration
└── .firebaserc            # Firebase project aliases
```

---

## Platform Overview

| App | Platform | Description |
|---|---|---|
| Customer App | iOS / Android | Browse restaurants, place orders, track delivery in real time |
| Merchant App | Web (Flutter Web) | Manage menus, handle incoming orders, view analytics, Admin can manage the customer app content |
| Rider App | iOS / Android | Receive dispatch jobs, navigate to restaurant and customer |
| Cloud Functions | Node.js (Firebase) | Payment processing, order dispatch, push notifications |

---

## Tech Stack

### Frontend
- **Flutter** — all three client apps share the same Dart codebase patterns
- **Provider** — state management across all apps
- **Firebase Auth** — phone number OTP authentication
- **Google Maps Flutter** — live delivery tracking and navigation

### Backend
- **Firebase Firestore** — real-time database for orders, riders, restaurants
- **Firebase Cloud Functions** — TypeScript backend for business logic
- **Firebase Cloud Messaging** — push notifications to all three apps
- **Firebase Storage** — restaurant logos, banners, and profile photos

### Third-party Integrations
- **Stripe** — card payment processing via Firebase Stripe Extension
- **Algolia** — restaurant and menu item search with instant results
- **Google Maps Platform** — Directions API for ETA and route polylines
- **Google Translate** — automated ARB localisation file generation

---

## Firebase Setup

The project uses a single Firebase project shared across all apps.

### Firestore Collections

```
orders/{orderID}
users/{uid}/orders/{orderID}
users/{uid}/notifications/{id}
restaurants/{id}/menus/{menuId}/items/{itemId}
restaurants/{id}/promotions/{id}
riders/{uid}
dispatch_jobs/{jobID}
quotes/{quoteId}
```

### Security Rules
Firestore rules are defined in `firestore.rules`. Key principles:
- Restaurant owners can only write to their own documents
- Admins can approve restaurants by setting `status: 'Active'`
- Riders can only update their own dispatch jobs
- Order status can be updated by the customer, restaurant, and rider involved

Deploy rules:
```bash
firebase deploy --only firestore:rules
```

---

## Cloud Functions

All backend logic lives in `cloud_functions/`. See [`cloud_functions/README.md`](cloud_functions/README.md) for full documentation.

Deploy:
```bash
cd cloud_functions
npm run build && firebase deploy --only functions
```

---

## Environment & Secrets

Each app reads secrets at build time or runtime from a `secrets.json` file in the project root. This file is excluded from version control via `.gitignore`.

Required keys:
```json
{
  "STRIPE_SECRET_KEY": "sk_live_...",
  "STRIPE_PUBLISHABLE_KEY": "pk_live_...",
  "STRIPE_WEBHOOK_SECRET": "whsec_...",
  "MAPS_API_KEY": "AIza...",
  "ALGOLIA_APP_ID": "...",
  "ALGOLIA_SEARCH_KEY": "..."
}
```

---

## Getting Started

```bash
# Clone the repo
git clone https://github.com/owoMarciN/freequick-suite.git
cd freequick-suite

# Install Cloud Function dependencies
cd cloud_functions && npm install && cd ..

# Run the merchant dashboard locally
cd merchant_app
flutter pub get
flutter run -d web-server --web-port 8080 --dart-define-from-file ../secrets.json

# Run the customer app
cd customer_app
flutter pub get
flutter run --dart-define-from-file ../secrets.json

# Run the rider app
cd rider_app
flutter pub get
flutter run --dart-define-from-file ../secrets.json
```

---

## Status

Active development. Core order flow (place → dispatch → deliver) is functional end-to-end across all three apps.
