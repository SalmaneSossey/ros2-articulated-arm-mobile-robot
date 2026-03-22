#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/.." && pwd)"

source "${script_dir}/source_ros.sh"

if ! command -v colcon >/dev/null 2>&1; then
  echo "[build_workspace] colcon is not installed."
  exit 1
fi

if [[ ! -x /usr/bin/python3 ]]; then
  echo "[build_workspace] /usr/bin/python3 is required for a ROS-friendly build."
  exit 1
fi

# Prefer Ubuntu's system Python for ROS package metadata parsing.
export PATH="/usr/bin:/bin:${PATH}"

cd "${repo_root}/ros2_ws"
echo "[build_workspace] Building package my_robot_description"
echo "[build_workspace] Using Python executable: /usr/bin/python3"
colcon build \
  --packages-select my_robot_description \
  --cmake-args -DPython3_EXECUTABLE=/usr/bin/python3
