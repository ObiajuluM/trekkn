# Walk It

A Flutter app that tracks daily steps, rewards activity, and supports seamless sign-in and deep linking. Built for Android and iOS with environment flavors (dev/prod), background foreground service, and Health Connect/Google Fit integration.

## Features

- Step tracking via Health Connect / Google Fit
- Foreground service showing live daily steps notification
- Daily reward logic (logs steps to backend at a set hour)
- Google Sign-In (with email/profile scopes)
- Deep links: open invite links like `https://walkitapp.com/invite/<code>`
- Online/offline awareness using `internet_connection_checker_plus`
- Dev/Prod flavors with separate base URLs and Google credentials
- Theming (light/dark) and persisted theme preference

## Project Structure

- `lib/main.dart` – Production entrypoint (Flavor.prod)
- `lib/main_dev.dart` – Development entrypoint (Flavor.dev)
- `lib/global/flavor/config.dart` – Flavor configuration (baseUrl, googleClientId)
- `lib/modules/api/backend.dart` – API client (Dio, JWT, token stream, connectivity check)
- `lib/modules/background/background_step_process.dart` – Foreground task service for steps & rewards
- `lib/pages/landing/landing.dart` – Landing/login flow, invite handling
- `lib/pages/primary/primary.dart` – Main app
- `lib/pages/permissions/step.dart` – Step permissions & service start
- `lib/licenses.dart` – Third‑party licenses

## Prerequisites

- Flutter SDK (stable)
- Android Studio / Xcode
- Firebase project (Android + iOS) with Google Sign-In enabled
- For Android: Health Connect installed (from Play Store) and/or Google Fit

## Configuration

### 1) Flavors

Configure your flavors in `lib/global/flavor/config.dart` and the app entrypoints:

- `lib/main.dart` uses `Flavor.prod`
- `lib/main_dev.dart` uses `Flavor.dev`

Each flavor must provide:
- `baseUrl` – Backend URL
- `googleClientId` – iOS client ID (only used on iOS). Android uses the Web OAuth client ID as `serverClientId`.

### 2) Google Sign-In (Android)

- Ensure you have a Web Client ID (OAuth 2.0) for `serverClientId`.
- Add the correct `applicationId` (and any `applicationIdSuffix`) to Firebase Console as an Android app.
- Add both SHA‑1 and SHA‑256 of your signing keys (debug and release if needed).
- Download the updated `google-services.json` and place it according to flavors, e.g.:
  - `android/app/src/prod/google-services.json`
  - `android/app/src/dev/google-services.json`
  - If you split by build type too, use `src/prodDebug`, `src/prodRelease`, etc.

On Android, pass only `serverClientId` when initializing GoogleSignIn. On iOS, pass `clientId`.

### 3) Deep Links (Android)

`AndroidManifest.xml` config matches:
- Schemes: `http` and `https`
- Host: `walkitapp.com` (and TitleCase variant if needed)
- Path prefix: `/invite`

Android host matching is case‑sensitive. Add multiple `<data>` entries if you must support mixed case hosts.

### 4) Permissions (Android)

The app requests and/or uses:
- `INTERNET`, `POST_NOTIFICATIONS`
- `ACTIVITY_RECOGNITION`, `BODY_SENSORS`, `HIGH_SAMPLING_RATE_SENSORS`
- Foreground service permissions (`FOREGROUND_SERVICE`, plus types such as `HEALTH`, `DATA_SYNC` for Android 14+)
- Health Connect API permissions via the `health` plugin

Ensure users enable these for accurate tracking and background service behavior.

## Running the App

Development (dev flavor):
- `flutter run -t lib/main_dev.dart --flavor dev`

Production (prod flavor):
- `flutter run -t lib/main.dart --flavor prod`

Build APK (example):
- `flutter build apk -t lib/main.dart --flavor prod`

Note: Use the correct entrypoint per flavor, so the proper `FlavorConfig` is initialized.

## Background Foreground Service

- Implemented with `flutter_foreground_task`
- Starts a foreground service that updates a notification with today’s steps
- Periodically attempts to reward/log steps to the backend
- Passes flavor info to the background isolate so API base URL and credentials are correct

If you change plugin versions, check whether `inputData` or `saveData/getData` should be used for sending data to the isolate.

## Troubleshooting

- INSTALL_FAILED_UPDATE_INCOMPATIBLE
  - The installed app’s signature differs from the new APK. Uninstall the existing app (`adb uninstall com.walkitapp.walkit`) or use different `applicationIdSuffix` per flavor/build type.

- Google Sign‑In canceled immediately
  - Start sign‑in from a user gesture
  - On Android, pass only `serverClientId` (Web client ID). Do not pass `clientId`.
  - Ensure the exact package name (with suffix) is registered in Firebase and has correct SHA‑1/SHA‑256
  - Place `google-services.json` in the correct flavor folder
  - Clear stale session: call `await GoogleSignIn.instance.signOut()` before a new attempt

- Deep links not opening for uppercase host
  - Android matching is case‑sensitive. Add `<data>` entries for each case you need, or standardize to lowercase URLs.

- Foreground service not starting on Android 14+
  - Verify you requested the new foreground service types (e.g., `FOREGROUND_SERVICE_HEALTH`) and runtime permissions where applicable.

## Licenses

Asset and third‑party licenses are registered in `lib/licenses.dart` and surfaced via Flutter’s LicenseRegistry.

## Contributing

Issues and PRs are welcome. Please open an issue describing your change or problem first.

## Disclaimer

This app integrates with health and fitness services. Ensure users consent to data access and that you comply with all store and platform policies.