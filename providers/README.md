# Provider Packages

Each directory contains a self-contained, no-runtime package for one host:

- `codex/` preserves the existing repository-local Codex skill and agent setup.
- `claude/` provides Claude-oriented project instructions and a manual install.
- `copilot/` provides Copilot-oriented project instructions and a manual install.
- `opencode/` provides OpenCode-oriented project instructions and a manual install.

Every package uses the same policy, handoff, and validation documents in
`docs/`, while documenting its host-specific capability assumptions and
degraded behavior. Read the package README before installing it.
