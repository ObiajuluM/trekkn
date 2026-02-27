# Walk It — Release Notes

Version: 0.1.0 (build 5)
Date: 2026-02-02

## Highlights

- Foundational app structure for step‑tracking and wellness.
- Light and dark themes with a central theme provider.
- Google Sign‑In support and backend API client scaffolding.

## Features

- Background processing: background step tracking and scheduled notifications (lib/global/modules/background/).
- Authentication: Google Sign‑In (lib/global/modules/auth/google_auth.dart).
- API & networking: backend client and URL definitions (lib/global/modules/api/).
- Pages & navigation: landing, home, goal, missions, ranking, explore, friends, me, permissions, no‑connection, primary, topboard (lib/pages/).
- UI components: sizing helpers, page transition animations, typewriter effect (lib/global/components/).
- Theming: light and dark themes with a provider (lib/themes/).
- Assets: icons, logos, fonts, and Lottie animation (assets/).

## Platform & Build

- Android and iOS projects configured; Google Services present for Android (android/app/google-services.json).
- Firebase config files included (firebase.json) and iOS runner setup.

## Improvements

- Initial project setup aligned with Flutter best practices (analysis_options.yaml, devtools_options.yaml).

## Bug Fixes

- Not applicable for this initial release note.

## Known Issues

- None documented here. Please report issues via the project tracker.

## Upgrade Notes

- No migration steps required for this version.

---

If you need a more granular, change‑by‑change log, consider adding a `CHANGELOG.md` and populating it from your Git commit history (e.g., Conventional Commits + auto‑changelog).
