# Model Router Instructions for Claude

Apply the shared policy in `docs/provider-neutral-policy.md`.

Classify each engineering task as SIMPLE, NORMAL, or COMPLEX before substantial
work. Map them to primary, standard, and advanced lanes. Use the handoff format
in `docs/handoff-protocol.md` for delegation, continuation, or transfer.

This package does not require a native subagent feature. If none is available,
perform the task in the current Claude session and state the degraded mode in
the final report. Never invent worker IDs, reuse, cleanup, or concurrency.

Validate against `docs/validation-matrix.md` and report the selected lane,
provider model/profile when known, changed files, checks, and uncertainty.
