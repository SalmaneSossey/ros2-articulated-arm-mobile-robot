# TP2 Requirements Summary

This document maps the expected TP deliverables to the files and modules present in the repository.

## Covered Deliverables

- Basic URDF single-link robot: [robot.urdf](../ros2_ws/src/my_robot_description/urdf/robot.urdf)
- Plain URDF 2R arm: [robot_2r.urdf](../ros2_ws/src/my_robot_description/urdf/robot_2r.urdf)
- Xacro refactor for 2R arm: [robot_2r.urdf.xacro](../ros2_ws/src/my_robot_description/urdf/robot_2r.urdf.xacro)
- Exercise 1 3R arm: [robot_3r.urdf.xacro](../ros2_ws/src/my_robot_description/urdf/robot_3r.urdf.xacro)
- Exercise 2 mobile robot: [mobile_robot.urdf.xacro](../ros2_ws/src/my_robot_description/urdf/mobile_robot.urdf.xacro)
- Exercise 3 mobile robot with sensors: [mobile_robot_with_sensors.urdf.xacro](../ros2_ws/src/my_robot_description/urdf/mobile_robot_with_sensors.urdf.xacro)
- Bonus combined robot: [combined_robot.urdf.xacro](../ros2_ws/src/my_robot_description/urdf/combined_robot.urdf.xacro)

## Supporting Infrastructure

- ROS 2 package metadata: [package.xml](../ros2_ws/src/my_robot_description/package.xml), [CMakeLists.txt](../ros2_ws/src/my_robot_description/CMakeLists.txt)
- Launch files: [launch](../ros2_ws/src/my_robot_description/launch)
- RViz configurations: [rviz](../ros2_ws/src/my_robot_description/rviz)
- Validation scripts: [tools](../tools), [test_xacro_commands.sh](../ros2_ws/src/my_robot_description/test/test_xacro_commands.sh)
- User documentation: [README.md](../README.md), [INSTALL_WSL_UBUNTU.md](../INSTALL_WSL_UBUNTU.md)

## Design Notes

- The plain URDF 2R arm is kept alongside the Xacro version to match the TP progression.
- Xacro modules are split by concern:
  - [arm_macros.xacro](../ros2_ws/src/my_robot_description/urdf/components/arm_macros.xacro)
  - [mobile_base_macros.xacro](../ros2_ws/src/my_robot_description/urdf/components/mobile_base_macros.xacro)
  - [sensors_macros.xacro](../ros2_ws/src/my_robot_description/urdf/components/sensors_macros.xacro)
- Launch files resolve package paths via `get_package_share_directory`.
- ROS workspace artifacts are excluded from version control.
