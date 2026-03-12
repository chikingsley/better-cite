# Better Cite Swift Packages

The `BC*` prefix is an internal namespace for Better Cite modules.

- `CTStorage` -- object storage connectors (local + S3-compatible providers)
- `CTMetadataProviders` -- metadata provider contracts and resolver
- `CTCitationEngine` -- citation formatting contracts and stubs
- `CTDomain` -- shared domain models and core store protocols
- `CTDesignSystem` -- reusable SwiftUI components and design tokens

## SwiftLint

For repo-wide Swift linting across all packages, run:

```bash
./scripts/lint-swift.sh
```

From repo root.
