# Install the Native OpenCode Package Globally

These commands install user-level files without relying on the active project.
Replace `/path/to/codex_router` with this checkout's absolute path.

```bash
ROUTER_ROOT=/path/to/codex_router
mkdir -p "$HOME/.config/opencode/agents" \
  "$HOME/.config/opencode/skills/model-router"
cp "$ROUTER_ROOT/packages/global-routing.md" \
  "$HOME/.config/opencode/skills/model-router/SKILL.md"
cp "$ROUTER_ROOT/packages/opencode/.opencode/agents/standard.md" \
  "$HOME/.config/opencode/agents/standard.md"
cp "$ROUTER_ROOT/packages/opencode/.opencode/agents/advanced.md" \
  "$HOME/.config/opencode/agents/advanced.md"
```

OpenCode documents `~/.config/opencode/agents/` for global agents and
`~/.config/opencode/skills/<name>/SKILL.md` for global skills. The supplied
frontmatter uses documented `description` and `mode` fields; adapt it if the
installed release changes its schema.

Use the default OpenCode session as `primary`. Configure each profile with a
supported `model: provider/model` field, or inherit the host model. The copied
profiles are `standard` and `advanced`.

Restart OpenCode after installing or changing global agents/skills. Verify and
invoke explicitly with:

```bash
opencode --agent standard
opencode run --agent advanced "Handle this architectural engineering task."
```

The OpenCode plugin command and config schema are release-dependent. This
package does not install a plugin or write an unverified global config file.
Automatic routing, persistence, transfer, and cleanup must be verified locally.

Official references: [OpenCode agents](https://opencode.ai/docs/agents/),
[global configuration](https://opencode.ai/docs/config/),
[skills](https://opencode.ai/docs/skills), and the [CLI](https://dev.opencode.ai/docs/cli/).
