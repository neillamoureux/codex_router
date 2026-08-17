# Install the Native Codex Package

Run these commands from the root of the project where Codex will run:

```bash
mkdir -p .agents/skills/model-router .codex/agents
cp /path/to/codex_router/packages/codex/.agents/skills/model-router/SKILL.md \
  .agents/skills/model-router/
cp /path/to/codex_router/packages/codex/.codex/agents/standard.toml \
  .codex/agents/
cp /path/to/codex_router/packages/codex/.codex/agents/advanced.toml \
  .codex/agents/
```

Replace `/path/to/codex_router` with the local path to this repository. Merge
the files with project configuration rather than replacing unrelated Codex
settings.

Configure the mapping as:

```text
primary  -> the configured interactive Codex session
standard -> the agent copied from standard.toml
advanced -> the agent copied from advanced.toml
```

Set `name`, `model`, reasoning effort, and instructions in the two TOML files.
The example profile uses the generic agent names `standard` and `advanced`;
replace the model IDs with models available in your Codex account.

Merge the relevant agent settings from the existing
[config.merge.toml](../../.codex/config.merge.toml) into the local Codex
configuration. Confirm that the host supports worker messaging and cleanup
before relying on those lifecycle guarantees.

For automatic routing, configure the host/coordinator to select the generic
role and report it. Otherwise explicitly invoke the standard or advanced agent
and include the [handoff protocol](../../docs/handoff-protocol.md).

## Verify

Start Codex in the target project and confirm that the skill is discovered.
Submit one simple, one normal, and one complex test prompt. Confirm that the
session reports `primary`, `standard`, and `advanced` respectively, and that
the configured models are used.
