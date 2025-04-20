## Objective
The objective of this is to *see* how varying the different parameters of a propeller *shaft* (not propeller) changes its speed characteristics. The torque to speed dynamics can be modeled as a mechanical shaft with inertia, linear damping, aero damping and stiction.
## Model
$$
\dot \omega = \frac{1}{J}\times (T - b_a\omega^2 - b_l\omega - s)
$$
$J$ is shaft inertia (including propeller) $kg.m^2$
$b_a$ is aero damping (as the propeller spins) $Nm.s^2$ (this varies with speed in reality - but kept constant here)
$b_l$ is linear damping $Nm.s$
$s$ is stiction

### Stiction details
Theoretically, 
- $\omega = 0$
	- $s = min(|T|, s_{max}) \times sign(T)$
-  $\omega \neq 0$
	- $s = s_{max} \times sign(\omega)$

For numerical simulation
- $|\omega| < 10^{-6}$ (very small number)
	- $s = min(|T|, s_{max}) \times sign(T)$
-  $\omega < J \times \Delta t$
	- $s = (\omega \times s_{max}) \ / \ (J \times \Delta t)$
- $\omega \geq J \times \Delta t$
	- $s = s_{max} \times sign (\omega)$

## Simulation with parameter variation
- blue line - baseline
- orange line - only stiction increases
	- lower steady state speed
	- lower acceleration from the start
	- higher deceleration throughout - as soon as external torque is removed
- yellow line - only linear damping increases
	- same lower steady state speed as the orange line
	- lower acceleration as speed gets higher
	- lower deceleration as speed reduces - yellow line is almost parallel to the blue line
![[propShaftParamVariation.png]]

