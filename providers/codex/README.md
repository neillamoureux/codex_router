# Codex Package

This package maps the provider-neutral roles `primary`, `standard`, and
`advanced` onto the Codex host. Copy the existing repository files as described
in [INSTALL.md](INSTALL.md); do not replace an existing project `AGENTS.md` or
unrelated `.codex` configuration.

## Configurable role mapping

Configure the mapping in the host's Codex configuration and agent definitions:

| Generic role | Codex mapping |
|---|---|
| `primary` | The configured interactive Codex session (`model` and reasoning settings) |
| `standard` | Any Codex agent name and model selected for ordinary engineering |
| `advanced` | Any Codex agent name and model selected for difficult or high-risk work |

The existing `model_router_terra` and `model_router_sol` files are the
**default/example profile** only:

```text
primary  -> gpt-5.6-luna (low effort)
standard -> model_router_terra -> gpt-5.6-terra (medium effort)
advanced -> model_router_sol   -> gpt-5.6-sol (high effort)
```

To customize the mapping, copy the agent TOML files to new names, change each
agent's `name`, `model`, and reasoning settings, then update the role mapping in
the Codex instructions to those names. Keep exactly one configured owner for
each active task. The generic policy does not require the names Terra, Sol, or
Luna.

The Codex host may support persistent workers, messaging, transfer, cleanup,
and concurrency. Treat each as a capability to verify, not as a property of a
role. If a capability is unavailable, use one owner at a time and apply the
provider-neutral handoff manually.

See [../../docs/provider-neutral-policy.md](../../docs/provider-neutral-policy.md)
for the shared contract.
