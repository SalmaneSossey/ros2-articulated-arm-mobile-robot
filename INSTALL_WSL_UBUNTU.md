# Install Guide For Ubuntu Under WSL

## Reference Validation Environment

This repository was validated on:

- WSL2
- Ubuntu 22.04 (`jammy`)
- ROS 2 Humble

One practical issue observed during validation was that some shells used `pyenv`'s `python3` instead of Ubuntu's system Python. The helper scripts in this repository already account for that during `colcon build`.

## Typical Missing Packages

If your Ubuntu/WSL setup has only a partial ROS 2 Humble installation, the following packages are commonly needed for this repository:

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
source tools/source_ros.sh
```

## After Installation

Restart the terminal, or reopen VS Code in WSL, then run:

```bash
cd <your-repo-path>
source tools/source_ros.sh
tools/env_check.sh
tools/build_workspace.sh
source tools/source_ros.sh
tools/launch_2r.sh
```

If you prefer building manually and your shell uses `pyenv`, force the ROS build to use Ubuntu's system Python:

```bash
cd ros2_ws
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
