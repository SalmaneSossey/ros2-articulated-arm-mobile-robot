# Validation Checklist

## Environment

- [ ] `tools/env_check.sh` reports `ros2`
- [ ] `tools/env_check.sh` reports `colcon`
- [ ] `tools/env_check.sh` reports `xacro`
- [ ] `tools/env_check.sh` reports `rviz2`
- [ ] `tools/env_check.sh` reports `check_urdf`

## Plain URDF Models

- [ ] `check_urdf urdf/robot.urdf`
- [ ] `check_urdf urdf/robot_2r.urdf`

## Xacro Models

- [ ] 2R Xacro expands successfully
- [ ] 3R Xacro expands successfully
- [ ] mobile robot Xacro expands successfully
- [ ] mobile robot with sensors Xacro expands successfully
- [ ] combined robot Xacro expands successfully

## Workspace

- [ ] `colcon build --packages-select my_robot_description`
- [ ] `source install/setup.bash`

## Launch

- [ ] `ros2 launch my_robot_description display.launch.py`
- [ ] `ros2 launch my_robot_description display_2r.launch.py`
- [ ] `ros2 launch my_robot_description display_3r.launch.py`
- [ ] `ros2 launch my_robot_description display_mobile.launch.py`
- [ ] `ros2 launch my_robot_description display_mobile_sensors.launch.py`
- [ ] `ros2 launch my_robot_description display_combined.launch.py`

## Visualization

- [ ] `RobotModel` visible in RViz2
- [ ] `TF` tree visible in RViz2
- [ ] joints change live via `joint_state_publisher_gui`

## Live Result

- [x] Validated successfully on a live WSL session on `2026-03-22`
- [x] RViz2 opened successfully in the user environment
- [x] `joint_state_publisher_gui` opened successfully in the user environment
- [x] 2R and 3R arm screenshots were visually confirmed
