# Install the Native Claude Code Package

Preferred plugin path: install this package using Claude Code's documented
plugin installation flow; the manifest is
[`.claude-plugin/plugin.json`](.claude-plugin/plugin.json) and plugin agents are
in `agents/`.

For direct project installation, copy `.claude/agents/standard.md` and
`advanced.md` into the target project's `.claude/agents/` directory. Preserve
existing agents and adjust descriptions, tools, permissions, or model settings
only according to the installed Claude Code version.

Use the main Claude Code session as `primary`. Automatic routing is not
assumed: explicitly invoke the named subagent when needed, or configure a host
workflow that demonstrably selects it. Continue or transfer using
`docs/handoff-protocol.md`; if the host does not preserve that context, paste
the handoff into the next session.
