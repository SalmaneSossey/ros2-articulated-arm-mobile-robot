#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/.." && pwd)"

echo "[setup_repo] Repo root: ${repo_root}"
echo "[setup_repo] This project does not create a Python virtual environment by default."
echo "[setup_repo] ROS 2 should use the system installation under /opt/ros."
echo "[setup_repo] Running environment check..."
"${script_dir}/env_check.sh" || true
echo "[setup_repo] Next steps:"
echo "  1. Read INSTALL_WSL_UBUNTU.md if any tools are missing"
echo "  2. Run ./tools/build_workspace.sh"
echo "  3. Source ./tools/source_ros.sh"
echo "  4. Launch one of the robots with ./tools/launch_2r.sh or related scripts"

