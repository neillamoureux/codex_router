---
name: model-router
description: Apply the provider-neutral primary/standard/advanced routing policy to Codex software-engineering tasks.
---

# Model Router for Codex

Use the shared policy in `docs/provider-neutral-policy.md`. Classify each task
as SIMPLE, NORMAL, or COMPLEX and map it to `primary`, `standard`, or
`advanced`. Use `docs/handoff-protocol.md` for delegation and transfer and
`docs/validation-matrix.md` for checks.

The generic role names are stable. The Codex agent names and model IDs are
configuration choices. If the host supports native worker threads, retain one
owner per task and reuse that owner for follow-ups. If it does not, continue in
one session and disclose the fallback; do not claim unsupported lifecycle
events.

The repository's existing `.codex` agents are a compatibility/default profile,
not a requirement of this skill.
