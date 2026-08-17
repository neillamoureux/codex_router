# Install the Native GitHub Copilot CLI Package Globally

These commands install user-level files without relying on the active project.
Replace `/path/to/codex_router` with this checkout's absolute path.

```bash
ROUTER_ROOT=/path/to/codex_router
mkdir -p "$HOME/.copilot/agents" "$HOME/.copilot/skills/model-router"
cp "$ROUTER_ROOT/packages/global-routing.md" \
  "$HOME/.copilot/skills/model-router/SKILL.md"
cp "$ROUTER_ROOT/packages/copilot/.github/agents/standard.agent.md" \
  "$HOME/.copilot/agents/standard.agent.md"
cp "$ROUTER_ROOT/packages/copilot/.github/agents/advanced.agent.md" \
  "$HOME/.copilot/agents/advanced.agent.md"
```

GitHub documents `~/.copilot/agents/` for personal custom agents and
`~/.copilot/skills/<name>/SKILL.md` for personal skills. Do not install these
files only under `.github/` when the goal is global availability.

Configure models by adding a supported `model` field to each agent frontmatter,
or omit it to inherit the session model. The main Copilot CLI session is
`primary`; the copied profiles are `standard` and `advanced`.

Restart the CLI after installing or changing agents/skills. Verify discovery
with `/agent`, then invoke explicitly:

```bash
copilot --agent standard --prompt "Classify and handle this engineering task."
copilot --agent advanced --prompt "Handle this architectural engineering task."
```

Automatic inference is supported by descriptions, but explicit `--agent` is
the reliable verification path. This package has no separate plugin manifest;
use only a Copilot CLI plugin format documented by the installed release.

Official references: [Copilot CLI custom agents](https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/create-custom-agents-for-cli),
[custom agent invocation](https://docs.github.com/en/copilot/how-tos/copilot-cli/use-copilot-cli/invoke-custom-agents),
and the [CLI configuration directory](https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-config-dir-reference).
