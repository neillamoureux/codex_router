# Install the Native OpenCode Package

Copy `standard.md` and `advanced.md` into the target project's
`.opencode/agents/` directory. Preserve existing agents and adapt frontmatter
fields only to the installed OpenCode version.

Use the default OpenCode session as `primary`. If the local release supports
agent selection, explicitly select the appropriate role or configure its
documented agent mapping. Do not add a guessed plugin or config manifest.
Automatic routing, persistence, transfer, and cleanup must be verified in the
local host; otherwise use one owner and the shared handoff protocol.

See [CONFIGURATION.md](CONFIGURATION.md) for the documented-entry-point
guidance.
