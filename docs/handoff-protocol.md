# Routing Handoff Protocol

This is the provider-neutral handoff format. Hosts may express it as a prompt,
metadata, a session message, or a native agent request.

## Initial handoff

```text
Task:
<the user's complete engineering objective>

Constraints:
<scope, no-go areas, compatibility requirements, and user decisions>

Context:
<known repository facts and prior conversation>

Assigned lane:
primary | standard | advanced

Validation expected:
<tests, checks, or evidence required before completion>
```

## Continuation

Follow-ups for the same task must include the existing task/session identifier
when the host supports one. Otherwise repeat the task objective and state that
the message continues the existing task. Do not start a competing owner.

## Transfer

When escalating, stop assigning new work to the current owner and pass:

```text
Original task:
<objective>

Reason for transfer:
<why the current lane is insufficient>

Findings:
<established facts>

Changes already made:
<files and behavior, or none>

Relevant code:
<files, symbols, and tests>

Validation:
<commands and results>

Open questions:
<unresolved issues>
```

The next owner is the sole implementation owner. A host without transfer
support should continue in the current session with the same handoff content,
or stop and ask the user to continue manually.

## Completion

The owner reports result, changed files, validation, and remaining uncertainty.
Hosts with explicit lifecycle APIs should close the owner; other hosts should
record completion and avoid implying that a session was programmatically closed.
