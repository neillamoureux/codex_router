# Provider-Neutral Model Router

A repository-local, no-runtime policy for routing software-development prompts
by hardness, risk, and expected cost. The policy can be hosted by Codex,
Claude, Copilot, or OpenCode through provider-specific instruction/install
packages.

The repository deliberately does not include Python, Node, a daemon, provider
SDK clients, credentials, automatic model pricing, or an automatic classifier.
The host executes the policy and supplies its own model/session configuration.

## Repository contents

```text
docs/
├── provider-neutral-policy.md
├── handoff-protocol.md
├── validation-matrix.md
├── no-runtime-scope.md
└── codex-routing.md          # existing Codex procedure

providers/
├── codex/                    # preserves the existing Codex integration
├── claude/
├── copilot/
└── opencode/

.agents/                     # existing Codex skill
.codex/                      # existing Codex configuration and agents
```

## Routing policy

| Class | Provider-neutral lane | Intended use |
|---|---|---|
| SIMPLE | `primary` | Obvious, bounded, low-risk work |
| NORMAL | `standard` | Conventional engineering requiring investigation or implementation |
| COMPLEX | `advanced` | Architecture, ambiguity, concurrency, security, or high-risk work |

The lane names are not model names. Each host package maps them to models,
agents, or sessions available in that host. Follow-ups remain with the same
task owner. A reclassification transfers ownership and its handoff rather than
creating a competing implementation.

## Install by host

Read the package instructions before copying anything:

- [Codex](providers/codex/README.md) — [install](providers/codex/INSTALL.md)
- [Claude](providers/claude/README.md) — [install](providers/claude/INSTALL.md)
- [Copilot](providers/copilot/README.md) — [install](providers/copilot/INSTALL.md)
- [OpenCode](providers/opencode/README.md) — [install](providers/opencode/INSTALL.md)

Provider packages are additive. Preserve existing project instructions and
configuration, and merge deliberately rather than overwriting them.

## Shared handoff and validation

- [Provider-neutral policy](docs/provider-neutral-policy.md)
- [Handoff protocol](docs/handoff-protocol.md)
- [Validation matrix](docs/validation-matrix.md)
- [No-runtime scope](docs/no-runtime-scope.md)

The existing [Codex routing procedure](docs/codex-routing.md) remains valid for
Codex installations and retains its original Luna/Terra/Sol behavior.
