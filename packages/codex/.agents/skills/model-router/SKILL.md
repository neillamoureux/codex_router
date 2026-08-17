---
name: model-router
description: Apply the provider-neutral primary/standard/advanced routing policy to Codex software-engineering tasks.
---

# Model Router for Codex

Classify each task as SIMPLE, NORMAL, or COMPLEX and map it to `primary`,
`standard`, or `advanced`. Keep one implementation owner per task, reuse that
owner for follow-ups, and transfer the handoff when reclassifying. Never claim
worker lifecycle events unless Codex confirms them.

For delegation or transfer, include Task, Constraints, Context, Assigned role,
Findings, Changes already made, Validation, and Open questions. Report the
selected role/model, changed files, checks, and uncertainty at completion.

The generic role names are stable. The Codex agent names and model IDs are
configuration choices. If the host supports native worker threads, retain one
owner per task and reuse that owner for follow-ups. If it does not, continue in
one session and disclose the fallback; do not claim unsupported lifecycle
events.

The repository's root `.codex` agents are an optional default profile, not a
requirement of this skill.
