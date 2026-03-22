# Runtime Validation On 2026-03-22

This document records the live validation results observed on Ubuntu 22.04 under WSL with ROS 2 Humble after the missing ROS packages were installed.

## Environment

- ROS 2 distro: `humble`
- Platform: Ubuntu in WSL
- GUI path: WSLg active
- Launch stack used:
  - `robot_state_publisher`
  - `joint_state_publisher_gui`
  - `rviz2`

## Script Validation

The following command completed successfully in the live user environment:

```bash
./tools/validate_workspace.sh
```

Confirmed outcomes:

- environment checks passed
- plain URDF parsing passed
- workspace build passed
- all Xacro expansions passed

## GUI Validation

The following launch flows were confirmed to start successfully in the live WSL session:

```bash
tools/launch_2r.sh
tools/launch_3r.sh
tools/launch_mobile.sh
tools/launch_mobile_sensors.sh
tools/launch_combined.sh
```

Observed behavior from the shared logs:

- `robot_state_publisher` loaded the expected link trees
- `joint_state_publisher_gui` opened and responded
- `rviz2` opened successfully
- OpenGL initialized correctly in RViz

The warnings about `/mnt/wslg/runtime-dir` permissions did not prevent the applications from launching in the live WSL session.

## Confirmed Models

### 2R Arm

The 2R arm was displayed in RViz with:

- visible base cylinder
- orange first link
- blue second link
- working joint sliders in `joint_state_publisher_gui`

### 3R Arm

The 3R arm was displayed in RViz with:

- visible third link
- green terminal link
- three working joint sliders in `joint_state_publisher_gui`

### Mobile And Combined Robots

The mobile, mobile-with-sensors, and combined launch commands started successfully in the live environment and published the expected links.

From the logs:

- mobile base included `front_left_wheel`, `front_right_wheel`, `rear_left_wheel`, `rear_right_wheel`
- sensor model included `lidar_link` and `camera_link`
- combined robot included `arm_base_link`, `arm_link_1`, `arm_link_2`, `arm_link_3`, and all mobile wheel links

## Screenshots

Screenshots of the live RViz and `joint_state_publisher_gui` sessions were shared during validation and visually confirm:

- the 2R arm rendering
- the 3R arm rendering
- TF and RobotModel enabled in RViz

If you want these screenshots embedded directly in the repository, save them into a tracked folder such as `docs/images/` and reference them from this document.
