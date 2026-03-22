# Kinematics Notes

## 3R Planar Arm Forward Kinematics

For the 3R planar arm, the end-effector position in the plane is:

```text
x = L1*cos(q1) + L2*cos(q1+q2) + L3*cos(q1+q2+q3)
y = L1*sin(q1) + L2*sin(q1+q2) + L3*sin(q1+q2+q3)
```

With this repository's dimensions:

- `L1 = 0.5 m`
- `L2 = 0.4 m`
- `L3 = 0.2 m`

## Specific Case

Given:

- `q1 = 0`
- `q2 = 90 deg = pi/2`
- `q3 = -90 deg = -pi/2`

Then:

- `q1 + q2 = 90 deg`
- `q1 + q2 + q3 = 0 deg`

Substituting:

```text
x = 0.5*cos(0) + 0.4*cos(90 deg) + 0.2*cos(0)
  = 0.5 + 0 + 0.2
  = 0.7 m

y = 0.5*sin(0) + 0.4*sin(90 deg) + 0.2*sin(0)
  = 0 + 0.4 + 0
  = 0.4 m
```

So the end-effector position is:

```text
(x, y) = (0.7, 0.4)
```

## Degrees Of Freedom

- The 2R arm has `2` planar rotational degrees of freedom.
- The 3R arm has `3` planar rotational degrees of freedom.
- The combined robot in this repository has `7` modeled joint degrees of freedom:
  - `4` wheel rotations
  - `3` arm revolute joints

## Mobile Robot Notes

### Why The Wheel Cylinder Is Rotated

In URDF, a cylinder's main axis is aligned with the local `z` axis by default. A wheel should rotate around its axle, and for this robot the axle is lateral, along the robot `y` direction. That is why each wheel visual and collision cylinder is rotated by `rpy="pi/2 0 0"` before being attached to the base.

Without this rotation, the wheel would stand upright like a vertical drum instead of lying on its side like a real wheel.

### Why TF Placement Matters For Sensors

TF defines where each sensor frame is located relative to the robot base and the world. If the LiDAR frame or camera frame is placed incorrectly, RViz and downstream perception tools will interpret observations from the wrong physical location.

That affects:

- where obstacles appear in the map or visualization
- how far an obstacle seems from the robot
- whether an obstacle appears in front of the robot, inside it, or off to the side

### Obstacle Interpretation Example

In this repository:

- the LiDAR is centered above the base
- the camera is mounted at the front edge of the base

So if both sensors detect the same obstacle, the camera frame will naturally report it from a slightly more forward position than the base center, while the LiDAR reports from the centered elevated frame. This does not mean the obstacle moved. It means each observation is expressed from a different sensor origin.

Correct TF placement lets ROS transform both observations consistently back into the base frame or world frame.

## TF Composition Concept

The combined robot TF chain is built by composing transforms from parent to child links:

```text
world -> mobile_base_link -> arm_base_link -> arm_link_1 -> arm_link_2 -> arm_link_3
```

Each joint transform is applied in sequence. RViz then uses the composed chain to place every child link correctly in the shared `world` frame.
