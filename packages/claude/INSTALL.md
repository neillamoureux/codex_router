# Install the Native Claude Code Package

Run these commands from the root of the project where Claude Code will run:

```bash
mkdir -p .claude/agents
cp /path/to/codex_router/packages/claude/agents/standard.md .claude/agents/
cp /path/to/codex_router/packages/claude/agents/advanced.md .claude/agents/
```

Replace `/path/to/codex_router` with the local path to this repository. The
files in `.claude/agents/` are project-level Claude Code subagents and should
be committed to the target project.

## Configure models

Edit the `model` field in each copied file if you want separate cost tiers:

```yaml
model: haiku       # standard.md
model: sonnet      # advanced.md
```

Use model aliases or full model IDs supported by the Claude Code account. If
the `model` field is omitted, the subagent inherits the host's model.

## Use the roles

The main Claude Code session is `primary`. Explicitly route work with prompts
such as:

```text
Use the standard subagent for this task.
Use the advanced subagent for this architecture task.
```

Automatic delegation may work from the descriptions, but verify it locally
before relying on it for cost control. Follow [handoff-protocol.md](../../docs/handoff-protocol.md)
when continuing or transferring work.

## Verify

Start a new Claude Code session in the target project and ask it to use each
role once. Confirm that `standard` and `advanced` appear as available
subagents and that each reports the intended model.
