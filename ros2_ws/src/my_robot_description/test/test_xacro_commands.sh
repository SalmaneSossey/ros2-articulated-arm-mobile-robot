#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
package_root="$(cd "${script_dir}/.." && pwd)"
repo_root="$(cd "${package_root}/../../.." && pwd)"

source "${repo_root}/tools/source_ros.sh"

if ! command -v xacro >/dev/null 2>&1; then
  echo "[test_xacro_commands] xacro is not installed. See INSTALL_WSL_UBUNTU.md"
  exit 1
fi

xacro_files=(
  "${package_root}/urdf/robot_2r.urdf.xacro"
  "${package_root}/urdf/robot_3r.urdf.xacro"
  "${package_root}/urdf/mobile_robot.urdf.xacro"
  "${package_root}/urdf/mobile_robot_with_sensors.urdf.xacro"
  "${package_root}/urdf/combined_robot.urdf.xacro"
)

mkdir -p "${repo_root}/generated"

for file in "${xacro_files[@]}"; do
  output="${repo_root}/generated/$(basename "${file%.xacro}")"
  echo "[test_xacro_commands] Generating ${output}"
  xacro "${file}" > "${output}"
  if command -v check_urdf >/dev/null 2>&1; then
    check_urdf "${output}" >/dev/null
  fi
done

echo "[test_xacro_commands] All Xacro files expanded successfully."
