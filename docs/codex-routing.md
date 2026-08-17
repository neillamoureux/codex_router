# Codex Host Routing

This document describes the Codex host mapping for the provider-neutral
`primary`, `standard`, and `advanced` roles. The role names are stable; Codex
agent names and model IDs are configurable.

## Routing policy

The configured Codex interactive session acts as the `primary` coordinator and
simple-work lane. Configure `standard` and `advanced` with any suitable Codex
agents in the host configuration.

Tasks are classified as follows:

| Classification | Generic role |
|---|---|
| SIMPLE | Handle directly in `primary` |
| NORMAL | Delegate to one `standard` worker |
| COMPLEX | Delegate to one `advanced` worker |

The coordinator should report the selected generic route before substantive
work:

```text
ROUTE: SIMPLE -> primary
ROUTE: NORMAL -> standard
ROUTE: COMPLEX -> advanced
```

### Default/example Codex profile

The repository's existing files provide this optional compatibility profile:

```text
primary  -> gpt-5.6-luna (low effort)
standard -> model_router_terra -> gpt-5.6-terra (medium effort)
advanced -> model_router_sol   -> gpt-5.6-sol (high effort)
```

Users may replace the agent names, model IDs, and effort settings without
changing the generic policy. See [providers/codex/README.md](../providers/codex/README.md)
and [providers/codex/INSTALL.md](../providers/codex/INSTALL.md).

## Worker limits

At most one worker for each generic role may be active at the same time:

- Maximum one `standard` worker
- Maximum one `advanced` worker

One standard and one advanced worker may run concurrently when the configured
Codex host supports it and they own independent tasks.

The same task must have only one implementation owner. If a task is
reclassified from NORMAL to COMPLEX, ownership transfers from `standard` to
`advanced`; both workers must not continue independently on the same task.

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

The default/example worker definitions are stored in:

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
ROUTE: SIMPLE -> primary
```

No worker should be spawned.

### NORMAL task

Submit an ordinary implementation or debugging request.

Expected result:

```text
ROUTE: NORMAL -> standard
```

Exactly one configured `standard` worker should be created, or the host should
report its documented fallback.

Send a follow-up before it finishes:

```text
Continue the same task and add focused tests.
```

The follow-up should be sent to the existing `standard` worker. A second
standard worker should not be created.

### COMPLEX task

Submit a task involving architecture, concurrency, security, or difficult
ambiguous debugging.

Expected result:

```text
ROUTE: COMPLEX -> advanced
```

Exactly one configured `advanced` worker should be created, or the host should
report its documented fallback.

Send a follow-up before it finishes. It should reuse the existing advanced
worker.

### Standard and advanced concurrently

Start one independent NORMAL task and one independent COMPLEX task before
either finishes.

Expected result:

- One standard worker is active.
- One advanced worker is active.
- Both workers may run concurrently.
- A second standard or advanced worker is not created.

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
ROUTE: NORMAL -> standard
SPAWNED: standard <id>

REUSED: standard <id>

ROUTE: COMPLEX -> advanced
SPAWNED: advanced <id>

CLOSED: standard <id>
CLOSED: advanced <id>
```

An invalid trace contains two active workers of the same role:

```text
SPAWNED: standard <id-1>
SPAWNED: standard <id-2>
```
