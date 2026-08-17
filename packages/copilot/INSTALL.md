# Install the Native GitHub Copilot CLI Package

Copy `standard.agent.md` and `advanced.agent.md` into the target repository's
`.github/agents/` directory. Do not overwrite existing custom agents.

The main Copilot CLI session is `primary`. Explicitly invoke a custom agent
when automatic selection is unavailable. If your installation supports a
repository instruction file or skill/plugin mechanism, merge the shared policy
there; this package does not invent an additional manifest. Use the shared
handoff protocol for continuation and disclose when the host cannot persist or
transfer agent context.
