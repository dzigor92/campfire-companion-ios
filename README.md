# Campfire Companion

SwiftUI iOS app for handing out Pokémon GO digital codes during community events. It mirrors the workflow of the original web helper but lives natively on iPhone and iPad.

> Looking for the browser version? It continues to live in the dedicated `pogo-code-redemption` repository. Use that repo for static HTML/CSS/JS hosting; this project focuses on the iOS build.

## Features

- Paste a batch of codes (newline or comma separated) and load them into the session.
- Generate the official redemption link and QR code for the current passcode.
- Mark codes as redeemed to keep a running history and avoid duplicates.
- Resume exactly where you left off thanks to automatic `UserDefaults` persistence.
- Generate an on-device printable QR sheet for the pending codes.
- Pick the Pokémon GO store language (en, es, pt, de, fr) before generating links and QR codes.
- Share or copy the active redemption link directly from the app.

## Getting started in Xcode

1. Create a new **iOS · App** project in Xcode (SwiftUI lifecycle, Swift language).
2. Drag the contents of `ios/CampfireCompanion` into the project, replacing the template files. Keep the asset catalog folder when importing.
3. Set the deployment target to iOS 17 (or later) so `NavigationStack`, `ShareLink`, and the QR APIs are available.
4. Build & run on a simulator or device. The session saves automatically, so you can quit and resume where you left off.

## Project layout

```
ios/CampfireCompanion/
├── CampfireCompanionApp.swift   # App entry point
├── ContentView.swift            # Root screen composing the panels
├── Models/                      # Session, language, and status types
├── Services/                    # Parsing, persistence, and QR helpers
├── ViewModels/                  # ObservableObject driving UI state
└── Views/                       # Reusable SwiftUI components + printable sheet
```

Feel free to adjust colors, typography, or assets inside the SwiftUI panels if you want a different look on iOS. The view model encapsulates the business logic and can be unit-tested outside of SwiftUI if you add tests.

## Contributing

Curious about helping out? Check the [contribution guidelines](CONTRIBUTING.md),
review our [Code of Conduct](.github/CODE_OF_CONDUCT.md), and read the
[security policy](.github/SECURITY.md) for responsible disclosure details.
The project is licensed under the [MIT License](LICENSE).
