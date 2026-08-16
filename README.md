# Codex Model Router

A repository-local Codex routing policy that keeps the primary session on
Luna with low reasoning effort and delegates substantive engineering tasks to
the appropriate worker.

## Repository contents

```text
.agents/
└── skills/
    └── model-router/
        └── SKILL.md

.codex/
├── agents/
│   ├── model_router_terra.toml
│   └── model_router_sol.toml
└── config.merge.toml

docs/
└── codex-routing.md
```

## Routing behavior

The primary Luna session classifies each software-development task:

```text
SIMPLE   -> LUNA
NORMAL   -> model_router_terra
COMPLEX  -> model_router_sol
```

Simple tasks stay in the primary session. Normal tasks use Terra. Complex,
architectural, highly ambiguous, or high-risk tasks use Sol.

The routing policy is task-scoped. Follow-up messages for the same task are
sent to the existing worker rather than creating another worker.

At most one Terra and one Sol worker may be active at the same time. One Terra
and one Sol worker may run concurrently when they own independent tasks.

Completed workers must be closed so they no longer consume an agent slot.

## Installation

Copy the repository-local files into the project where Model Router should be
used:

```bash
mkdir -p .agents/skills/model-router
mkdir -p .codex/agents

cp /path/to/codex_router/.agents/skills/model-router/SKILL.md \
   .agents/skills/model-router/

cp /path/to/codex_router/.codex/agents/model_router_terra.toml \
   .codex/agents/

cp /path/to/codex_router/.codex/agents/model_router_sol.toml \
   .codex/agents/
```

Do not overwrite the target project's existing `AGENTS.md`, skills, agents, or
Codex configuration.

## Required local Codex configuration

The primary Codex configuration must use Luna with low reasoning effort and
allow two active worker threads:

```toml
model = "gpt-5.6-luna"
model_reasoning_effort = "low"

[agents]
enabled = true
max_concurrent_threads_per_session = 2
```

The repository provides this snippet in
`.codex/config.merge.toml`. Merge it into the user's local Codex
configuration; do not blindly replace the entire configuration.

The local configuration should remain uncommitted if it contains personal
paths, project trust settings, notifications, plugins, MCP servers, or other
machine-specific settings.

## Validation

Start Codex from the target project and verify that routing decisions are
reported as:

```text
ROUTE: SIMPLE -> LUNA
ROUTE: NORMAL -> TERRA
ROUTE: COMPLEX -> SOL
```

Test that:

1. A simple task creates no worker.
2. A normal task creates one Terra worker.
3. A follow-up reuses the existing Terra worker.
4. A complex task creates one Sol worker.
5. A follow-up reuses the existing Sol worker.
6. One Terra and one Sol worker can run concurrently.
7. A second Terra or second Sol worker is never created.
8. Completed workers are closed.

See [docs/codex-routing.md](docs/codex-routing.md) for the complete policy and
test procedure.
