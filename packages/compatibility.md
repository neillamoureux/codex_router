# Compatibility and Migration

`packages/` is now the sole harness-integration root. The former `providers/`
guides have been consolidated into the native package READMEs and INSTALL
files; no separate provider package is required.

Existing installations are not changed automatically. If a project already
has files copied from the former `providers/` tree, leave them in place and
continue using them, or replace them deliberately with the corresponding
package under `packages/`. Shared policy remains in `docs/`.

All installation paths are manual unless the host's documented plugin flow is
used. Native artifact presence does not imply automatic routing or worker
lifecycle support.
