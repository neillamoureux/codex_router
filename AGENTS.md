  ## Codex routing

  Use the repository model-router skill for substantive software-development
  tasks.

  Routing policy:

  - SIMPLE tasks stay in Luna.
  - NORMAL tasks use one model_router_terra worker.
  - COMPLEX tasks use one model_router_sol worker.
  - At most one Terra and one Sol worker may be active simultaneously.
  - Reuse an existing worker with send_input rather than spawning another worker
    of the same role.
  - Close completed workers with close_agent.
