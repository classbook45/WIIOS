import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            LibraryView()
                .tabItem {
                    Label("Library", systemImage: "square.grid.2x2.fill")
                }
                .tag(0)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "slider.horizontal.3")
                }
                .tag(1)

            DiagnosticsView()
                .tabItem {
                    Label("System", systemImage: "waveform.path.ecg")
                }
                .tag(2)
        }
        .tint(.cyan)
    }
}

private struct LibraryView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(spacing: 10) {
                    Image(systemName: "gamecontroller.fill")
                        .font(.system(size: 48, weight: .medium))
                        .foregroundStyle(.cyan)
                    Text("Your games, your way.")
                        .font(.title2.bold())
                    Text("Your GameCube and Wii library will appear here.")
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 42)

                ContentUnavailableView(
                    "No Games Yet",
                    systemImage: "opticaldisc",
                    description: Text("Game importing and library scanning are planned for a future milestone.")
                )
                Spacer(minLength: 0)
            }
            .padding()
            .navigationTitle("WIIOS")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.secondary)
                        .accessibilityLabel("Search (coming soon)")
                }
            }
        }
    }
}

private struct DiagnosticsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Application") {
                    LabeledContent("Frontend", value: "WIIOS SwiftUI")
                    LabeledContent("Build stage", value: "Milestone 1")
                    LabeledContent("Emulation core", value: "Not connected")
                }

                Section {
                    Label("Dolphin core integration is planned. This screen currently reports frontend status only.", systemImage: "info.circle")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("System")
        }
    }
}

#Preview {
    ContentView()
}
