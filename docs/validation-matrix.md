# Provider Validation Matrix

Validation is behavioral. Provider packages may use different commands or
interfaces, but each supported host should verify the same scenarios.

| Scenario | Required evidence |
|---|---|
| SIMPLE | Work remains in the primary lane; no delegation is claimed |
| NORMAL | Exactly one standard owner, or an explicit documented fallback |
| Follow-up | Same task owner/session is reused when supported |
| COMPLEX | Exactly one advanced owner, or an explicit documented fallback |
| Transfer | Prior findings and working-tree state reach the new owner |
| Concurrency | Only if the host advertises and permits it; otherwise serial execution |
| Completion | Lifecycle cleanup is verified, or cleanup is marked unsupported |
| Cost | Selected lane and provider model/profile are visible in the trace |

## Suggested trace

```text
CLASSIFIED: NORMAL -> standard
STARTED: <provider> <owner-id or session>
CONTINUED: <same owner-id or documented fallback>
COMPLETED: <validation summary>
```

For a transfer:

```text
TRANSFERRED: standard -> advanced
OWNER_RETIRED: <provider-specific result>
STARTED: <new owner>
```

Do not require provider-independent worker IDs, commands, or lifecycle events.
Those belong in the provider package.
