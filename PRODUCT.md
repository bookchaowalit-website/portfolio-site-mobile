# Portfolio Mobile

## Product truth

Portfolio Mobile is a cross-platform Flutter app for browsing Chaowalit
Greepoke's projects, skills, and contact information. The current public
release is a Flutter web preview; native distribution is a separate release
track.

## Evidence

- `flutter analyze` passes with no issues.
- `flutter test` passes the widget test suite.
- `flutter build web --release` produces the public preview shipped at
  `https://portfolio-mobile.bookchaowalit.com`.

## Boundary

Native iOS and Android publication still needs device-level smoke testing,
signing, and store review. No store listing is claimed by this repository.
