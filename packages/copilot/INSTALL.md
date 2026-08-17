# Install the Native GitHub Copilot CLI Package

Run these commands from the root of the project where GitHub Copilot CLI will
run:

```bash
mkdir -p .github/agents
cp /path/to/codex_router/packages/copilot/.github/agents/standard.agent.md \
  .github/agents/
cp /path/to/codex_router/packages/copilot/.github/agents/advanced.agent.md \
  .github/agents/
```

Replace `/path/to/codex_router` with the local path to this repository. These
files are repository-level Copilot custom agents and should be committed to
the target project.

## Configure models and tools

Open each copied `.agent.md` file and adjust its YAML frontmatter for the
models and tools available to your Copilot CLI account. Keep the agent IDs
`standard` and `advanced` unless you also update your invocation commands.

Copilot CLI may require a restart before newly added agents appear.

The main Copilot CLI session is `primary`. Explicitly invoke a custom agent
with commands such as:

```text
Use the standard agent for this task.
Use the advanced agent for this architecture task.
```

If your installation supports repository instructions or skills, add the
shared policy from `docs/provider-neutral-policy.md` using that mechanism. Use
the shared handoff protocol when continuing work.

## Verify

Restart Copilot CLI, run `/agent`, and confirm that `standard` and `advanced`
are listed. Invoke each once and confirm that the selected agent reports the
expected role and model.
