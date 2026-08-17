# Install on Codex

From the target project:

```bash
mkdir -p .agents/skills/model-router .codex/agents
cp /path/to/codex_router/.agents/skills/model-router/SKILL.md .agents/skills/model-router/
cp /path/to/codex_router/.codex/agents/model_router_terra.toml .codex/agents/
cp /path/to/codex_router/.codex/agents/model_router_sol.toml .codex/agents/
```

Those files install the repository's **default/example profile**. They map the
generic roles as follows:

```text
primary  -> the configured interactive session
standard -> model_router_terra
advanced -> model_router_sol
```

To customize the mapping:

1. Keep or copy the files under new agent names in `.codex/agents/`.
2. Set each agent's `model`, reasoning effort, and instructions for the desired
   standard or advanced lane.
3. Update the copied skill/instructions or project guidance so `standard` and
   `advanced` point to those agent names. The role names remain
   `primary`/`standard`/`advanced`; agent names are implementation details.
4. Validate the selected mapping with the shared matrix and record the host
   capabilities and any degraded lifecycle behavior.

Merge [config.merge.toml](../../.codex/config.merge.toml) into the local Codex
configuration only if agents are not already enabled. Its model values are
part of the default/example profile, not a required provider-neutral mapping.
Preserve existing project configuration and machine-specific settings.

Validate with [../../docs/validation-matrix.md](../../docs/validation-matrix.md)
and the Codex-specific procedure in [../../docs/codex-routing.md](../../docs/codex-routing.md).
