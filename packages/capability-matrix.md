# Native Capability Matrix

Capabilities depend on the installed host version, account, editor, and local
configuration. The matrix describes the native artifact shape and the safe
fallback when a capability is unavailable.

| Host | `primary` | `standard` / `advanced` | Follow-up/transfer | Safe degradation |
|---|---|---|---|---|
| Codex | Interactive session | `.codex/agents/*.toml` | Native worker thread when enabled | Continue in one owner with explicit handoff |
| Claude Code | Main Claude Code session | `.claude/agents/*.md` subagents | Native subagent/session behavior when available | Paste handoff into the current session |
| Copilot CLI | Main Copilot CLI session | `.github/agents/*.agent.md` custom agents | Host-dependent; verify each session handoff | Keep one current owner |
| OpenCode | Default session | `.opencode/agents/*.md` agents | Host/configuration-dependent | Use one session and explicit transfer notes |

## Automatic versus explicit routing

Native profiles define roles and instructions; they do not guarantee that the
host automatically classifies every prompt.

- **Automatic routing:** use only when the host has a verified mechanism that
  selects an agent/profile from the prompt. Record the selected role in the
  trace.
- **Explicit routing:** invoke the named profile or paste the role instruction
  when automatic selection is unavailable or uncertain.
- **Fallback:** keep one implementation owner, include the handoff fields from
  `docs/handoff-protocol.md`, and disclose that delegation/lifecycle behavior is
  unavailable.

Never claim worker creation, reuse, transfer, concurrency, or cleanup based only
on the presence of an artifact file.
