import Foundation

/// Describes the integration state of the native Dolphin core.
///
/// This is deliberately a status boundary, not an emulator implementation.
/// A later milestone will replace the unavailable state with a native
/// Objective-C++ bridge backed by an iOS-compatible Dolphin core build.
enum DolphinCoreStatus {
    case notIntegrated
    case initializing
    case ready
    case failed(String)

    var displayName: String {
        switch self {
        case .notIntegrated:
            return "Not connected"
        case .initializing:
            return "Initializing"
        case .ready:
            return "Ready"
        case .failed(let message):
            return "Unavailable: \(message)"
        }
    }
}
