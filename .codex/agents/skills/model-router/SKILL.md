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
