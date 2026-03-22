#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/.." && pwd)"
urdf_dir="${repo_root}/ros2_ws/src/my_robot_description/urdf"
output_dir="${repo_root}/generated"

source "${script_dir}/source_ros.sh"

mkdir -p "${output_dir}"

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <robot-name|path-to-urdf-or-xacro>"
  echo "Known names: basic, 2r, 2r_plain, 3r, mobile, mobile_sensors, combined"
  exit 1
fi

input="$1"
resolved=""

case "${input}" in
  basic)
    resolved="${urdf_dir}/robot.urdf"
    ;;
  2r)
    resolved="${urdf_dir}/robot_2r.urdf.xacro"
    ;;
  2r_plain)
    resolved="${urdf_dir}/robot_2r.urdf"
    ;;
  3r)
    resolved="${urdf_dir}/robot_3r.urdf.xacro"
    ;;
  mobile)
    resolved="${urdf_dir}/mobile_robot.urdf.xacro"
    ;;
  mobile_sensors)
    resolved="${urdf_dir}/mobile_robot_with_sensors.urdf.xacro"
    ;;
  combined)
    resolved="${urdf_dir}/combined_robot.urdf.xacro"
    ;;
  *)
    resolved="${input}"
    ;;
esac

if [[ ! -f "${resolved}" ]]; then
  echo "[generate_urdf_preview] File not found: ${resolved}"
  exit 1
fi

base_name="$(basename "${resolved}")"
base_name="${base_name%.xacro}"
output_file="${output_dir}/${base_name}"

if [[ "${resolved}" == *.xacro ]]; then
  if ! command -v xacro >/dev/null 2>&1; then
    echo "[generate_urdf_preview] xacro is not installed. See INSTALL_WSL_UBUNTU.md"
    exit 1
  fi
  echo "[generate_urdf_preview] Generating ${output_file}"
  xacro "${resolved}" > "${output_file}"
else
  cp "${resolved}" "${output_file}"
  echo "[generate_urdf_preview] Copied ${resolved} -> ${output_file}"
fi

if command -v check_urdf >/dev/null 2>&1; then
  echo "[generate_urdf_preview] Running check_urdf"
  check_urdf "${output_file}"
else
  echo "[generate_urdf_preview] check_urdf is not available"
fi

