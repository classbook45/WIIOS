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

The selected iOS core candidate is [iCube](https://github.com/Provenance-Emu/iCube), an open-source iOS/iPadOS/tvOS Dolphin fork with a documented XCFramework build path. WIIOS checks it out into the ignored `.build/dolphin-ios` directory rather than copying its large source tree into this repository. See [Core Integration](Core/DolphinBridge/CORE_INTEGRATION.md). Run `bash scripts/bootstrap-dolphin-ios.sh` on macOS to fetch the source and its submodules. The `Dolphin iOS Core` GitHub Actions workflow validates the checkout; its manual `build_core` option can build the iOS device XCFramework. The core is not yet linked to WIIOS, and the upstream `develop` branch is currently tracked pending review and commit pinning. Dolphin/iCube core code is GPL-2.0-or-later; WIIOS's MIT license applies only to WIIOS-authored frontend code.

## License

The WIIOS frontend source in this repository is provided under the MIT License. This does not change the license of Dolphin or any third-party components added later. See [LICENSE](LICENSE).
