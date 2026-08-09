# codex_router
Simple model router for use with codex

## Using with Codex

The router can be added to an existing Codex project without replacing your project's `AGENTS.md` or other Codex customizations.

The repository contains:

```text
.codex/
├── config.toml
├── agents/
│   ├── model_router_terra.toml
│   ├── model_router_sol.toml
│   └── skills/
│       └── model-router/
│           └── SKILL.md
```

### Installation

From the root of the project where you want to use model routing, create the required directories:

```bash
mkdir -p .codex/agents
mkdir -p .codex/agents/skills/model-router
```

Copy the router's agent definitions and skill into your project:

```bash
cp /path/to/model-router/.codex/agents/model_router_terra.toml \
   .codex/agents/

cp /path/to/model-router/.codex/agents/model_router_sol.toml \
   .codex/agents/

cp /path/to/model-router/.codex/agents/skills/model-router/SKILL.md \
   .codex/agents/skills/model-router/
```

Do not overwrite an existing `.codex/config.toml`.

Instead, merge the model-router settings into your existing configuration.

The router expects the primary interactive Codex session to use Luna with low reasoning:

```toml
model = "gpt-5.6-luna"
model_reasoning_effort = "low"
```

and requires multi-agent support:

```toml
[agents]
enabled = true
max_concurrent_threads_per_session = 1
```

If you do not already have `.codex/config.toml`, you can copy the supplied example:

```bash
cp /path/to/model-router/.codex/config.toml .codex/config.toml
```

### Existing Codex configuration

Model Router is intended to augment an existing Codex project.

It does not require replacing:

```text
AGENTS.md
.codex/agents/ other custom agents
other skills
unrelated .codex/config.toml settings
```

If your project already contains any of these, keep them and add the Model Router files alongside them.

The supplied agents use namespaced names:

```text
model_router_terra
model_router_sol
```

to reduce the likelihood of conflicts with existing custom agents.

### How routing works

Start Codex normally:

```bash
codex
```

The primary interactive session runs on Luna with low reasoning effort.

For each software-engineering task, the Model Router classifies the work into one of three levels:

```text
SIMPLE   → primary Luna session
NORMAL   → model_router_terra
COMPLEX  → model_router_sol
```

Typical examples:

```text
Fix a typo in README.md
    → SIMPLE / Luna

Implement an already-designed scene graph
    → NORMAL / Terra

Design the architecture for a new 3D renderer
    → COMPLEX / Sol
```

The classification is based on reasoning complexity and engineering risk, not simply on the size of the change or the number of files involved.

### During routing validation

The current router intentionally displays its routing decision:

```text
ROUTE: SIMPLE -> LUNA

ROUTE: NORMAL -> TERRA

ROUTE: COMPLEX -> SOL
```

This makes it easy to verify that prompts are being classified as expected.

For NORMAL and COMPLEX tasks, confirm that Codex actually creates the corresponding subagent rather than merely announcing the route.

After a worker has been created, `/agent` can be used to inspect its thread.

### Task continuity

Routing applies to an engineering task, not to each individual chat message.

For example:

```text
Implement the scene graph.
Now add hierarchical transforms.
Add tests for reparenting nodes.
```

should normally remain one task with one implementation worker.

A follow-up request should be sent to the existing worker rather than spawning another worker at the same level.

If a task proves more difficult than originally classified, ownership may move to a more capable routing level. The previous worker's findings and current working-tree state should be handed to the new worker rather than starting the investigation from scratch.

### Explicitly invoking the router

While testing or diagnosing routing behavior, you can explicitly invoke the skill:

```text
$model-router Design a renderer for previewing programmatically generated 3D models.
```

This is useful for separating routing-policy problems from automatic skill-activation problems.

### Verifying the primary model

Inside Codex, run:

```text
/status
```

The primary session should report:

```text
gpt-5.6-luna
reasoning low
```

The Terra and Sol model selections are defined independently in:

```text
.codex/agents/model_router_terra.toml
.codex/agents/model_router_sol.toml
```

### Removing Model Router

Remove only the Model Router files:

```bash
rm .codex/agents/model_router_terra.toml
rm .codex/agents/model_router_sol.toml
rm -rf .codex/agents/skills/model-router
```

If you changed `.codex/config.toml` specifically for Model Router, restore your preferred primary model and agent settings manually.

Do not delete `.codex/config.toml` if it contains other project configuration.
