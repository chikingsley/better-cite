# AGENTS.md

## Cursor Cloud specific instructions

### Overview

This repository contains two projects:

1. **Better Cite** (primary) — A Swift-native citation manager in `Apps/` and `Packages/`. This is the main project under active development.
2. **Zotero** (reference) — The Firefox/Gecko-based Zotero application used as behavioral inspiration. See `CLAUDE.md` for Zotero-specific build/test commands.

### Better Cite — Swift packages and app

The Swift project is organized as a workspace with modular SPM packages:

| Package | Purpose | Builds on Linux |
|---|---|---|
| `Packages/BCCommon` | Core types (Creator, Identifier, ItemType) | Yes |
| `Packages/BCDomain` | Domain models + in-memory item store | Yes |
| `Packages/BCStorage` | Attachment object store abstraction | Yes |
| `Packages/BCMetadataProviders` | DOI/ISBN/PMID metadata resolution | Yes |
| `Packages/BCCitationEngine` | Citation formatting engine | Yes |
| `Packages/BCDesignSystem` | SwiftUI design tokens | No (requires SwiftUI) |
| `Apps/BetterCiteApp` | SwiftUI macOS app | No (requires SwiftUI + AppKit) |

#### Key commands

| Task | Command |
|---|---|
| Build a package | `cd Packages/BCCommon && swift build` |
| Test a package | `cd Packages/BCCommon && swift test --parallel` |
| Test all packages | `./scripts/test-swift.sh` |
| Lint Swift code | `./scripts/lint-swift.sh` |
| Lint + auto-fix | `./scripts/lint-swift.sh --fix` |
| Lint + test (pre-commit) | `npm run check:swift` |

#### Non-obvious caveats

- **Swift 6.0.3** is installed at `/opt/swift/usr/bin`. The PATH is set in `~/.bashrc`. If `swift` is not found, run `export PATH="/opt/swift/usr/bin:$PATH"`.
- **SwiftLint 0.63.2** is installed at `/usr/local/bin/swiftlint`.
- **`BCDesignSystem` and `BetterCiteApp` cannot build on Linux** because they import SwiftUI/AppKit. The 5 pure-logic packages build and test fine on Linux.
- `scripts/test-swift.sh` iterates all `Package.swift` files under `Apps/` and `Packages/` and runs `swift test --parallel` in each. On Linux, it will fail on `BCDesignSystem` and `BetterCiteApp`. To test only Linux-compatible packages, run tests individually on each package.
- The Xcode workspace (`BetterCite.xcworkspace`) and `BetterCiteMac.xcodeproj` are for macOS Xcode builds only.
- SwiftLint runs successfully on Linux for all Swift files (it parses source, doesn't compile).

### Zotero — reference codebase

Build, lint, and test commands for Zotero are in `CLAUDE.md`. Key non-obvious caveats:

- **`NODE_OPTIONS=--openssl-legacy-provider`** is required for `npm run build`.
- **`rsync`** must be installed — needed by `app/scripts/dir_build`.
- **Git LFS** must be pulled (`git lfs pull`) before `dir_build` can assemble the staging app.
- **Git submodules** must be initialized recursively for Zotero features.
- **XULRunner** must be fetched once via `app/scripts/fetch_xulrunner -p l -a x64` (redone only when `app/config.sh` Gecko version changes).
- Zotero tests: `CI=1 xvfb-run test/runtests.sh -f -b <testname>`. Use `-b` to skip bundled files, `-f` to bail on first failure.
