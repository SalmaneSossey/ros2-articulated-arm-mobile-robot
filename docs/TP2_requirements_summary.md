# TP2 Requirements Summary

## Covered Deliverables

- Basic URDF single-link robot: [robot.urdf](/home/salmane/Tps/tp2_robotic/ros2_ws/src/my_robot_description/urdf/robot.urdf)
- Plain URDF 2R arm: [robot_2r.urdf](/home/salmane/Tps/tp2_robotic/ros2_ws/src/my_robot_description/urdf/robot_2r.urdf)
- Xacro refactor for 2R arm: [robot_2r.urdf.xacro](/home/salmane/Tps/tp2_robotic/ros2_ws/src/my_robot_description/urdf/robot_2r.urdf.xacro)
- Exercise 1 3R arm: [robot_3r.urdf.xacro](/home/salmane/Tps/tp2_robotic/ros2_ws/src/my_robot_description/urdf/robot_3r.urdf.xacro)
- Exercise 2 mobile robot: [mobile_robot.urdf.xacro](/home/salmane/Tps/tp2_robotic/ros2_ws/src/my_robot_description/urdf/mobile_robot.urdf.xacro)
- Exercise 3 mobile robot with sensors: [mobile_robot_with_sensors.urdf.xacro](/home/salmane/Tps/tp2_robotic/ros2_ws/src/my_robot_description/urdf/mobile_robot_with_sensors.urdf.xacro)
- Bonus combined robot: [combined_robot.urdf.xacro](/home/salmane/Tps/tp2_robotic/ros2_ws/src/my_robot_description/urdf/combined_robot.urdf.xacro)

## Supporting Infrastructure

- ROS 2 package metadata: [package.xml](/home/salmane/Tps/tp2_robotic/ros2_ws/src/my_robot_description/package.xml), [CMakeLists.txt](/home/salmane/Tps/tp2_robotic/ros2_ws/src/my_robot_description/CMakeLists.txt)
- Launch files: [launch](/home/salmane/Tps/tp2_robotic/ros2_ws/src/my_robot_description/launch)
- RViz configurations: [rviz](/home/salmane/Tps/tp2_robotic/ros2_ws/src/my_robot_description/rviz)
- Validation scripts: [tools](/home/salmane/Tps/tp2_robotic/tools), [test_xacro_commands.sh](/home/salmane/Tps/tp2_robotic/ros2_ws/src/my_robot_description/test/test_xacro_commands.sh)
- User documentation: [README.md](/home/salmane/Tps/tp2_robotic/README.md), [INSTALL_WSL_UBUNTU.md](/home/salmane/Tps/tp2_robotic/INSTALL_WSL_UBUNTU.md)

## Design Notes

- The plain URDF 2R arm is kept alongside the Xacro version to match the TP progression.
- Xacro modules are split by concern:
  - [arm_macros.xacro](/home/salmane/Tps/tp2_robotic/ros2_ws/src/my_robot_description/urdf/components/arm_macros.xacro)
  - [mobile_base_macros.xacro](/home/salmane/Tps/tp2_robotic/ros2_ws/src/my_robot_description/urdf/components/mobile_base_macros.xacro)
  - [sensors_macros.xacro](/home/salmane/Tps/tp2_robotic/ros2_ws/src/my_robot_description/urdf/components/sensors_macros.xacro)
- Launch files resolve package paths via `get_package_share_directory`.
- ROS workspace artifacts are excluded from version control.

