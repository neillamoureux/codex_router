# Copilot Package

This package supplies host-neutral Copilot instructions and manual setup
guidance. It does not assume a specific editor, GitHub account, model catalog,
or agent mode.

## Capability profile

Use the normal Copilot chat/agent session as primary. Map standard and advanced
to available Copilot agent modes or selected models only when the host exposes
those controls. Otherwise use a single-session fallback with explicit handoffs.
Parallel workers, persistent threads, and programmatic cleanup are unsupported
unless verified in the chosen Copilot host.
