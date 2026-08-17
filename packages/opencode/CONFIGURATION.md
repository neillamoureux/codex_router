# OpenCode Configuration Entry Guidance

This package intentionally does not include an `opencode.json`, plugin
manifest, or guessed schema. OpenCode configuration and plugin entry formats
vary by release and deployment.

When the installed host documents agent registration, add the two files in
`.opencode/agents/` to that documented agent search path and map them to the
generic roles:

```text
primary  -> default OpenCode session
standard -> .opencode/agents/standard.md
advanced -> .opencode/agents/advanced.md
```

When the host documents a plugin or config entry point, use that host-provided
schema and point it at this package's `.opencode/agents/` directory. If no such
entry point is available, use the manual installation path in [INSTALL.md](INSTALL.md).
Automatic routing, persistence, transfer, and cleanup must be verified rather
than inferred from filenames.
