import Foundation

enum RedeemLanguage: String, CaseIterable, Identifiable, Codable {
    case en
    case es
    case pt
    case de
    case fr

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .en: return "English"
        case .es: return "Spanish"
        case .pt: return "Portuguese"
        case .de: return "German"
        case .fr: return "French"
        }
    }
}
