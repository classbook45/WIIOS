# WIIOS

A custom iOS and iPadOS frontend for the Dolphin GameCube/Wii emulator core.

> **Status:** Milestone 1 — foundation. The current app is a native SwiftUI shell; actual emulation is not connected yet.

## Goals

- A custom game library and navigation experience.
- Simple mode for approachable settings and Expert mode for deeper control.
- Per-game configuration, controller profiles, and diagnostics.
- A native bridge to a compatible Dolphin core, subject to iOS platform constraints.

## Build

1. Open `WIIOS.xcodeproj` in Xcode on macOS.
2. Select the **WIIOS** scheme and an iOS Simulator or connected iOS device.
3. Build and run.

Requirements: Xcode 16 or later; iOS 17.0 deployment target.

## Project layout

- `App/` — SwiftUI app entry point and main interface.
- `Features/Settings/` — settings experience and mode selection.
- `Core/DolphinBridge/` — boundary for future native-core integration.

## Dolphin core

The emulator core is intentionally not vendored in this initial scaffold. Core integration requires an iOS-specific compatibility assessment, a reproducible build configuration, and compliance with Dolphin's GPL-2.0-or-later licensing and notices.

## License

The WIIOS frontend source in this repository is provided under the MIT License. This does not change the license of Dolphin or any third-party components added later. See [LICENSE](LICENSE).
