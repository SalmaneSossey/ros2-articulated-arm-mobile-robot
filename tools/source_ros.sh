#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/.." && pwd)"

return_or_exit() {
  local code="${1:-0}"
  return "${code}" 2>/dev/null || exit "${code}"
}

pick_ros_setup() {
  if [[ -n "${ROS_DISTRO:-}" && -f "/opt/ros/${ROS_DISTRO}/setup.bash" ]]; then
    printf '%s\n' "/opt/ros/${ROS_DISTRO}/setup.bash"
    return 0
  fi

  if [[ -f "/opt/ros/humble/setup.bash" ]]; then
    printf '%s\n' "/opt/ros/humble/setup.bash"
    return 0
  fi

  local first_setup
  first_setup="$(find /opt/ros -mindepth 2 -maxdepth 2 -path '*/setup.bash' 2>/dev/null | sort | head -n 1 || true)"
  if [[ -n "${first_setup}" ]]; then
    printf '%s\n' "${first_setup}"
    return 0
  fi

  return 1
}

main() {
  local ros_setup
  local had_nounset=0
  ros_setup="$(pick_ros_setup || true)"

  if [[ -z "${ros_setup}" ]]; then
    echo "[source_ros] No ROS setup script found under /opt/ros."
    return_or_exit 1
  fi

  case $- in
    *u*)
      had_nounset=1
      set +u
      ;;
  esac

  # shellcheck disable=SC1090
  source "${ros_setup}"
  if [[ "${had_nounset}" -eq 1 ]]; then
    set -u
  fi
  echo "[source_ros] Sourced ${ros_setup}"

  if [[ -f "${repo_root}/ros2_ws/install/setup.bash" ]]; then
    case $- in
      *u*)
        had_nounset=1
        set +u
        ;;
      *)
        had_nounset=0
        ;;
    esac
    # shellcheck disable=SC1091
    source "${repo_root}/ros2_ws/install/setup.bash"
    if [[ "${had_nounset}" -eq 1 ]]; then
      set -u
    fi
    echo "[source_ros] Sourced workspace install/setup.bash"
  else
    echo "[source_ros] Workspace install/setup.bash not found yet"
  fi
}

main "$@"
