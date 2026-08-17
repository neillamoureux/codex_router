# Provider-Neutral Model Routing Policy

This repository defines a provider-neutral policy for routing software
engineering tasks by prompt hardness, risk, and expected cost. It does not
contain a runtime, provider SDK integration, or universal model ranking.

## Core contract

Classify each task exactly once initially:

| Class | Meaning | Default lane |
|---|---|---|
| SIMPLE | Bounded, obvious, low-risk work | `primary` |
| NORMAL | Conventional engineering requiring investigation or implementation | `standard` |
| COMPLEX | Architecture, ambiguity, concurrency, security, or unusually high-risk work | `advanced` |

The lane names are abstract. A host package maps them to the host's available
models, agents, sessions, or manual instructions. Never put vendor model IDs
in this policy.

## Invariants

- Optimize for the least expensive lane likely to complete the task reliably.
- Routing is task-scoped, not turn-scoped; follow-ups retain the task owner.
- A task has at most one active implementation owner.
- Reclassification transfers ownership and its handoff; it does not create a
  second independent implementation.
- The host must disclose when it cannot provide worker persistence, messaging,
  cleanup, or concurrency guarantees.
- A provider fallback may reduce capability, but must not silently claim that a
  worker was created or reused.

## Host mapping

Each provider package should document these capabilities:

```yaml
primary: <host's normal interactive model/session>
standard: <host's ordinary delegated model/session, or primary fallback>
advanced: <host's strongest delegated model/session, or primary fallback>
capabilities:
  persistent_workers: true|false|unknown
  worker_messaging: true|false|unknown
  worker_cleanup: true|false|unknown
  parallel_workers: true|false|unknown
```

`unknown` is a reason to use the conservative behavior: one owner, explicit
handoffs, and no claim of lifecycle enforcement.
