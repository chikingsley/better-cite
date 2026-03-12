# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Citration is a citation management app for macOS. It consists of:

- **CitrationMac** (`Apps/CitrationMac/`) — Native Swift macOS app
- **CT* Swift Packages** (`Packages/`) — Modular Swift packages (CTCommon, CTDomain, CTStorage, CTCitationEngine, CTDesignSystem, CTDataLocal, CTDataRemote, CTMetadataProviders)
- **Backend** (`backend/`) — Cloudflare Workers API (`citration-api`)
- **Zotero reference** (`zotero/`) — Forked Zotero codebase used as reference/inspiration (not actively built)

## Build & Development Commands

### Swift (CitrationMac)

```bash
just lint-swift          # SwiftLint check mode
just lint-swift-fix      # SwiftLint auto-fix
just test-swift          # Run all Swift package tests
just check-swift         # Lint + test
```

SwiftLint config lives in `.swiftlint.yml`.
CI runs SwiftLint under `.github/workflows/swiftlint.yml`.

### Backend

```bash
just dev-backend         # Local dev server
just deploy-backend      # Deploy to Cloudflare
just typecheck-backend   # TypeScript type check
just db-migrate-local    # Run D1 migrations locally
just db-migrate          # Run D1 migrations (production)
```

## Architecture

### Citration Swift Packages

- **CTCommon** — Shared types (Creator, Identifier, ItemType)
- **CTDomain** — Domain models (ItemModels, ItemStore protocol)
- **CTStorage** — Attachment object storage (local + S3-compatible)
- **CTCitationEngine** — Citation formatting
- **CTDesignSystem** — Design tokens
- **CTDataLocal** — SwiftData persistence
- **CTDataRemote** — API client, auth, keychain
- **CTMetadataProviders** — DOI/metadata resolution

### Zotero Reference (`zotero/`)

The `zotero/` directory contains a fork of the Zotero desktop app used for reference. It has its own `package.json`, build system (`js-build/`), and submodules. See `zotero/translators/CLAUDE.md` for translator guidelines.

Key Zotero layers (all under `zotero/`):
- **XPCOM modules** (`chrome/content/zotero/xpcom/`) — Core business logic
- **Data model** (`chrome/content/zotero/xpcom/data/`) — ORM-like database entities
- **Build system** (`js-build/`) — Custom Node.js build (Babel, Sass, Browserify)

## Code Style

### Swift (Citration)
- SwiftLint enforced (see `.swiftlint.yml`)
- Strict mode: force casts/unwraps are errors
- Else/catch on new line (statement_position disabled)

### Zotero JS (reference only)
- Tabs for indentation
- `let` over `const` except for true scalar constants
- No cuddled braces
- Objects attach to `Zotero` global namespace
