# Native Claude Code Package

Claude Code discovers project subagents from `.claude/agents/*.md`. This
package provides direct project profiles there and plugin-native copies under
`agents/`, plus documented `.claude-plugin/plugin.json` metadata. The normal
Claude Code session is `primary`.

The profiles intentionally omit a model field so the host's configured model
or model aliases remain authoritative. Add a supported `model` value locally if
your Claude Code installation exposes that setting.
