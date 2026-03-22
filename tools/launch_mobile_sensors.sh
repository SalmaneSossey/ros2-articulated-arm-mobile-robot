#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/.." && pwd)"

source "${script_dir}/source_ros.sh"

if [[ ! -f "${repo_root}/ros2_ws/install/setup.bash" ]]; then
  echo "[launch_mobile_sensors] Workspace is not built yet. Run ./tools/build_workspace.sh first."
  exit 1
fi

ros2 launch my_robot_description display_mobile_sensors.launch.py

