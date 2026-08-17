# No-Runtime Scope

The repository intentionally ships policy, instructions, native-format
templates, examples, and provider installation guidance only. It does not ship
a daemon, CLI, Python or Node package, provider API client, model-price
database, or automatic prompt classifier.

The host remains responsible for executing the policy. A provider package may
contain configuration snippets and native instruction/agent files, but must not
imply that those files work as a cross-provider executable integration. Native
files define roles and prompts; automatic classification and lifecycle
guarantees remain host capabilities.

This keeps credentials, account-specific model availability, pricing, provider
terms, and session lifecycle behavior outside the repository. Add runtime code
only as a separately approved product decision with explicit provider
compatibility and security requirements.
