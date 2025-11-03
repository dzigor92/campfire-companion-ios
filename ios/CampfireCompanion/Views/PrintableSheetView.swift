import SwiftUI
import UIKit

struct PrintableSheetView: View {
    @Environment(\.dismiss) private var dismiss

    let codes: [String]
    let language: RedeemLanguage
    private let qrGenerator = QRCodeGenerator()

    private var items: [PrintableItem] {
        codes.map { code in
            let url = redeemURL(for: code)
            return PrintableItem(
                code: code,
                redeemURL: url,
                qrImage: qrGenerator.makeImage(from: url.absoluteString)
            )
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Print or screenshot this sheet to hand out codes offline. Each tile contains the passcode, QR code, and redemption link in \(language.displayName).")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 16) {
                        ForEach(items) { item in
                            PrintableTile(item: item)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Printable Sheet")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func redeemURL(for code: String) -> URL {
        let encoded = code.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? code
        let rawValue = language.rawValue
        let urlString = "https://store.pokemongo.com/\(rawValue)/offer-redemption?passcode=\(encoded)"
        return URL(string: urlString)!
    }
}

private struct PrintableItem: Identifiable {
    let id = UUID()
    let code: String
    let redeemURL: URL
    let qrImage: UIImage?
}

private struct PrintableTile: View {
    let item: PrintableItem

    var body: some View {
        VStack(spacing: 14) {
            Text(item.code)
                .font(.title3.monospaced().weight(.semibold))
                .frame(maxWidth: .infinity)

            if let qrImage = item.qrImage {
                Image(uiImage: qrImage)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 160, height: 160)
            }

            Text(item.redeemURL.absoluteString)
                .font(.footnote.monospaced())
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color(uiColor: .systemGray3), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 6)
    }
}

#Preview {
    PrintableSheetView(
        codes: ["ABC123", "XYZ789", "LMN456", "QRS098"],
        language: .en
    )
}
