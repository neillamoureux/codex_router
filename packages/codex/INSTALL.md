# Install the Native Codex Package

From the target repository, copy the package's `.agents/` and `.codex/agents/`
directories into the project, merging existing files rather than replacing
them. The templates contain placeholders for the model IDs available in your
Codex account.

Configure the mapping as:

```text
primary  -> the configured interactive Codex session
standard -> the agent copied from standard.toml
advanced -> the agent copied from advanced.toml
```

Set `model`, reasoning effort, and instructions in the two TOML files. If your
project already uses `model_router_terra` and `model_router_sol`, keep those
files and treat them as the standard and advanced mappings; no migration is
required. The existing [providers/codex](../../providers/codex/README.md)
guide documents that compatibility profile.

Merge the relevant agent settings from the existing
[config.merge.toml](../../.codex/config.merge.toml) into the local Codex
configuration. Confirm that the host supports worker messaging and cleanup
before relying on those lifecycle guarantees.

For automatic routing, configure the host/coordinator to select the generic
role and report it. Otherwise explicitly invoke the standard or advanced agent
and include the [handoff protocol](../../docs/handoff-protocol.md).
