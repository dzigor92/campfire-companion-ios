import Foundation

enum StatusStyle {
    case info
    case success
    case error
}

struct StatusMessage: Equatable {
    let text: String
    let style: StatusStyle
}
