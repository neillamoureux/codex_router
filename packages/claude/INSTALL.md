# Install the Native Claude Code Package

Copy `.claude/agents/standard.md` and `advanced.md` into the target project's
`.claude/agents/` directory. Preserve existing agents and adjust descriptions,
tools, permissions, or model settings only according to the installed Claude
Code version.

Use the main Claude Code session as `primary`. Automatic routing is not
assumed: explicitly invoke the named subagent when needed, or configure a host
workflow that demonstrably selects it. Continue or transfer using
`docs/handoff-protocol.md`; if the host does not preserve that context, paste
the handoff into the next session.
