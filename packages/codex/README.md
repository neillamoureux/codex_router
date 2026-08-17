# Native Codex Package

This is the native Codex package. It preserves the existing repository-local
`.agents/` skill and `.codex/agents/` TOML approach while mapping the generic
roles `primary`, `standard`, and `advanced`.

## Contents

- `.agents/skills/model-router/SKILL.md` — compact native skill entry point.
- `.codex/agents/standard.toml` — configurable standard-agent template.
- `.codex/agents/advanced.toml` — configurable advanced-agent template.
- `.codex-plugin/plugin.json` and `skills/` — plugin metadata and skill entry point.
- [INSTALL.md](INSTALL.md) — additive installation and customization steps.

The existing root `.codex` files remain the compatibility/default profile. The
native package templates use generic agent names and do not require Luna,
Terra, or Sol.
