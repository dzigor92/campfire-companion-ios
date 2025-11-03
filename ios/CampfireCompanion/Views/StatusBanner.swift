import SwiftUI

struct StatusBanner: View {
    let message: StatusMessage

    private var tint: Color {
        switch message.style {
        case .info:
            return Color.accentColor
        case .success:
            return Color.green
        case .error:
            return Color.red
        }
    }

    var body: some View {
        Text(message.text)
            .font(.body.weight(.medium))
            .foregroundStyle(tint)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 6)
    }
}

#Preview {
    StatusBanner(message: StatusMessage(text: "Loaded codes.", style: .success))
        .padding()
}
