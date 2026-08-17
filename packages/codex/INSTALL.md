# Install the Native Codex Package Globally

These commands install user-level files without relying on the active project.
Replace `/path/to/codex_router` with this checkout's absolute path.

```bash
ROUTER_ROOT=/path/to/codex_router
CODEX_USER_HOME="${CODEX_HOME:-$HOME/.codex}"

# Preferred shared Agent Skills discovery path.
mkdir -p "$HOME/.agents/skills/model-router"
cp "$ROUTER_ROOT/packages/global-routing.md" \
  "$HOME/.agents/skills/model-router/SKILL.md"

# Legacy/current Codex-managed path.
mkdir -p "$CODEX_USER_HOME/skills/model-router" "$CODEX_USER_HOME/agents"
cp "$ROUTER_ROOT/packages/global-routing.md" \
  "$CODEX_USER_HOME/skills/model-router/SKILL.md"
cp "$ROUTER_ROOT/packages/codex/.codex/agents/standard.toml" \
  "$CODEX_USER_HOME/agents/router_standard.toml"
cp "$ROUTER_ROOT/packages/codex/.codex/agents/advanced.toml" \
  "$CODEX_USER_HOME/agents/router_advanced.toml"
```

Codex officially documents `$CODEX_HOME/skills` (default `~/.codex/skills`)
for CLI-managed skills and recommends the shared Agent Skills location
`~/.agents/skills` for cross-harness skills. Global discovery of arbitrary agent
TOML files under `$CODEX_HOME/agents` is version-dependent; if they are not
discovered, use the skill's explicit role instructions or a project `.codex`
agent configuration. This is a host/version caveat.

Configure models by editing the copied TOML files:

```toml
name = "router_standard"
model = "<standard-model-available-to-you>"
model_reasoning_effort = "medium"
```

Use the analogous `router_advanced` file with the advanced model and effort.
The primary model is configured in Codex user configuration; this package does
not require a fixed model ID. Existing Terra/Sol files remain compatible.

The optional Codex plugin metadata is at
[`.codex-plugin/plugin.json`](.codex-plugin/plugin.json). Use it only through
Codex's documented plugin flow.

Restart Codex after installing or changing global skills/agents. Invoke the
skill explicitly with `$model-router`, or use automatic skill selection. Verify
with the skills/status UI and a trace such as `ROUTE: NORMAL -> standard`.

Official references: [Codex skills](https://developers.openai.com/codex/skills/)
and the [Codex skills installer guidance](https://github.com/openai/codex/blob/main/codex-rs/skills/src/assets/samples/skill-installer/SKILL.md).
