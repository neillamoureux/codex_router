# Codex Model Routing

This repository uses a model-routing policy to select the appropriate Codex
execution tier for software-development tasks.

## Routing policy

The primary Codex session runs on Luna with low reasoning effort and acts as
the routing coordinator.

Tasks are classified as follows:

| Classification | Execution |
|---|---|
| SIMPLE | Handle directly in Luna |
| NORMAL | Delegate to one `model_router_terra` worker |
| COMPLEX | Delegate to one `model_router_sol` worker |

The coordinator must report the selected route before substantive work:

```text
ROUTE: SIMPLE -> LUNA
ROUTE: NORMAL -> TERRA
ROUTE: COMPLEX -> SOL
```

## Worker limits

At most one worker of each role may be active at the same time:

- Maximum one `model_router_terra`
- Maximum one `model_router_sol`

One Terra and one Sol worker may run concurrently when they own independent
tasks.

The same task must have only one implementation owner. If a task is
reclassified from NORMAL to COMPLEX, ownership transfers from Terra to Sol;
both workers must not continue independently on the same task.

## Worker reuse

Routing is task-scoped rather than turn-scoped.

When a worker already owns the current task:

1. Do not spawn another worker of the same role.
2. Send follow-up instructions to the existing worker with `send_input`.
3. Continue using that worker until the task is complete or ownership changes.

Follow-ups, clarifications, test failures, and requests to continue are part
of the existing task unless they represent a materially different objective.

## Worker cleanup

When a worker reaches a terminal state:

1. Record its result and validation information.
2. Call `close_agent`.
3. Clear the worker reference for that task.

Completed workers should be closed promptly because they may continue to count
toward the configured concurrency limit.

## Agent definitions

The worker definitions are stored in:

```text
.codex/agents/model_router_terra.toml
.codex/agents/model_router_sol.toml
```

The routing policy is stored in:

```text
.agents/skills/model-router/SKILL.md
```

## Required local Codex configuration

The repository policy expects the local Codex configuration to enable agents
and allow two total active worker threads:

```toml
[agents]
enabled = true
max_concurrent_threads_per_session = 2
```

This setting belongs in the user's local Codex configuration. It should not be
committed with machine-specific settings, paths, notifications, credentials,
MCP configuration, or project trust entries.

## Validation checklist

Use a fresh Codex session when testing the routing policy.

### SIMPLE task

Submit a small, obvious request such as:

```text
Rename a misspelled local variable and update its test.
```

Expected result:

```text
ROUTE: SIMPLE -> LUNA
```

No worker should be spawned.

### NORMAL task

Submit an ordinary implementation or debugging request.

Expected result:

```text
ROUTE: NORMAL -> TERRA
```

Exactly one `model_router_terra` worker should be created.

Send a follow-up before it finishes:

```text
Continue the same task and add focused tests.
```

The follow-up should be sent to the existing Terra worker. A second Terra
worker should not be created.

### COMPLEX task

Submit a task involving architecture, concurrency, security, or difficult
ambiguous debugging.

Expected result:

```text
ROUTE: COMPLEX -> SOL
```

Exactly one `model_router_sol` worker should be created.

Send a follow-up before it finishes. It should reuse the existing Sol worker.

### Terra and Sol concurrently

Start one independent NORMAL task and one independent COMPLEX task before
either finishes.

Expected result:

- One Terra worker is active.
- One Sol worker is active.
- Both workers may run concurrently.
- A second Terra or second Sol worker is not created.

### Cleanup

After a worker finishes, confirm that it is closed. Then start another task of
the same role.

Expected result:

- The completed worker is no longer counted as active.
- A new worker may be created for the new task.
- No stale completed worker prevents the new task from running.

## Expected routing trace

A valid trace may look like this:

```text
ROUTE: NORMAL -> TERRA
SPAWNED: model_router_terra <id>

REUSED: model_router_terra <id>

ROUTE: COMPLEX -> SOL
SPAWNED: model_router_sol <id>

CLOSED: model_router_terra <id>
CLOSED: model_router_sol <id>
```

An invalid trace contains two active workers of the same role:

```text
SPAWNED: model_router_terra <id-1>
SPAWNED: model_router_terra <id-2>
```
