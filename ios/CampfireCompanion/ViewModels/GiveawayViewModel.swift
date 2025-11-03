import Combine
import Foundation
import SwiftUI
import UIKit

@MainActor
final class GiveawayViewModel: ObservableObject {
    @Published private(set) var session: GiveawaySession
    @Published var statusMessage: StatusMessage?
    @Published var inputText: String = ""
    @Published private(set) var qrImage: UIImage?

    private let storage: SessionStoring
    private let qrGenerator: QRCodeGenerator

    init(
        storage: SessionStoring = UserDefaultsSessionStore(),
        qrGenerator: QRCodeGenerator = QRCodeGenerator()
    ) {
        self.storage = storage
        self.qrGenerator = qrGenerator

        if let restored = storage.load() {
            session = restored
            inputText = restored.pending.joined(separator: "\n")
            statusMessage = StatusMessage(text: "Session restored. Ready to continue.", style: .info)
        } else {
            session = GiveawaySession()
            statusMessage = StatusMessage(text: "Paste your codes to begin.", style: .info)
        }

        refreshQRCode()
    }

    var pendingCodes: [String] { session.pending }
    var redeemedCodes: [String] { session.redeemed }
    var pendingCount: Int { session.pending.count }
    var redeemedCount: Int { session.redeemed.count }
    var currentCode: String? { session.current }

    func loadCodes() {
        let trimmed = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        let codes = CodeParser.parse(trimmed)

        guard !codes.isEmpty else {
            statusMessage = StatusMessage(text: "Paste at least one code to get started.", style: .error)
            return
        }

        session.pending = codes
        session.redeemed = []
        session.current = nil

        statusMessage = StatusMessage(
            text: "Loaded \(codes.count) code\(codes.count == 1 ? "" : "s"). Ready when you are!",
            style: .success
        )

        persist()
        syncInput()
        refreshQRCode()
    }

    func giveNextCode() {
        guard session.current == nil, let first = session.pending.first else {
            return
        }

        session.current = first
        statusMessage = StatusMessage(text: "Share this code with the next trainer.", style: .success)

        persist()
        refreshQRCode()
    }

    func markRedeemed() {
        guard let current = session.current else {
            return
        }

        if let first = session.pending.first, first == current {
            session.pending.removeFirst()
        } else if let index = session.pending.firstIndex(of: current) {
            session.pending.remove(at: index)
        }

        session.redeemed.insert(current, at: 0)
        session.current = nil

        statusMessage = StatusMessage(text: "Marked as redeemed. You can hand out the next code.", style: .success)

        persist()
        syncInput()
        refreshQRCode()
    }

    func resetSession() {
        session.pending = []
        session.redeemed = []
        session.current = nil

        statusMessage = StatusMessage(
            text: "Session reset. Load a new batch of codes whenever you're ready.",
            style: .info
        )

        persist()
        syncInput()
        refreshQRCode()
    }

    func setLanguage(_ language: RedeemLanguage) {
        guard session.language != language else {
            return
        }

        session.language = language
        persist()
        refreshQRCode()
    }

    func redeemURL(for code: String) -> URL {
        let languageCode = session.language.rawValue
        let encodedCode = code.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? code
        let urlString = "https://store.pokemongo.com/\(languageCode)/offer-redemption?passcode=\(encodedCode)"

        return URL(string: urlString)!
    }

    var currentRedeemURL: URL? {
        guard let code = session.current else {
            return nil
        }

        return redeemURL(for: code)
    }

    private func persist() {
        storage.save(session)
    }

    private func refreshQRCode() {
        guard let url = currentRedeemURL else {
            qrImage = nil
            return
        }

        qrImage = qrGenerator.makeImage(from: url.absoluteString)
    }

    private func syncInput() {
        inputText = session.pending.joined(separator: "\n")
    }
}
