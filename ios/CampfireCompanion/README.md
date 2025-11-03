# Campfire Companion (iOS)

SwiftUI implementation of the Pokémon GO code giveaway helper.

## Highlights

- Mirrors the web helper: load bulk codes, assign one at a time, keep a redeemed log.
- Generates localized redemption URLs and QR codes with Core Image.
- Saves session data in `UserDefaults` so you can resume between launches.
- Includes an on-device printable grid for pending codes.
- Offers copy, share, and Safari handoff options for the active code.

## Project layout

```
CampfireCompanionApp.swift   // App entry point
ContentView.swift            // Root screen composed of the panels below
Models/                      // Session, language, and status types
Services/                    // Code parsing, persistence, and QR generation
ViewModels/                  // ObservableObject driving UI state
Views/                       // Reusable SwiftUI components and printable sheet
Assets.xcassets/             // Placeholder asset catalog
```

## Getting started

1. In Xcode 15+, create a new **iOS App** project using the SwiftUI lifecycle.
2. Drag the contents of this folder into the project navigator, replacing the placeholders.
3. Set the deployment target to iOS 17 (or later) and ensure `ShareLink` is available.
4. Build and run on a simulator or device. The session will persist across launches automatically.

Feel free to customise styling or extend functionality. The view model encapsulates all state transitions and can be unit-tested independently.
