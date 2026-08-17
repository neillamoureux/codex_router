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

packages/
├── codex/                    # native Codex skill and agent templates
├── claude/                   # .claude/agents profiles
├── copilot/                  # .github/agents custom-agent profiles
└── opencode/                 # .opencode/agents profiles

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

Start with [packages/README.md](packages/README.md),
[packages/capability-matrix.md](packages/capability-matrix.md), and
[packages/compatibility.md](packages/compatibility.md). Read the host package
instructions before copying anything:

- [Native Codex](packages/codex/README.md) — [install](packages/codex/INSTALL.md)
- [Native Claude Code](packages/claude/README.md) — [install](packages/claude/INSTALL.md)
- [Native Copilot CLI](packages/copilot/README.md) — [install](packages/copilot/INSTALL.md)
- [Native OpenCode](packages/opencode/README.md) — [install](packages/opencode/INSTALL.md)

Preserve existing project instructions and configuration, and merge
deliberately rather than overwriting them. Existing installations copied from
the former `providers/` tree remain compatible; see
[compatibility.md](packages/compatibility.md).

Native artifacts provide role profiles, not a universal automatic router.
Use automatic selection only when the host demonstrably supports it; otherwise
explicitly select `standard` or `advanced` and include the shared handoff.

## Shared handoff and validation

- [Provider-neutral policy](docs/provider-neutral-policy.md)
- [Handoff protocol](docs/handoff-protocol.md)
- [Validation matrix](docs/validation-matrix.md)
- [No-runtime scope](docs/no-runtime-scope.md)

The existing [Codex routing procedure](docs/codex-routing.md) remains available
for Codex installations. Its Luna/Terra/Sol mapping is documented there only
as the repository's default/example profile; the generic roles remain
`primary`, `standard`, and `advanced`.
