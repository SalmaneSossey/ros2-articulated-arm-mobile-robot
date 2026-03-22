# Install Guide For Ubuntu Under WSL

## Detected Environment

- Host style: WSL2 on Linux kernel `6.6.87.2-microsoft-standard-WSL2`
- Distribution: Ubuntu 22.04.5 LTS (`jammy`)
- Python detected first on `PATH`: `/home/salmane/.pyenv/shims/python3`
- Python version: `3.11.9`
- ROS setup present on disk: `/opt/ros/humble/setup.bash`
- ROS environment already sourced in the original shell: no
- `ros2` available after sourcing `/opt/ros/humble/setup.bash`: yes
- `colcon` available: yes
- `check_urdf` available after sourcing ROS: yes
- `rviz2` available after sourcing ROS: no
- `xacro` available after sourcing ROS: no
- `python3` on current `PATH` points to a `pyenv` interpreter, not Ubuntu system Python

## What Is Missing

The current machine appears to have a partial ROS 2 Humble installation. At minimum, the following packages are likely still needed for this TP:

- `ros-humble-rviz2`
- `ros-humble-xacro`
- `ros-humble-robot-state-publisher`
- `ros-humble-joint-state-publisher`
- `ros-humble-joint-state-publisher-gui`
- `ros-humble-launch-ros`
- `ros-humble-urdf`
- `liburdfdom-tools`

If `ament_cmake` is missing during build, also install:

- `ros-humble-ament-cmake`

## Recommended Commands

Update package metadata:

```bash
sudo apt update
```

Install the missing ROS packages:

```bash
sudo apt install -y \
  ros-humble-rviz2 \
  ros-humble-xacro \
  ros-humble-robot-state-publisher \
  ros-humble-joint-state-publisher \
  ros-humble-joint-state-publisher-gui \
  ros-humble-launch-ros \
  ros-humble-urdf \
  liburdfdom-tools
```

Optional if build complains about CMake package support:

```bash
sudo apt install -y ros-humble-ament-cmake
```

## Source ROS In New Shells

For the current shell:

```bash
source /opt/ros/humble/setup.bash
```

For convenience in future shells, you may add this line to `~/.bashrc`:

```bash
source /opt/ros/humble/setup.bash
```

This repo also provides:

```bash
source /home/salmane/Tps/tp2_robotic/tools/source_ros.sh
```

## After Installation

Restart the terminal, or reopen VS Code in WSL, then run:

```bash
cd /home/salmane/Tps/tp2_robotic
source tools/source_ros.sh
tools/env_check.sh
tools/build_workspace.sh
source tools/source_ros.sh
tools/launch_2r.sh
```

If you prefer building manually and your shell uses `pyenv`, force the ROS build to use Ubuntu's Python:

```bash
cd /home/salmane/Tps/tp2_robotic/ros2_ws
source /opt/ros/humble/setup.bash
colcon build --packages-select my_robot_description --cmake-args -DPython3_EXECUTABLE=/usr/bin/python3
```

## VS Code Remote - WSL Refresh

If VS Code still shows an old environment:

1. Close the current WSL terminal in VS Code.
2. Run `Developer: Reload Window` inside VS Code.
3. Open a fresh integrated terminal.
4. Run `source tools/source_ros.sh`.

## Why No Python Venv For ROS

ROS 2 command-line tools, launch files, and package indexing are meant to run from the distro-managed system installation. A Python virtual environment can be useful for optional tooling, but it should not replace the ROS environment. This repository therefore keeps ROS on the system environment and does not require a `.venv`.
