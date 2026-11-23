# iOS Dolphin Core Integration

## Selected upstream candidate

WIIOS will initially evaluate **iCube**, the iOS/iPadOS/tvOS Dolphin fork maintained by Provenance-Emu:

- Repository: https://github.com/Provenance-Emu/iCube
- Upstream ancestry: forked from brand175/dolphin-ios
- Active development branch: `develop`
- Build guide: `Source/iOS/BUILDING.md`
- Core build script: `BuildiOSXCFramework.py`

This is a better starting point than attempting to compile the desktop Dolphin app for iOS. iCube already has an iOS app project, a Dolphin-core XCFramework build path, and documented device/simulator build workflows.

The original DolphiniOS codebase by OatmealDome is also a useful reference:
https://github.com/OatmealDome/dolphin-ios

## Source strategy

Do not copy the full emulator source into the WIIOS repository. It is a large upstream project with many independent submodules and its own update history.

Instead, `scripts/bootstrap-dolphin-ios.sh` checks out iCube into the ignored `.build/dolphin-ios` directory and initializes its submodules. The exact resolved Git commit is recorded in `.build/dolphin-ios-revision.txt` for each build.

The initial checkout follows the upstream `develop` branch. Before shipping or relying on a release build, choose and pin a reviewed commit SHA in CI.

## Build facts

The upstream iCube guide states:

- Xcode 15+ is required; Xcode 16+ is recommended.
- Tuist generates the iOS workspace.
- `BuildiOSXCFramework.py` builds the Dolphin core.
- The checked-in XCFramework contains device slices; simulator slices must be built separately.
- A full core build can take 30–60+ minutes.

The core build is deliberately opt-in in GitHub Actions to keep ordinary WIIOS UI builds quick and avoid spending CI minutes unexpectedly.

## WIIOS integration boundary

WIIOS keeps its own SwiftUI app and settings. The emulator is treated as a native engine dependency:

```text
WIIOS SwiftUI
    |
    v
WIIOS-owned Swift API
    |
    v
Objective-C++ adapter
    |
    v
iCube / Dolphin native core
```

Do not import iCube's application UI into WIIOS. First inspect the public/native interfaces and framework headers, then define the smallest WIIOS-owned adapter.

## Compatibility gates

Before declaring the core integrated, verify:

1. The selected core builds for iOS device (arm64).
2. A simulator slice is available for simulator builds.
3. WIIOS can link the framework without importing iCube's app target.
4. Initialization and shutdown can be called safely from Swift.
5. Input, video presentation, audio, save data, and per-game configuration have explicit adapter APIs.
6. JIT availability is treated as a runtime capability, not a guaranteed feature. The app must retain a non-JIT fallback where supported.

## Licensing

Dolphin/iCube core code is GPL-2.0-or-later. WIIOS's MIT license applies only to WIIOS-authored frontend code; it does not relicense the emulator or its dependencies. Preserve upstream license files, copyright notices, and required source-offer/source-distribution materials when distributing builds.
