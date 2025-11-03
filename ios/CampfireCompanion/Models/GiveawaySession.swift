import Foundation

struct GiveawaySession: Codable {
    var pending: [String]
    var redeemed: [String]
    var current: String?
    var language: RedeemLanguage

    init(
        pending: [String] = [],
        redeemed: [String] = [],
        current: String? = nil,
        language: RedeemLanguage = .en
    ) {
        self.pending = pending
        self.redeemed = redeemed
        self.current = current
        self.language = language
    }
}
