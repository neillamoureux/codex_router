# Codex Package

This package preserves the existing Codex integration. Copy the existing
repository files as described in [INSTALL.md](INSTALL.md); do not replace an
existing project `AGENTS.md` or unrelated `.codex` configuration.

## Capability profile

- Primary lane: the configured Codex interactive session.
- Standard lane: `model_router_terra`.
- Advanced lane: `model_router_sol`.
- Persistent workers, messaging, transfer, cleanup, and two-worker
  concurrency are expected when the documented Codex configuration is enabled.

If the local Codex version or configuration does not provide those features,
use one owner at a time and apply the provider-neutral handoff manually.

See [../../docs/provider-neutral-policy.md](../../docs/provider-neutral-policy.md)
for the shared contract.
