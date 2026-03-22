# Troubleshooting

## `ros2: command not found`

ROS is installed but not sourced in the current terminal. Run:

```bash
source /opt/ros/humble/setup.bash
```

Or:

```bash
source /home/salmane/Tps/tp2_robotic/tools/source_ros.sh
```

## `xacro: command not found`

Install the package:

```bash
sudo apt install -y ros-humble-xacro
```

## `rviz2: command not found`

Install RViz2:

```bash
sudo apt install -y ros-humble-rviz2
```

## `joint_state_publisher_gui` Or `robot_state_publisher` Missing

Install the runtime tools:

```bash
sudo apt install -y \
  ros-humble-joint-state-publisher \
  ros-humble-joint-state-publisher-gui \
  ros-humble-robot-state-publisher
```

## `colcon build` Fails

Check:

- ROS is sourced before building
- `ament_cmake` is installed
- you are running the command from [ros2_ws](/home/salmane/Tps/tp2_robotic/ros2_ws)

If you use `pyenv`, ROS may accidentally pick a Python interpreter that does not contain `catkin_pkg`. In that case, force the system interpreter:

Try:

```bash
source /opt/ros/humble/setup.bash
cd /home/salmane/Tps/tp2_robotic/ros2_ws
colcon build --packages-select my_robot_description --cmake-args -DPython3_EXECUTABLE=/usr/bin/python3
```

## `check_urdf` Reports XML Problems

Start with the plain URDF files:

```bash
source /opt/ros/humble/setup.bash
check_urdf /home/salmane/Tps/tp2_robotic/ros2_ws/src/my_robot_description/urdf/robot.urdf
check_urdf /home/salmane/Tps/tp2_robotic/ros2_ws/src/my_robot_description/urdf/robot_2r.urdf
```

For Xacro models, generate a URDF first:

```bash
source /home/salmane/Tps/tp2_robotic/tools/source_ros.sh
tools/generate_urdf_preview.sh 3r
```

## RViz2 Opens But Nothing Is Visible

Check:

- `Fixed Frame` is `world`
- `RobotModel` is enabled
- `TF` is enabled
- `joint_state_publisher_gui` is running

For mobile and combined robots, remember the base link is elevated above the ground because the wheel radius and chassis dimensions are modeled explicitly.

## GUI Apps Fail Inside WSL

Common causes:

- no WSLg
- missing X server
- stale shell that was opened before installation

Try reopening VS Code in WSL and launching again from a fresh terminal.
