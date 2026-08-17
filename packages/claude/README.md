# Native Claude Code Package

Claude Code discovers project subagents from `.claude/agents/*.md`. This
package provides native markdown profiles for `standard` and `advanced`; the
normal Claude Code session is `primary`.

The profiles intentionally omit a model field so the host's configured model
or model aliases remain authoritative. Add a supported `model` value locally if
your Claude Code installation exposes that setting.
