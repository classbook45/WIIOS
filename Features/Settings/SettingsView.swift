import SwiftUI

enum WIIOSSettingsMode: String, CaseIterable, Identifiable {
    case simple = "Simple"
    case expert = "Expert"

    var id: String { rawValue }
}

struct SettingsView: View {
    @AppStorage("settings.mode") private var selectedMode = WIIOSSettingsMode.simple.rawValue
    @AppStorage("settings.autoOptimize") private var autoOptimize = true
    @AppStorage("settings.showPerformanceOverlay") private var showPerformanceOverlay = false
    @AppStorage("settings.audioEnabled") private var audioEnabled = true

    private var mode: WIIOSSettingsMode {
        WIIOSSettingsMode(rawValue: selectedMode) ?? .simple
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Settings mode", selection: $selectedMode) {
                        ForEach(WIIOSSettingsMode.allCases) { option in
                            Text(option.rawValue).tag(option.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                } footer: {
                    Text(mode == .simple
                         ? "Simple mode keeps the experience approachable with recommended defaults."
                         : "Expert mode exposes additional configuration as core integration is implemented.")
                }

                Section("Experience") {
                    Toggle("Automatic optimization", isOn: $autoOptimize)
                    Toggle("Performance overlay", isOn: $showPerformanceOverlay)
                    Toggle("Audio enabled", isOn: $audioEnabled)
                }

                if mode == .expert {
                    Section("Advanced — coming later") {
                        LabeledContent("Graphics backend", value: "Not available")
                        LabeledContent("Internal resolution", value: "Core not connected")
                        LabeledContent("CPU engine", value: "Core not connected")
                    }
                }

                Section {
                    Text("Settings are stored locally on this device. Individual emulator options will be added when the Dolphin bridge is ready.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
        .preferredColorScheme(.dark)
}
