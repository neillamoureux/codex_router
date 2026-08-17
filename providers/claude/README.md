# Claude Package

This package supplies a project instruction file and a manual installation
path. It does not assume a particular Claude subscription, model name, agent
API, or IDE integration.

## Capability profile

The primary lane is the normal Claude session. Configure standard and advanced
lanes using the host's available subagent/session mechanism if present. If
persistent workers or transfer are unavailable, keep one owner in the current
session and paste the handoff protocol when changing lanes. Do not claim
parallelism or cleanup unless the host visibly supports it.

Install [INSTRUCTIONS.md](INSTRUCTIONS.md) as project-level Claude guidance,
using the host's supported project instruction location.
