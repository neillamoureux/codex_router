# Native Host Packages

`packages/` contains copyable, no-runtime integration artifacts for hosts that
provide native instruction or agent formats. The older `providers/` packages
remain supported compatibility guides; they are intentionally not removed.

| Host | Native artifacts | Native routing status |
|---|---|---|
| Codex | `.agents/skills/`, `.codex/agents/` | Native skill plus agent TOML templates |
| Claude Code | `.claude/agents/*.md` | Native named subagent profiles |
| GitHub Copilot CLI | `.github/agents/*.agent.md` | Native custom-agent profiles |
| OpenCode | `.opencode/agents/*.md` | Native agent profiles; config/plugin guidance is documented separately |

These artifacts reference the shared policy and handoff documents. They do not
contain a classifier, router process, provider SDK, credentials, or pricing
database.

Start with [capability-matrix.md](capability-matrix.md), then read the host
package README and INSTALL guide.
