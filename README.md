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
└── codex-routing.md          # Codex host procedure

packages/
├── codex/                    # native Codex skill and agent templates
├── claude/                   # .claude/agents profiles
├── copilot/                  # .github/agents custom-agent profiles
└── opencode/                 # .opencode/agents profiles

.agents/                     # repository-local Codex skill
.codex/                      # Codex configuration and agents
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

Start with [packages/README.md](packages/README.md) and
[packages/capability-matrix.md](packages/capability-matrix.md). Read the host package
instructions before copying anything:

- [Native Codex](packages/codex/README.md) — [install](packages/codex/INSTALL.md)
- [Native Claude Code](packages/claude/README.md) — [install](packages/claude/INSTALL.md)
- [Native Copilot CLI](packages/copilot/README.md) — [install](packages/copilot/INSTALL.md)
- [Native OpenCode](packages/opencode/README.md) — [install](packages/opencode/INSTALL.md)

Preserve project instructions and configuration, and merge deliberately rather
than overwriting them.

Native artifacts provide role profiles, not a universal automatic router.
Use automatic selection only when the host demonstrably supports it; otherwise
explicitly select `standard` or `advanced` and include the shared handoff.

## Installer

The root [install.sh](install.sh) installs directly from `packages/` without
adding a runtime dependency. It is safe by default: identical files are
skipped, differing files are reported as conflicts, and nothing is overwritten.

```bash
# Preview project installation for every harness.
./install.sh --scope project --harness all --dry-run

# Install one harness into the current project.
./install.sh --scope project --harness claude

# Install all harnesses into user-level global locations.
./install.sh --scope global --harness all
```

The script resolves its source from its own location, so it can be run from a
different working directory. It uses the native paths documented in each
package's [INSTALL.md](packages/codex/INSTALL.md), including `~/.claude`,
`~/.copilot`, `~/.config/opencode`, and Codex's shared skill locations. Resolve
any reported conflict manually, then rerun the command.

## Shared handoff and validation

- [Provider-neutral policy](docs/provider-neutral-policy.md)
- [Handoff protocol](docs/handoff-protocol.md)
- [Validation matrix](docs/validation-matrix.md)
- [No-runtime scope](docs/no-runtime-scope.md)

The [Codex routing procedure](docs/codex-routing.md) documents the Codex host
mapping. Its Luna/Terra/Sol mapping is an example profile; the generic roles
remain `primary`, `standard`, and `advanced`.
