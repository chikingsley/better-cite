set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

default:
    @just --list

lint-swift:
    ./scripts/lint-swift.sh

lint-swift-fix:
    ./scripts/lint-swift.sh --fix

test-swift:
    ./scripts/test-swift.sh

check-swift:
    ./scripts/lint-swift.sh && ./scripts/test-swift.sh

commit-swift +args:
    ./scripts/commit-swift-checked.sh {{args}}

dev-backend:
    cd backend && bun run dev

deploy-backend:
    cd backend && bun run deploy

db-migrate-local:
    cd backend && bun run db:migrate:local

db-migrate:
    cd backend && bun run db:migrate

typecheck-backend:
    cd backend && bunx tsc --noEmit
