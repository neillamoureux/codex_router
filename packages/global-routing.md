# Global Model Router Instructions

This file is self-contained. Install it into a host's global skill or
instruction directory; it must not depend on a repository `docs/` directory.

## Routing contract

Classify each software-engineering task before substantial work:

- SIMPLE: obvious, bounded, low-risk work -> `primary`.
- NORMAL: conventional engineering requiring investigation or implementation
  -> `standard`.
- COMPLEX: architecture, ambiguity, concurrency, security, compatibility, or
  unusually high-risk work -> `advanced`.

The roles are abstract. The host profile maps them to models or agents. Keep
one implementation owner per task. Follow-ups remain with that owner. If the
task is reclassified, transfer the handoff and stop assigning new work to the
previous owner. Never claim worker creation, reuse, transfer, concurrency, or
cleanup unless the host confirms that capability.

## Handoff format

For delegation or transfer, include:

```text
Task: <complete engineering objective>
Constraints: <scope, compatibility, and no-go requirements>
Context: <known facts and prior conversation>
Assigned role: primary | standard | advanced
Findings: <established facts>
Changes already made: <files and behavior, or none>
Validation: <commands and results>
Open questions: <unresolved issues>
```

For same-task follow-ups, identify the existing owner/session and include only
the new instruction plus changed constraints. If the host cannot preserve that
context, repeat the handoff and disclose the manual fallback.

## Completion report

Report the selected role and model/profile when known, result, changed files,
validation checks, lifecycle behavior actually observed, and remaining
uncertainty.

## Verification scenarios

1. SIMPLE stays in `primary`.
2. NORMAL uses exactly one `standard` owner or states the fallback.
3. A follow-up reuses that owner when supported.
4. COMPLEX uses exactly one `advanced` owner or states the fallback.
5. A transfer passes the handoff and does not leave two owners working on the
   same task.

Automatic routing is optional. When unavailable or uncertain, explicitly
select the role/profile and report that choice.
