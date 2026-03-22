#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/.." && pwd)"

source "${script_dir}/source_ros.sh" >/dev/null 2>&1 || true

check_cmd() {
  local name="$1"
  if command -v "${name}" >/dev/null 2>&1; then
    echo "[PASS] ${name}: $(command -v "${name}")"
  else
    echo "[FAIL] ${name}: not found"
  fi
}

check_ros_executable() {
  local package_name="$1"
  local executable_name="$2"
  if command -v ros2 >/dev/null 2>&1 && ros2 pkg executables "${package_name}" 2>/dev/null | rg -q "^${package_name} ${executable_name}$"; then
    echo "[PASS] ${executable_name}: available via ros2 package ${package_name}"
  else
    echo "[FAIL] ${executable_name}: not available via ros2 package ${package_name}"
  fi
}

echo "[INFO] Repo root: ${repo_root}"
echo "[INFO] ROS_DISTRO: ${ROS_DISTRO:-<unset>}"

check_cmd ros2
check_cmd colcon
check_cmd rviz2
check_cmd xacro
check_cmd check_urdf
check_ros_executable robot_state_publisher robot_state_publisher
check_ros_executable joint_state_publisher_gui joint_state_publisher_gui
