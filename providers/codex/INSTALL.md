# Install on Codex

From the target project:

```bash
mkdir -p .agents/skills/model-router .codex/agents
cp /path/to/codex_router/.agents/skills/model-router/SKILL.md .agents/skills/model-router/
cp /path/to/codex_router/.codex/agents/model_router_terra.toml .codex/agents/
cp /path/to/codex_router/.codex/agents/model_router_sol.toml .codex/agents/
```

Merge [config.merge.toml](../../.codex/config.merge.toml) into the local Codex
configuration if agents are not already enabled. Preserve existing project
configuration and machine-specific settings.

Validate with [../../docs/validation-matrix.md](../../docs/validation-matrix.md)
and the Codex-specific procedure in [../../docs/codex-routing.md](../../docs/codex-routing.md).
