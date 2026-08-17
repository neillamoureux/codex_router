# Install on Claude

Copy [INSTRUCTIONS.md](INSTRUCTIONS.md) into the target project's supported
Claude project-instructions location, or paste its contents into the project's
Claude instructions. Keep the shared `docs/` files available in the repository
so handoffs and validation references resolve.

If your Claude host supports named subagents, map them to `standard` and
`advanced` and document the mapping locally. If it does not, use the primary
session fallback described in [README.md](README.md).
