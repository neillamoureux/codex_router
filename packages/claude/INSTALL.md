# Install the Native Claude Code Package Globally

These commands install user-level files without relying on the active project.
Replace `/path/to/codex_router` with this checkout's absolute path.

```bash
ROUTER_ROOT=/path/to/codex_router
mkdir -p "$HOME/.claude/agents" "$HOME/.claude/skills/model-router"
cp "$ROUTER_ROOT/packages/global-routing.md" \
  "$HOME/.claude/skills/model-router/SKILL.md"
cp "$ROUTER_ROOT/packages/claude/agents/standard.md" \
  "$HOME/.claude/agents/standard.md"
cp "$ROUTER_ROOT/packages/claude/agents/advanced.md" \
  "$HOME/.claude/agents/advanced.md"
```

Claude Code documents `~/.claude/agents/` as the user-level subagent path and
`~/.claude/skills/` as the user-level skill path. The package's
[`.claude-plugin/plugin.json`](.claude-plugin/plugin.json) and `agents/` are an
alternative plugin installation; use Claude Code's documented plugin flow for
that path.

Configure models by adding a supported `model` field to each global agent's
frontmatter, for example `model: sonnet`, or omit it to inherit the main
session model. Keep `standard` and `advanced` as the role names. The primary
model is the normal Claude Code session.

Restart Claude Code after installing or changing user-level agents/skills.
Verify discovery with `/agents`, then invoke `claude --agent standard` or
`claude --agent advanced`. Automatic description-based delegation is possible,
but explicit invocation is the reliable verification path.

Official references: [Claude Code subagents](https://code.claude.com/docs/en/sub-agents)
and [Claude Code plugins](https://code.claude.com/docs/en/plugins-reference).
