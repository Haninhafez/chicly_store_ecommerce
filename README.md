# Chicly Store

A cross-platform e-commerce app built with Flutter. Chicly Store covers the main shopping
flow: browse products, view details, save favorites, manage a cart, and place an order with
card or cash-on-delivery payment. User accounts, carts, wishlists, and orders are stored in
Firebase.

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-%5E3.9.2-0175C2?logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-Auth%20%7C%20Firestore-FFCA28?logo=firebase&logoColor=black)
![Platforms](https://img.shields.io/badge/platforms-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-lightgrey)

---

## About

Chicly Store is a Flutter storefront application I built to practice a realistic e-commerce
architecture: a feature-based folder layout, Cubit-based state management, Firebase
authentication and data persistence, and integration with a third-party REST API for
products. The UI supports both light and dark themes.

Product data comes from the public [Platzi Fake Store API](https://fakeapi.platzi.com/),
so the catalog is sample data rather than a real inventory.

## Features

**Authentication**
- Email and password sign up and sign in
- Google sign in
- Facebook sign in
- Password reset by email
- Splash screen that checks the saved session and routes the user accordingly
- Log out

**Shopping**
- Home screen with a promotional banner carousel
- Product grid loaded from the REST API
- Product details screen with an image gallery
- Add to cart and add to wishlist from the product screen
- Wishlist synced per user in Firestore
- Cart with quantity increment / decrement, item removal, and a running total synced in Firestore

**Checkout**
- Shipping information form with validation
- Payment method selection: card or cash on delivery
- Promo code input with a discount applied to the order total
- Order summary with subtotal, shipping, tax, and discount
- Orders saved to Firestore

**Profile**
- Edit name, email, and phone number
- Change password via the reset flow
- Delete account (email/password and Google accounts)
- Dark and light theme toggle, remembered between sessions

**UI polish**
- Shimmer placeholders while data loads
- Lottie animation on the splash screen
- Custom snackbars for errors and confirmations

## Tech Stack

**Framework and language**
- Flutter and Dart (Dart SDK `^3.9.2`)

**State management and routing**
- `flutter_bloc` / `bloc` — Cubit-based state management
- `provider` — `ChangeNotifier` for the theme
- Flutter named routes (`MaterialApp` + route table)

**Backend and data**
- `firebase_core`, `firebase_auth` — authentication
- `cloud_firestore` — users, carts, wishlists, and orders
- `google_sign_in`, `flutter_facebook_auth` — social sign in
- `dio` — HTTP client for the products API
- `shared_preferences`, `flutter_secure_storage` — local session storage (auth token kept in secure storage)

**Payments**
- `flutter_stripe` — card payments at checkout

**UI and assets**
- `google_fonts`, `carousel_slider`, `font_awesome_flutter`
- `shimmer`, `lottie`
- `rt_awesome_snackbar_content`

## Architecture

The project uses a **feature-first** structure. Everything reusable lives in `lib/core`,
and each product area lives under `lib/features` with its own screens, widgets, models,
services, and Cubits. This keeps feature code close together and the shared layer free of
business logic.

State is handled in two ways, depending on the need:

- **Cubit (`flutter_bloc`)** for data-driven state: `ProductCubit`, `CartShoppingCubit`,
  and `WishListCubit` each expose loading / success / error states that the UI reacts to
  with `BlocBuilder`. These Cubits are provided at the app root in `main.dart`.
- **Provider (`ChangeNotifier`)** for the app theme: `ThemeNotifier` holds the dark/light
  flag and persists it with `shared_preferences`.

Navigation uses a named-route table (`AppRoutes` + `AppPages`), with `arguments` passed for
screens that need data, such as product details and checkout.

Firestore document shape:

```
users/{uid}
  userName, email, userPhone, createdAt
  wishlist: [productId, ...]
  cartShopping: { "<productId>": quantity, ... }

orders/{uid}
  email, fullName, address, city, zipcode, state, country, phone,
  paymentMethod, totalPrice, cartItems: { "<productId>": quantity, ... }
```

## Project Structure

```
lib/
├── core/
│   ├── constant/        # colors, text styles, buttons, local storage service
│   ├── routes/          # named routes (AppRoutes) and route table (AppPages)
│   ├── theme/           # light/dark themes and the theme notifier
│   └── utils/           # validators, shimmer loaders, product cards, snackbars
├── features/
│   ├── auth/            # login, register, splash, social sign in, auth service
│   ├── cart/            # cart cubit, cart screen, cart widgets
│   ├── checkout/        # checkout screen, order model, Stripe payment, Firestore order
│   ├── home/            # home screen, banner carousel, product grid, search bar
│   ├── product/         # product cubit, API service, model, details screen
│   ├── profile/         # profile screen, account update service, theme toggle
│   └── wishlist/        # wishlist cubit, wishlist screen, Firestore service
├── firebase_options.dart
└── main.dart
```

Other important folders:

```
assets/
├── images/       # banner images and placeholders
└── animation/    # Lottie files (splash screen)
```

## Getting Started

### Prerequisites

- Flutter SDK with Dart `^3.9.2`
- An Android, iOS, web, or desktop target set up for Flutter
- A Firebase project (for authentication and Firestore)
- The [FlutterFire CLI](https://firebase.flutter.dev/docs/cli/) if you want to regenerate the Firebase config

### Install

```bash
git clone <your-repository-url>
cd chicly_store
flutter pub get
```

### Run

```bash
flutter run
```

To run on a specific platform:

```bash
flutter run -d chrome     # web
flutter run -d windows    # desktop
```

## Firebase Setup

This project uses Firebase Authentication and Cloud Firestore. The repository uses
placeholder-safe generated config files, so you need to connect it to your own Firebase
project before running.

1. Create a project in the [Firebase Console](https://console.firebase.google.com/).
2. Enable **Authentication**, then turn on the **Email/Password**, **Google**, and
   **Facebook** sign-in providers you want to use.
3. Create a **Cloud Firestore** database.
4. From the project root, generate the platform config for your project:

   ```bash
   flutterfire configure
   ```

   This regenerates `lib/firebase_options.dart` and the platform config files (for example
   `android/app/google-services.json`) for your own project.

5. For Google sign in on Android, add your signing certificate SHA-1 to the Firebase
   project and re-download the config if needed.
6. For Facebook sign in, set up an app in the Meta developer console and add the app id
   and client token to the Android and iOS configuration.

Firestore collections used by the app are `users` and `orders` (see the document shape in
the Architecture section). Make sure your security rules only allow authenticated users to
read and write their own documents.

### Stripe payments

Card payments use `flutter_stripe`. The checkout screen is wired to collect card details and
start a payment, but a **Stripe publishable key** and a **backend endpoint that creates the
PaymentIntent** still need to be provided for card payments to complete. Cash on delivery
works without Stripe. See the [flutter_stripe documentation](https://pub.dev/packages/flutter_stripe)
for setup, and never place a Stripe secret key in the app.


## Notes and Known Limitations

- Product data is sample data from the Platzi Fake Store API, not a real store.
- The home search bar is currently a UI element and does not filter products yet.
- Card payments require the Stripe configuration described above; cash on delivery is fully
  functional.
- The default widget test is still the Flutter counter template and does not cover the app's
  real flows yet.

## Contact

- GitHub: [your-username](https://github.com/Haninhafez)
- LinkedIn: [your-profile](https://www.linkedin.com/in/hanin-abdelhafez-b69257302/)
- Email: haninabdelhafez0@gmail.com
