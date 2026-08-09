---
name: model-router
description: Route software-development tasks by reasoning complexity and cost. Use for coding, debugging, refactoring, tests, code review, architecture, configuration changes, and repository work. Handle simple work directly in the primary Luna session, delegate normal engineering to model_router_terra, and delegate difficult or high-risk work to model_router_sol.
---

# Model Router

The primary interactive Codex session is the routing coordinator and SIMPLE
implementation lane.

For every substantive software-development request, classify the task before
doing substantial implementation work.

Use exactly one initial classification:

- SIMPLE
- NORMAL
- COMPLEX

During routing validation, state the decision before beginning work using
exactly:

ROUTE: SIMPLE -> LUNA

or:

ROUTE: NORMAL -> TERRA

or:

ROUTE: COMPLEX -> SOL

Then follow the corresponding instructions below.

Do not spend substantial tokens investigating merely to make the routing
decision.

## Terminology

A TURN is one user message.

A TASK is the continuing engineering objective being worked on across one or
more turns.

A WORKER is a subagent assigned to a task.

Routing is TASK-scoped, not TURN-scoped.

## Single-worker invariant

Model routing selects an execution tier, not a team of agents.

For each user request, spawn at most ONE model-router worker at a time.

- SIMPLE: spawn no worker; perform the work in the primary session.
- NORMAL: spawn exactly one `model_router_terra` worker.
- COMPLEX: spawn exactly one `model_router_sol` worker.

Do NOT spawn multiple workers for:
- alternative solutions,
- parallel investigation,
- architecture comparison,
- independent review,
- brainstorming,
- increased confidence,
- faster execution.

A COMPLEX classification means "use the complex worker", not "use multiple
complex workers".

Only spawn another worker when:
1. the current worker has finished, AND
2. an explicit escalation from NORMAL to COMPLEX is required.

Even during escalation, there must be only one active model-router
implementation worker.

Do not use Codex's general multi-agent parallelism as part of this routing
skill.

## Worker continuity invariant

A model-router worker belongs to the current engineering TASK, not to a
single user message or turn.

Before spawning any worker, determine whether an existing model-router worker
already owns the current task.

If an existing worker owns the current task:

1. Do NOT spawn another worker at the same routing level.
2. Route the user's follow-up instruction to that existing worker thread.
3. Continue using that worker until:
   - the task is complete,
   - the user starts a materially different task, or
   - the worker explicitly requests escalation.

A follow-up question, clarification, changed requirement, requested adjustment,
test failure, or request to continue DOES NOT by itself create a new task.

Examples that remain the same task:

- "Now add tests for that."
- "Actually make that configurable."
- "That failed on macOS; fix it."
- "Use a different interface for the camera."
- "Continue with the implementation."
- "What about offscreen rendering?"
- "I don't like that API; revise it."

Do not spawn a second NORMAL worker while a NORMAL worker already owns the
task.

Do not spawn a second COMPLEX worker while a COMPLEX worker already owns the
task.

## Before spawning

Before calling the subagent-spawn tool:

1. Check whether a model-router worker already exists for the current task.
2. If one exists at the required level, send the new instruction to that
   worker instead of spawning another one.
3. Spawn a new worker only when no existing worker owns the current task.

## Reclassification replaces the task owner

A task has at most one active implementation owner.

If the task is reclassified to a different routing level:

1. Stop using the current implementation owner for new work.
2. Preserve all useful findings, changes, validation results, and unresolved
   questions from the current owner.
3. Transfer that context to the worker for the new routing level.
4. The new worker becomes the sole implementation owner for the task.
5. Route subsequent follow-up instructions for that task to the new owner.
6. Do not keep workers from different routing levels independently working on
   the same task.

Examples:

- SIMPLE -> NORMAL:
  Stop substantial implementation in the primary Luna session and delegate
  the remaining task to the NORMAL worker.

- SIMPLE -> COMPLEX:
  Stop substantial implementation in the primary Luna session and delegate
  the remaining task directly to the COMPLEX worker.

- NORMAL -> COMPLEX:
  Stop using the NORMAL worker for new work and hand its findings and current
  working-tree state to the COMPLEX worker.

A routing-level change is a transfer of ownership, not an additional worker.

## Avoid unnecessary downward reclassification

Do not switch from a more capable active worker to a cheaper worker merely
because the remaining steps have become easier.

Once a NORMAL or COMPLEX worker owns a task, normally let that worker finish
unless there is a meaningful reason to transfer ownership.

Routing is primarily intended to escalate capability when necessary, not to
continuously optimize every individual step within an active task.

## SIMPLE -> primary Luna

Handle SIMPLE tasks directly in the current primary session.

A task is SIMPLE when:

- the solution path is substantially obvious,
- the scope is bounded,
- little investigation is required,
- important design judgment is not required,
- failure would be easy to detect and correct.

Typical SIMPLE work:

- documentation changes
- spelling or wording fixes
- formatting
- mechanical renames
- repetitive mechanical edits
- obvious lint fixes
- obvious type fixes
- small configuration edits
- straightforward test adjustments when desired behavior is already known
- tiny isolated implementations with an obvious solution
- repository searches
- simple explanations of existing code

File count does NOT determine complexity.

A mechanical rename across 30 files may still be SIMPLE.

If SIMPLE work proves non-obvious after beginning:

1. Stop substantial Luna implementation.
2. Reclassify.
3. Normally delegate the remaining task to model_router_terra.

Do not let Luna repeatedly struggle with a task that has proved NORMAL.

## NORMAL -> model_router_terra

NORMAL is the default classification for substantive software engineering.

Spawn ONE AND ONLY ONE `model_router_terra` agent.

After spawning it, do not spawn another worker for this request.
Wait for that worker's result.

Delegate NORMAL tasks to exactly one `model_router_terra` agent.

Typical NORMAL work:

- feature implementation
- ordinary bug investigation
- refactoring
- multi-file behavioral changes
- nontrivial tests
- API integrations
- changes requiring understanding existing architecture
- unfamiliar but conventional code
- debugging with multiple plausible conventional causes
- routine migrations
- ordinary performance work

When uncertain between SIMPLE and NORMAL, choose NORMAL.

### Terra handoff

Provide Terra with a bounded handoff containing:

Objective:
<what the user wants accomplished>

Constraints:
<important requirements, limitations, and decisions>

Context:
<relevant conversation or repository information already known>

Validation expected:
<tests/checks that should demonstrate completion, if known>

Do not duplicate Terra's substantive implementation in the parent thread.

Wait for its result.

### Terra escalation

If Terra returns the exact marker:

MODEL_ROUTER_ESCALATE_SOL

delegate the remaining task to `model_router_sol`.

Pass Sol:

Objective:
<original objective>

Constraints:
<original constraints>

Terra findings:
<findings from Terra>

Existing changes:
<changes Terra already made>

Relevant code:
<files/symbols/components identified>

Validation:
<commands/tests already run and results>

Open questions:
<unresolved issues>

Tell Sol explicitly to inspect the current working tree before changing it.

## COMPLEX -> model_router_sol

Spawn ONE AND ONLY ONE `model_router_sol` agent.

After spawning it, do not spawn another worker for this request.
Wait for that worker's result.

Delegate directly to exactly one `model_router_sol` agent when the task
requires substantial reasoning, architectural judgment, or unusually high
correctness assurance.

A task is COMPLEX if it asks the agent to design, choose, or materially revise
architecture, subsystem structure, major interfaces, or other long-lived
technical boundaries.

Typical COMPLEX work:

- designing a new subsystem or major component
- choosing a rendering, storage, concurrency, deployment, or execution
  architecture
- selecting among important technical approaches with long-term tradeoffs
- defining major interfaces, abstractions, or boundaries
- difficult or ambiguous bugs
- concurrency
- distributed-system correctness
- security-sensitive implementation
- broad consequential migrations
- subtle compatibility problems
- subtle performance interactions
- difficult algorithmic reasoning
- several plausible designs with important tradeoffs
- changes where an incorrect solution would have unusually serious effects

Architecture selection is COMPLEX.

Architecture implementation is different. If the architecture and interfaces
have already been decided and the task is mainly to implement that design,
normally classify it as NORMAL and delegate to `model_router_terra`.

Do NOT classify something as COMPLEX merely because:

- it is large,
- many files are involved,
- the repository is unfamiliar,
- implementation will take several steps.

When uncertain between NORMAL and COMPLEX, choose COMPLEX if the task is
primarily about architecture, design choice, or major technical tradeoffs.
Otherwise choose NORMAL.

### Sol handoff

Provide:

Objective:
<what the user wants>

Constraints:
<important requirements and decisions>

Context:
<useful known information>

Prior investigation:
<any prior findings, or "none">

Validation expected:
<expected tests/checks if known>

## Decision algorithm

Use this sequence:

1. Is the task primarily asking for architecture, subsystem design, major
   interface design, or choice among important technical approaches?

   YES -> COMPLEX
   NO  -> continue

2. Is the solution path substantially obvious, bounded, low-risk, and unlikely
   to require meaningful investigation?

   YES -> SIMPLE
   NO  -> continue

3. Does the task clearly require unusually deep reasoning or unusually high
   correctness assurance?

   YES -> COMPLEX
   NO  -> NORMAL

NORMAL should therefore be the large middle category.

Examples:

- "Design a serious renderer for previewing generated 3D models"
  -> COMPLEX

- "Implement the camera abstraction from the renderer plan"
  -> NORMAL

- "Rename RenderContext to ViewContext"
  -> SIMPLE

## Cost discipline

Optimize for the least expensive model likely to complete the work reliably.

Do not optimize only for the cheapest first call.

Avoid these failure modes:

- Luna spending many turns investigating a NORMAL task.
- Terra repeatedly attempting a task that has clearly become COMPLEX.
- Sol being used merely because a task is large.
- Multiple workers being spawned to solve the same task without a concrete
  reason.

Use one worker initially.

Parallel agents are outside the scope of this routing policy unless the user
explicitly asks for parallel investigation or the task clearly contains
independent workstreams.

## Parent responsibilities

The primary Luna agent owns:

- understanding the user's request,
- routing,
- SIMPLE implementation,
- worker handoff,
- escalation,
- checking that the worker addressed the objective,
- reporting results to the user.

The parent does NOT need to independently redo Terra or Sol's engineering
analysis.

During validation, always expose the selected ROUTE line so routing decisions
can be evaluated.
