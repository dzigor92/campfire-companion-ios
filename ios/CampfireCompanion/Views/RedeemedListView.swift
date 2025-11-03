import SwiftUI

struct RedeemedListView: View {
    let codes: [String]

    var body: some View {
        if codes.isEmpty {
            EmptyStateView(text: "Redeemed codes will appear here once you hand out the first one.")
        } else {
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(codes, id: \.self) { code in
                    Text(code)
                        .font(.body.monospaced())
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(Color(uiColor: .systemGray6).opacity(0.65))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(Color(uiColor: .systemGray3).opacity(0.5), lineWidth: 1)
                        )
                }
            }
        }
    }
}

#Preview {
    RedeemedListView(codes: ["ABC123", "XYZ789"])
        .padding()
}
