import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GiveawayViewModel()
    @FocusState private var isInputFocused: Bool
    @State private var showPrintableSheet = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    loadPanel
                    giveawayPanel
                    historyPanel
                }
                .padding(.vertical, 24)
                .padding(.horizontal)
                .frame(maxWidth: 840)
                .frame(maxWidth: .infinity)
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationTitle("Code Giveaway")
            .sheet(isPresented: $showPrintableSheet) {
                PrintableSheetView(
                    codes: viewModel.pendingCodes,
                    language: viewModel.session.language
                )
            }
        }
    }

    private var loadPanel: some View {
        Panel(title: "Load Codes") {
            Text("Paste one code per line or separated by commas, then load them into the session.")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Picker("Redeem language", selection: languageBinding) {
                ForEach(RedeemLanguage.allCases) { language in
                    Text(language.displayName).tag(language)
                }
            }
            .pickerStyle(.menu)

            TextEditor(text: $viewModel.inputText)
                .focused($isInputFocused)
                .frame(minHeight: 150)
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color(uiColor: .systemBackground))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(Color(uiColor: .systemGray4), lineWidth: 1)
                )

            HStack(spacing: 12) {
                Button {
                    viewModel.loadCodes()
                    isInputFocused = false
                } label: {
                    Label("Load codes", systemImage: "tray.and.arrow.down.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)

                Button {
                    viewModel.resetSession()
                    isInputFocused = false
                } label: {
                    Label("Reset session", systemImage: "arrow.uturn.backward.circle")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)

                Button {
                    showPrintableSheet = true
                } label: {
                    Label("Printable sheet", systemImage: "printer")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .disabled(viewModel.pendingCodes.isEmpty)
            }

            if let status = viewModel.statusMessage {
                StatusBanner(message: status)
            }
        }
    }

    private var giveawayPanel: some View {
        Panel(title: "Give Away") {
            CountsRow(pendingCount: viewModel.pendingCount, redeemedCount: viewModel.redeemedCount)

            Button {
                viewModel.giveNextCode()
            } label: {
                Label("Give away code", systemImage: "person.crop.circle.badge.checkmark")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.pendingCodes.isEmpty || viewModel.currentCode != nil)

            if let code = viewModel.currentCode, let url = viewModel.currentRedeemURL {
                CurrentCodeView(code: code, redeemURL: url, qrImage: viewModel.qrImage)

                Button {
                    viewModel.markRedeemed()
                } label: {
                    Label("Mark as redeemed", systemImage: "checkmark.seal.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
            } else if viewModel.pendingCodes.isEmpty {
                EmptyStateView(text: "No more codes available. Load a fresh list when you receive new ones.")
            } else {
                EmptyStateView(text: "Tap “Give away code” when you are ready to hand out the next one.")
            }
        }
    }

    private var historyPanel: some View {
        Panel(title: "Redeemed Codes") {
            Text("A quick audit trail to avoid handing out the same code twice.")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            RedeemedListView(codes: viewModel.redeemedCodes)
        }
    }

    private var languageBinding: Binding<RedeemLanguage> {
        Binding(
            get: { viewModel.session.language },
            set: { viewModel.setLanguage($0) }
        )
    }
}

#Preview {
    ContentView()
}
