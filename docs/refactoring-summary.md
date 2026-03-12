# Citration Refactoring Summary

## What Changed

### 1. Shared Types Package (`CTCommon`)

Created `Packages/CTCommon/` to eliminate type duplication across packages.

**New shared types:**

| Type | Replaces | Package(s) affected |
|------|----------|-------------------|
| `Creator` | `BCCreator` (CTDomain) + `CreatorName` (CTMetadataProviders) | CTDomain, CTMetadataProviders |
| `Identifier` + `IdentifierType` | `MetadataIdentifier` + `MetadataIdentifierType` (CTMetadataProviders) + `BCItem.doi: String?` (CTDomain) | CTDomain, CTMetadataProviders |
| `ItemType` | `CanonicalItemType` (CTMetadataProviders) | CTDomain, CTMetadataProviders |

**Key design decisions:**
- `Creator` uses `givenName`/`familyName`/`literalName` naming (more descriptive)
- `Creator` keeps `id: UUID` for `Identifiable` conformance in SwiftUI views
- `BCItem.doi` is now a computed property reading from `identifiers: [Identifier]`
- Both `CTDomain` and `CTMetadataProviders` re-export `CTCommon` via `@_exported import`

### 2. Dependency Graph (New)

```text
CTCommon (no dependencies)
  ↑
  ├── CTDomain (depends on CTCommon)
  ├── CTMetadataProviders (depends on CTCommon)
  │
  │   (unchanged -- no new dependencies)
  ├── CTCitationEngine
  ├── CTStorage
  └── CTDesignSystem
        ↑
        └── CitrationApp (depends on all above + Inject)
```

### 3. AppModel Simplification

The manual type bridging in `AppModel.addByDOI()` was eliminated:

**Before:**
```swift
let creators = best.creators.map {
    BCCreator(givenName: $0.given, familyName: $0.family, literalName: $0.literal)
}
let item = BCItem(
    title: best.title,
    doi: best.identifiers.first { $0.type == .doi }?.value,
    creators: creators,
    publicationYear: best.publicationYear
)
```

**After:**
```swift
let item = BCItem(
    title: best.title,
    identifiers: best.identifiers,
    itemType: best.itemType,
    creators: best.creators,
    publicationYear: best.publicationYear
)
```

### 4. Platform Declarations

Removed `.iOS(.v17)` from all 5 library packages. The project is macOS-only (CTDesignSystem uses `NSColor`). All packages now declare only `.macOS(.v14)`.

### 5. Test Migration (XCTest -> Swift Testing)

All test files migrated from XCTest to Swift Testing framework:

| Pattern | Before (XCTest) | After (Swift Testing) |
|---------|-----------------|----------------------|
| Test class | `class Foo: XCTestCase` | `@Suite("Foo") struct Foo` |
| Test method | `func testSomething()` | `@Test("description") func something()` |
| Assertion | `XCTAssertEqual(a, b)` | `#expect(a == b)` |
| Unwrap | `guard let x = ... else { XCTFail; return }` | `let x = try #require(...)` |
| Error test | `do { try ... } catch { ... }` | `await #expect(throws: Error.self) { ... }` |
| Parameterized | manual loop | `@Test(arguments: [...])` |
| Failure | `XCTFail("msg")` | `Issue.record("msg")` |

**Test counts by package:**

| Package | Tests |
|---------|-------|
| CTCommon | 8 |
| CTDomain | 7 |
| CTMetadataProviders | 5 |
| CTCitationEngine | 5 |
| CTStorage | 10 |
| CTDesignSystem | 2 |
| CitrationApp | 4 |
| **Total** | **41** |

### 6. Scheme Fixes

- **Test targets wired:** All 7 test targets added to the scheme's `<TestAction>`. Cmd+U now runs all tests.
- **SwiftLint pre-action:** Added `<EnvironmentBuildable>` with `<BuildableReference>` so `$SRCROOT` is reliably available.

## Files Changed

**New files (10):**
- `Packages/CTCommon/Package.swift`
- `Packages/CTCommon/Sources/CTCommon/Creator.swift`
- `Packages/CTCommon/Sources/CTCommon/Identifier.swift`
- `Packages/CTCommon/Sources/CTCommon/ItemType.swift`
- `Packages/CTCommon/Tests/CTCommonTests/CreatorTests.swift`
- `Packages/CTCommon/Tests/CTCommonTests/IdentifierTests.swift`
- `Packages/CTDomain/Sources/CTDomain/Exports.swift`
- `Packages/CTMetadataProviders/Sources/CTMetadataProviders/Exports.swift`
- `Citration.xcworkspace/contents.xcworkspacedata` (added CTCommon)
- `docs/refactoring-summary.md` (this file)

**Modified files (14):**
- 6x `Package.swift` (5 libraries + 1 app)
- `Packages/CTDomain/Sources/CTDomain/ItemModels.swift`
- `Packages/CTMetadataProviders/Sources/CTMetadataProviders/MetadataModels.swift`
- `Apps/CitrationApp/Sources/CitrationApp/AppModel.swift`
- `Apps/CitrationApp/Sources/CitrationApp/MockDOIProvider.swift`
- `Citration.xcworkspace/xcshareddata/xcschemes/CitrationApp.xcscheme`
- 6x test files (all rewritten XCTest -> Swift Testing)

**Deleted types:**
- `BCCreator` (replaced by `Creator` from CTCommon)
- `CreatorName` (replaced by `Creator` from CTCommon)
- `MetadataIdentifier` (replaced by `Identifier` from CTCommon)
- `MetadataIdentifierType` (replaced by `IdentifierType` from CTCommon)
- `CanonicalItemType` (replaced by `ItemType` from CTCommon)

## Remaining Recommendations

1. **Proper `.app` bundle**: `CitrationApp` is an `.executableTarget` (bare binary). For distribution, create an Xcode project target with Info.plist, entitlements, and code signing.
2. **Persistent storage**: `InMemoryItemStore` loses data on quit. Consider SwiftData or SQLite when ready.
3. **Real metadata providers**: Replace `MockDOIMetadataProvider` with a real CrossRef/OpenAlex DOI resolver.
4. **Real citation engine**: Replace `StubCitationFormatter` with citeproc-js or a native CSL processor.
5. **S3 implementation**: `S3CompatibleObjectStore` currently throws `unsupportedOperation` for all methods.
