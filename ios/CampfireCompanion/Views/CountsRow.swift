import SwiftUI

struct CountsRow: View {
    let pendingCount: Int
    let redeemedCount: Int

    var body: some View {
        HStack(spacing: 12) {
            CountBadge(label: "Available", count: pendingCount, tint: Color.blue)
            CountBadge(label: "Redeemed", count: redeemedCount, tint: Color.purple)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct CountBadge: View {
    let label: String
    let count: Int
    let tint: Color

    var body: some View {
        HStack(spacing: 6) {
            Text(label)
                .font(.subheadline.weight(.semibold))
            Text("\(count)")
                .font(.subheadline.monospaced().weight(.medium))
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .background(tint.opacity(0.15), in: Capsule())
        .overlay(
            Capsule()
                .stroke(tint.opacity(0.35), lineWidth: 1)
        )
        .foregroundStyle(tint)
    }
}

#Preview {
    CountsRow(pendingCount: 12, redeemedCount: 4)
        .padding()
}
