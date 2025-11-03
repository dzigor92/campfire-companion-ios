import SwiftUI
import UIKit

struct CurrentCodeView: View {
    let code: String
    let redeemURL: URL
    let qrImage: UIImage?

    @State private var copied = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Share this code with the next trainer. Ask them to scan the QR or open the link.")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(code)
                .font(.title2.monospaced().weight(.semibold))
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color(uiColor: .systemGray6))
                )

            VStack(alignment: .leading, spacing: 10) {
                Link(destination: redeemURL) {
                    Label("Redemption link", systemImage: "safari")
                        .font(.headline)
                }

                ShareLink(item: redeemURL, message: Text("Pokémon GO code: \(code)")) {
                    Label("Share link", systemImage: "square.and.arrow.up")
                }
                .font(.headline)
            }

            if let qrImage {
                VStack(spacing: 12) {
                    Image(uiImage: qrImage)
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 220, height: 220)
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(Color(uiColor: .systemBackground))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(Color(uiColor: .systemGray3), lineWidth: 1)
                        )

                    Text("Scan with the official Pokémon GO store.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
            }

            Button {
                UIPasteboard.general.string = code
                copied = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    copied = false
                }
            } label: {
                Label(copied ? "Copied!" : "Copy code", systemImage: copied ? "checkmark.circle" : "doc.on.doc")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    CurrentCodeView(
        code: "ABC123XYZ",
        redeemURL: URL(string: "https://store.pokemongo.com/en/offer-redemption?passcode=ABC123XYZ")!,
        qrImage: QRCodeGenerator().makeImage(from: "https://store.pokemongo.com")
    )
    .padding()
}
