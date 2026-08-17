#!/bin/bash
# Installs the native model-router files from packages/ into project or user scope.

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
readonly DEFAULT_SCOPE="project"
readonly DEFAULT_HARNESS="all"

SOURCE_FILES=()
DESTINATION_FILES=()

print_usage() {
  cat <<'EOF'
Usage: ./install.sh [options]

Options:
  --scope project|global   Destination scope (default: project)
  --harness NAME            codex|claude|copilot|opencode|all (default: all)
  --dry-run                 Show actions without changing files
  -h, --help                Show this help

Identical files are skipped. Different existing files are reported as
conflicts and are never overwritten.
EOF
}

fail() {
  printf 'error: %s\n' "$1" >&2
  exit 2
}

add_target() {
  SOURCE_FILES+=("$1")
  DESTINATION_FILES+=("$2")
}

# Adds project-native skill and role files for one harness.
add_project_targets() {
  local harness="$1"
  local project_root="$2"
  local skill_source="packages/global-routing.md"
  local config_dir

  if [[ "${harness}" == codex ]]; then
    skill_source="packages/codex/.agents/skills/model-router/SKILL.md"
  fi
  case "${harness}" in
    codex) config_dir=.agents ;;
    claude) config_dir=.claude ;;
    copilot) config_dir=.github ;;
    opencode) config_dir=.opencode ;;
  esac
  add_target "${skill_source}" "${project_root}/${config_dir}/skills/model-router/SKILL.md"

  case "${harness}" in
    codex)
      add_target \
        packages/codex/.codex/agents/standard.toml \
        "${project_root}/.codex/agents/router_standard.toml"
      add_target \
        packages/codex/.codex/agents/advanced.toml \
        "${project_root}/.codex/agents/router_advanced.toml"
      ;;
    claude)
      add_target \
        packages/claude/.claude/agents/standard.md \
        "${project_root}/.claude/agents/standard.md"
      add_target \
        packages/claude/.claude/agents/advanced.md \
        "${project_root}/.claude/agents/advanced.md"
      ;;
    copilot)
      add_target \
        packages/copilot/.github/agents/standard.agent.md \
        "${project_root}/.github/agents/standard.agent.md"
      add_target \
        packages/copilot/.github/agents/advanced.agent.md \
        "${project_root}/.github/agents/advanced.agent.md"
      ;;
    opencode)
      add_target \
        packages/opencode/.opencode/agents/standard.md \
        "${project_root}/.opencode/agents/standard.md"
      add_target \
        packages/opencode/.opencode/agents/advanced.md \
        "${project_root}/.opencode/agents/advanced.md"
      ;;
  esac
}

# Adds user-level skill and role files for one harness.
add_global_targets() {
  local harness="$1"
  local home_dir="$2"
  local codex_home="${CODEX_HOME:-${home_dir}/.codex}"
  local skill_dir

  case "${harness}" in
    codex)
      add_target packages/global-routing.md "${home_dir}/.agents/skills/model-router/SKILL.md"
      add_target packages/global-routing.md "${codex_home}/skills/model-router/SKILL.md"
      add_target \
        packages/codex/.codex/agents/standard.toml \
        "${codex_home}/agents/router_standard.toml"
      add_target \
        packages/codex/.codex/agents/advanced.toml \
        "${codex_home}/agents/router_advanced.toml"
      ;;
    claude)
      skill_dir="${home_dir}/.claude"
      add_target packages/global-routing.md "${skill_dir}/skills/model-router/SKILL.md"
      add_target packages/claude/agents/standard.md \
        "${skill_dir}/agents/standard.md"
      add_target packages/claude/agents/advanced.md \
        "${skill_dir}/agents/advanced.md"
      ;;
    copilot)
      skill_dir="${home_dir}/.copilot"
      add_target packages/global-routing.md "${skill_dir}/skills/model-router/SKILL.md"
      add_target packages/copilot/.github/agents/standard.agent.md \
        "${skill_dir}/agents/standard.agent.md"
      add_target packages/copilot/.github/agents/advanced.agent.md \
        "${skill_dir}/agents/advanced.agent.md"
      ;;
    opencode)
      skill_dir="${home_dir}/.config/opencode"
      add_target packages/global-routing.md "${skill_dir}/skills/model-router/SKILL.md"
      add_target packages/opencode/.opencode/agents/standard.md \
        "${skill_dir}/agents/standard.md"
      add_target packages/opencode/.opencode/agents/advanced.md \
        "${skill_dir}/agents/advanced.md"
      ;;
  esac
}

add_harness_targets() {
  local scope="$1"
  local harness="$2"
  local root="$3"

  if [[ "${scope}" == project ]]; then
    add_project_targets "${harness}" "${root}"
  else
    add_global_targets "${harness}" "${root}"
  fi
}

# Installs one file, returning 0 for unchanged, 10 for created, and 1 for conflict.
install_file() {
  local source_path="$1"
  local destination="$2"
  local dry_run="$3"
  local action

  [[ -f "${source_path}" ]] || fail "package source is missing: ${source_path}"
  if [[ -e "${destination}" && ! -f "${destination}" ]]; then
    printf 'CONFLICT  %s (destination is not a regular file)\n' "${destination}"
    return 1
  elif [[ -f "${destination}" ]]; then
    if cmp -s "${source_path}" "${destination}"; then
      printf 'SKIP      %s (already current)\n' "${destination}"
      return 0
    fi
    printf 'CONFLICT  %s (different file exists; not overwritten)\n' "${destination}"
    return 1
  fi

  action=CREATE
  [[ "${dry_run}" == 1 ]] && action=WOULD-CREATE
  printf '%-10s%s\n' "${action}" "${destination}"
  if [[ "${dry_run}" == 0 ]]; then
    mkdir -p "$(dirname "${destination}")"
    cp "${source_path}" "${destination}"
  fi
  return 10
}

# Parses arguments, builds the destination plan, installs files, and summarizes it.
main() {
  local scope="${DEFAULT_SCOPE}"
  local harness="${DEFAULT_HARNESS}"
  local dry_run=0
  local project_root
  local source_path
  local index
  local selected_harness
  local result
  local conflicts=0
  local creates=0
  local skips=0

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --scope)
        [[ $# -ge 2 ]] || fail "--scope requires project or global"
        scope="$2"
        shift 2
        ;;
      --harness)
        [[ $# -ge 2 ]] || fail "--harness requires a harness name"
        harness="$2"
        shift 2
        ;;
      --dry-run)
        dry_run=1
        shift
        ;;
      -h|--help)
        print_usage
        return 0
        ;;
      *)
        fail "unknown argument: $1"
        ;;
    esac
  done

  case "${scope}" in
    project|global) ;;
    *) fail "invalid scope '${scope}'; use project or global" ;;
  esac
  case "${harness}" in
    codex|claude|copilot|opencode|all) ;;
    *) fail "invalid harness '${harness}'; use codex, claude, copilot, opencode, or all" ;;
  esac

  project_root="$(pwd -P)"
  for selected_harness in codex claude copilot opencode; do
    if [[ "${harness}" == all || "${harness}" == "${selected_harness}" ]]; then
      if [[ "${scope}" == project ]]; then
        add_harness_targets "${scope}" "${selected_harness}" "${project_root}"
      else
        add_harness_targets "${scope}" "${selected_harness}" "${HOME}"
      fi
    fi
  done

  printf 'Model Router installer\n'
  printf '  source:  %s\n  scope:   %s\n  harness: %s\n' \
    "${SCRIPT_DIR}" "${scope}" "${harness}"
  [[ "${dry_run}" == 1 ]] && printf '  mode:    dry-run\n'

  for index in "${!SOURCE_FILES[@]}"; do
    source_path="${SCRIPT_DIR}/${SOURCE_FILES[$index]}"
    if install_file "${source_path}" "${DESTINATION_FILES[$index]}" "${dry_run}"; then
      result=0
    else
      result=$?
    fi
    case "${result}" in
      0) skips=$((skips + 1)) ;;
      10) creates=$((creates + 1)) ;;
      *) conflicts=$((conflicts + 1)) ;;
    esac
  done

  printf '\nSummary: create=%d skip=%d conflict=%d\n' \
    "${creates}" "${skips}" "${conflicts}"
  if [[ "${conflicts}" -gt 0 ]]; then
    printf 'No conflicting files were overwritten. Resolve conflicts and rerun.\n' >&2
    return 1
  fi
  if [[ "${dry_run}" == 1 ]]; then
    printf 'Dry run complete; no files were changed.\n'
  else
    printf 'Installation complete. Restart the harness and verify role discovery.\n'
  fi
}

main "$@"
