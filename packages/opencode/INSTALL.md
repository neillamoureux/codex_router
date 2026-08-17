# Install the Native OpenCode Package

Run these commands from the root of the project where OpenCode will run:

```bash
mkdir -p .opencode/agents
cp /path/to/codex_router/packages/opencode/.opencode/agents/standard.md \
  .opencode/agents/
cp /path/to/codex_router/packages/opencode/.opencode/agents/advanced.md \
  .opencode/agents/
```

Replace `/path/to/codex_router` with the local path to this repository. These
are project-level OpenCode agents.

## Configure models and permissions

Open each copied Markdown file and set its `model`, `permission`, and other
frontmatter fields according to the OpenCode version and models available in
your account. Keep the agent IDs `standard` and `advanced` unless you also
change how they are invoked.

Use the default OpenCode session as `primary`. If the local release supports
agent selection, explicitly select the appropriate role or configure its
documented agent mapping. Do not add a guessed plugin or config manifest.
Automatic routing, persistence, transfer, and cleanup must be verified in the
local host; otherwise use one owner and the shared handoff protocol.

See [CONFIGURATION.md](CONFIGURATION.md) for the documented-entry-point
guidance.

## Verify

Start OpenCode in the target project and use its agent selector or `@` agent
invocation to confirm that `standard` and `advanced` are available. Invoke
each once and verify the selected model and permissions before relying on
automatic delegation.
