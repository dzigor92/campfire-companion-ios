# Pokémon GO Code Giveaway Helper

> Static helper for handing out Pokémon GO digital codes during community events.

This repository hosts a single-page helper that streamlines handing out Pokémon GO passcodes during community events.

## Features

- Paste a batch of codes (newline or comma separated) and load them into the tool.
- Generate the official redemption link and QR code for the first pending code.
- Mark codes as redeemed to keep a running history and avoid duplicates.
- Resume exactly where you left off after a refresh thanks to automatic local storage.
- Generate a printable QR sheet for the pending codes with a single click.
- Pick the Pokémon GO store language (en, es, pt, de, fr) before generating links and QR codes.
- Clear the session and load a fresh set whenever new codes arrive.

## Using the page locally

1. Open `index.html` in any modern browser.
2. Choose the redemption language (defaults to English), paste your codes into the textarea (one per line works best), and press **Load codes**.
3. When you're ready to hand out a code, click **Give away code**.
4. Ask the trainer to scan the QR code or tap the redemption link.
5. After they redeem it, click **Mark as redeemed** to archive the code and move to the next one.

> Tip: You can press `Ctrl+Enter` (`⌘+Enter` on macOS) while the textarea is focused to load codes quickly.
> Bonus: If you refresh the page, the pending list will be restored automatically and the textarea will repopulate so you can keep going.
> Need printed codes? Press **Printable sheet** and download/print the generated template. (Open it from the same browser where you loaded the session so it can read the saved codes.)

## iOS companion app

An iOS version of the helper lives in `ios/CampfireCompanion`. It mirrors the web tool’s capabilities:

- Load bulk codes (one per line or comma separated) and keep an audit trail of redeemed codes.
- Pick the redemption language before handing out a code.
- Present a QR code, share link, and copy helpers for the active passcode.
- Generate an on-device printable sheet for the remaining codes.
- Persist the full session in `UserDefaults` so the flow resumes after relaunch.

### Getting started in Xcode

1. Create a new **iOS · App** project in Xcode (SwiftUI lifecycle, Swift language).
2. Replace the generated app files with the contents of `ios/CampfireCompanion`. Keep the asset catalog directory when you drag the folder in.
3. Make sure the target’s deployment info is set to iOS 17 or later (SwiftUI `NavigationStack` and `ShareLink` are required).
4. Build & run on simulator or device. The app saves sessions automatically, so you can quit and resume where you left off.

Feel free to adjust colors, typography, or assets inside the SwiftUI panels if you want a different look on iOS. The logic for parsing, persistence, and QR generation is shared via the files in `Models`, `Services`, and `ViewModels`.

## Customising

All styling and logic lives inside `index.html`. Feel free to tweak the CSS or replace the QR generation logic with a preferred library if you need offline QR images.

## Contributing

Curious about helping out? Check the [contribution guidelines](CONTRIBUTING.md),
review our [Code of Conduct](.github/CODE_OF_CONDUCT.md), and read the
[security policy](.github/SECURITY.md) for responsible disclosure details.
The project is licensed under the [MIT License](LICENSE).
