# Portfolio Mobile

## Product truth

Portfolio Mobile is a cross-platform Flutter app for browsing Chaowalit
Greepoke's projects, skills, and contact information. It is for recruiters,
interviewers and clients who want to see the owner's work from a phone, and
it doubles as evidence of Flutter work across web, Android and iOS.

## What works today

- Five tabs: Home, Projects, Skills, Contact, Settings, plus a splash screen,
  project detail and About.
- Project list with search/filter and favorites that survive a restart
  (`shared_preferences`).
- Contact actions open email or the website through `url_launcher`, and copy
  the portfolio link or a vCard to the clipboard. There is no in-app message
  form that sends anything by itself; email opens the user's mail app.
- Light/dark theme saved in Settings. Settings also saves an English/Thai
  choice, but the screens are English only; the choice translates nothing yet.
- Crash reporting: release builds made by CI with a Sentry DSN send unhandled
  errors to Sentry with request, user, breadcrumbs and extra removed. No
  tracing, sessions or screenshots.

## What it does not do

- All content is bundled in `lib/data/project_data.dart`. There is no network
  fetch, no offline cache of visited content and no haptic feedback (these
  were claimed on the bookchaowalit.com card; see the card claims review
  2026-10, slug `bookchaowalit-portfolio-mobile`).
- Some bundled project copy is not verified (for example "100+
  micro-frontends" and "Lighthouse 95+" for the web portfolio entry).
- No product analytics; Sentry errors are the only live signal
  ([KPI plan](docs/measurement/KPI-PLAN.md)).

## Distribution and deploy state

- **Web preview:** <https://portfolio-mobile.bookchaowalit.com> returns 200
  (Vercel). It is a Flutter web build deployed by CLI, not from this
  repository's CI, so it can lag `main` (owner action D9).
- **Android:** `build.yml` builds a release App Bundle signed with the upload
  key from Infisical (`/google-play`) on every push to `main` and keeps it as
  an artifact. Upload to the Play internal track runs only on a `v*` tag.
  No store listing is live or claimed.
- **iOS:** `build.yml` builds an unsigned release archive. App Store
  distribution needs signing, device smoke tests and review.

## Evidence

- `flutter analyze` and `flutter test` run on every push and pull request in
  `.github/workflows/ci.yml` (Flutter 3.44.9), with the signing-file guard
  and the shared security scan.
- [specs/001-shared-ci-sentry-tests/spec.md](specs/001-shared-ci-sentry-tests/spec.md).
