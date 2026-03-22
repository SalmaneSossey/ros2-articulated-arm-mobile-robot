#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/.." && pwd)"
package_root="${repo_root}/ros2_ws/src/my_robot_description"

source "${script_dir}/source_ros.sh"

echo "[validate_workspace] Running environment checks"
"${script_dir}/env_check.sh"

echo "[validate_workspace] Validating plain URDF files"
check_urdf "${package_root}/urdf/robot.urdf"
check_urdf "${package_root}/urdf/robot_2r.urdf"

echo "[validate_workspace] Building workspace"
"${script_dir}/build_workspace.sh"

echo "[validate_workspace] Validating Xacro expansions"
bash "${package_root}/test/test_xacro_commands.sh"

echo "[validate_workspace] Validation completed successfully."

