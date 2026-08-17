# Copilot CLI Plugin/Skill Metadata

No additional plugin manifest is included. The stable native custom-agent
entry point used here is `.github/agents/*.agent.md`.

If the installed Copilot CLI documents a plugin or skill manifest, add the
repository's shared policy through that documented mechanism and point it at
`docs/provider-neutral-policy.md`. Do not copy a manifest from another host or
invent fields. Otherwise, use [INSTALL.md](INSTALL.md) and explicitly select
the `standard` or `advanced` custom agent.
