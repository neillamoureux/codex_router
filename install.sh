#!/usr/bin/env bash
set -u

usage() {
  cat <<'EOF'
Usage: ./install.sh [options]

Install native model-router files from this repository's packages/ directory.

Options:
  --scope project|global   Destination scope (default: project)
  --harness NAME            codex|claude|copilot|opencode|all (default: all)
  --dry-run                 Show actions without changing files
  -h, --help                Show this help

Project scope installs into the current working directory. Global scope
installs into the current user's documented harness configuration directories.
Existing identical files are skipped. Different existing files are reported as
conflicts and are never overwritten.
EOF
}

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P) || exit 1
SCOPE=project
HARNESS=all
DRY_RUN=0
CREATED=0
SKIPPED=0
CONFLICTS=0

die() {
  printf 'error: %s\n' "$1" >&2
  exit 2
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --scope)
      [[ $# -ge 2 ]] || die "--scope requires project or global"
      SCOPE=$2
      shift 2
      ;;
    --harness)
      [[ $# -ge 2 ]] || die "--harness requires a harness name"
      HARNESS=$2
      shift 2
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      die "unknown argument: $1"
      ;;
  esac
done

case "$SCOPE" in
  project|global) ;;
  *) die "invalid scope '$SCOPE'; use project or global" ;;
esac

case "$HARNESS" in
  codex|claude|copilot|opencode|all) ;;
  *) die "invalid harness '$HARNESS'; use codex, claude, copilot, opencode, or all" ;;
esac

if [[ "$SCOPE" == project ]]; then
  DEST_ROOT=$(pwd -P) || exit 1
else
  DEST_ROOT=$HOME
  CODEX_USER_HOME=${CODEX_HOME:-$HOME/.codex}
fi

declare -a TARGETS=()

add_target() {
  TARGETS+=("$1|$2")
}

add_codex_targets() {
  if [[ "$SCOPE" == project ]]; then
    add_target "packages/codex/.agents/skills/model-router/SKILL.md" "$DEST_ROOT/.agents/skills/model-router/SKILL.md"
    add_target "packages/codex/.codex/agents/standard.toml" "$DEST_ROOT/.codex/agents/router_standard.toml"
    add_target "packages/codex/.codex/agents/advanced.toml" "$DEST_ROOT/.codex/agents/router_advanced.toml"
  else
    add_target "packages/global-routing.md" "$HOME/.agents/skills/model-router/SKILL.md"
    add_target "packages/global-routing.md" "$CODEX_USER_HOME/skills/model-router/SKILL.md"
    add_target "packages/codex/.codex/agents/standard.toml" "$CODEX_USER_HOME/agents/router_standard.toml"
    add_target "packages/codex/.codex/agents/advanced.toml" "$CODEX_USER_HOME/agents/router_advanced.toml"
  fi
}

add_claude_targets() {
  if [[ "$SCOPE" == project ]]; then
    add_target "packages/global-routing.md" "$DEST_ROOT/.claude/skills/model-router/SKILL.md"
    add_target "packages/claude/.claude/agents/standard.md" "$DEST_ROOT/.claude/agents/standard.md"
    add_target "packages/claude/.claude/agents/advanced.md" "$DEST_ROOT/.claude/agents/advanced.md"
  else
    add_target "packages/global-routing.md" "$HOME/.claude/skills/model-router/SKILL.md"
    add_target "packages/claude/agents/standard.md" "$HOME/.claude/agents/standard.md"
    add_target "packages/claude/agents/advanced.md" "$HOME/.claude/agents/advanced.md"
  fi
}

add_copilot_targets() {
  if [[ "$SCOPE" == project ]]; then
    add_target "packages/global-routing.md" "$DEST_ROOT/.github/skills/model-router/SKILL.md"
    add_target "packages/copilot/.github/agents/standard.agent.md" "$DEST_ROOT/.github/agents/standard.agent.md"
    add_target "packages/copilot/.github/agents/advanced.agent.md" "$DEST_ROOT/.github/agents/advanced.agent.md"
  else
    add_target "packages/global-routing.md" "$HOME/.copilot/skills/model-router/SKILL.md"
    add_target "packages/copilot/.github/agents/standard.agent.md" "$HOME/.copilot/agents/standard.agent.md"
    add_target "packages/copilot/.github/agents/advanced.agent.md" "$HOME/.copilot/agents/advanced.agent.md"
  fi
}

add_opencode_targets() {
  if [[ "$SCOPE" == project ]]; then
    add_target "packages/global-routing.md" "$DEST_ROOT/.opencode/skills/model-router/SKILL.md"
    add_target "packages/opencode/.opencode/agents/standard.md" "$DEST_ROOT/.opencode/agents/standard.md"
    add_target "packages/opencode/.opencode/agents/advanced.md" "$DEST_ROOT/.opencode/agents/advanced.md"
  else
    add_target "packages/global-routing.md" "$HOME/.config/opencode/skills/model-router/SKILL.md"
    add_target "packages/opencode/.opencode/agents/standard.md" "$HOME/.config/opencode/agents/standard.md"
    add_target "packages/opencode/.opencode/agents/advanced.md" "$HOME/.config/opencode/agents/advanced.md"
  fi
}

case "$HARNESS" in
  codex) add_codex_targets ;;
  claude) add_claude_targets ;;
  copilot) add_copilot_targets ;;
  opencode) add_opencode_targets ;;
  all)
    add_codex_targets
    add_claude_targets
    add_copilot_targets
    add_opencode_targets
    ;;
esac

printf 'Model Router installer\n'
printf '  source:   %s\n' "$SCRIPT_DIR"
printf '  scope:    %s\n' "$SCOPE"
printf '  harness:  %s\n' "$HARNESS"
[[ "$DRY_RUN" -eq 1 ]] && printf '  mode:     dry-run\n'

for target in "${TARGETS[@]}"; do
  source_rel=${target%%|*}
  destination=${target#*|}
  source_path=$SCRIPT_DIR/$source_rel

  [[ -f "$source_path" ]] || die "package source is missing: $source_rel"

  if [[ -e "$destination" && ! -f "$destination" ]]; then
    printf 'CONFLICT  %s (destination is not a regular file)\n' "$destination"
    CONFLICTS=$((CONFLICTS + 1))
  elif [[ -f "$destination" ]]; then
    if cmp -s "$source_path" "$destination"; then
      printf 'SKIP      %s (already current)\n' "$destination"
      SKIPPED=$((SKIPPED + 1))
    else
      printf 'CONFLICT  %s (different file exists; not overwritten)\n' "$destination"
      CONFLICTS=$((CONFLICTS + 1))
    fi
  else
    printf '%s  %s\n' "$([[ "$DRY_RUN" -eq 1 ]] && printf WOULD-CREATE || printf CREATE)" "$destination"
    CREATED=$((CREATED + 1))
    if [[ "$DRY_RUN" -eq 0 ]]; then
      mkdir -p "$(dirname "$destination")" || exit 1
      cp "$source_path" "$destination" || exit 1
    fi
  fi
done

printf '\nSummary: create=%d skip=%d conflict=%d\n' "$CREATED" "$SKIPPED" "$CONFLICTS"

if [[ "$CONFLICTS" -gt 0 ]]; then
  printf 'No conflicting files were overwritten. Resolve conflicts and rerun.\n' >&2
  exit 1
fi

if [[ "$DRY_RUN" -eq 1 ]]; then
  printf 'Dry run complete; no files were changed.\n'
else
  printf 'Installation complete. Restart the harness, invoke the standard and advanced roles explicitly, and verify discovery.\n'
fi
