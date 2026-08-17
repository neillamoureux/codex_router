# Native GitHub Copilot CLI Package

GitHub Copilot custom agents use `.github/agents/*.agent.md`. This package
provides native `standard` and `advanced` profiles; the normal Copilot CLI
session is `primary`.

The profiles are templates. Model selection, tool availability, handoffs, and
agent persistence vary by Copilot CLI version and account. Verify those
capabilities locally before enabling automatic routing.

See [PLUGIN.md](PLUGIN.md) for the plugin/skill metadata boundary.
