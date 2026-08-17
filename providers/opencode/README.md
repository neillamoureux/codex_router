# OpenCode Package

This package provides OpenCode-oriented project instructions without requiring
an OpenCode server, plugin, model registry, or provider credential.

## Capability profile

Use the configured OpenCode session as primary. If the installation supports
named agents or sub-sessions, map them to standard and advanced. Otherwise use
the primary-session fallback. Treat persistence, messaging, cleanup, and
parallelism as unknown until verified for the local OpenCode configuration.
