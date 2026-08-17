# Provider Packages

Each directory contains a self-contained, no-runtime compatibility guide for
one host. Native-format artifacts now live under [`packages/`](../packages/README.md):

- `codex/` preserves the existing repository-local Codex skill and agent setup.
- `claude/` provides Claude-oriented project instructions and a manual install.
- `copilot/` provides Copilot-oriented project instructions and a manual install.
- `opencode/` provides OpenCode-oriented project instructions and a manual install.

Every package uses the same policy, handoff, and validation documents in
`docs/`, while documenting its host-specific capability assumptions and
degraded behavior. Read the package README before installing it. Prefer the
native package when the host supports its documented format; use these guides
when preserving an existing integration or when the host's packaging varies.
