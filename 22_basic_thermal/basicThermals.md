# Heat transfer modes
## Conduction
Fourier's law

## Convection
Newton's law of cooling

## Radiation
Stephan-Boltzman law

# Forgotten terminologies
## Kinematic viscosity
Represents how easily air flows due to internal resistances, independent of external forces.
$$
\nu = \frac{\mu}{\rho}
$$
$\mu$ is dynamic viscosity $kg.m^{-1}s^{-1}$
$\rho$ is density $kg/m^3$

## Dynamic viscosity
Represents how much force is needed to move one layer of fluid relative to another
$$
\tau = \mu \frac{du}{dy}
$$
$\tau$ is shear stress $N/m^2$
$du/dy$ is velocity gradient $1/s$
$\mu$ is dynamic viscosity $Pa.s, kg./m^{-1}s^{-1}$

# Dimensionless numbers
[YouTube](https://www.youtube.com/watch?v=QHMsb13jRQw)

||Reynold|Prantl|Grashoff|Nusselt|Reyleigh
|-|-|-|-|-|-|
|Range|$>0$|$\geq1$|||



## Reynold
Ratio of inertial forces to viscous forces
$$
R_e = \frac{\rho V L_c}{\mu}
$$
$V$ is air velocity $m/s$
$L_c$ characteristic length $m$
$\mu$ is dynamic viscosity of fluid $Pa.s$
$\rho$ density of fluid ^75543b

$L_c$ depends on the flow configuration
- for pipe flow $L_c = r_{pipe}$
- for cross-flow over a cylinder (flow perpendicular to axis) $L_c = 2r_{cylinder})$ ^1ffba7

|$R_e$ upper limit for $\rightarrow$|Laminar|Transitional|Turbulent|
|-|-|-|-|
|Internal flow<br>e.g., inside a pipe|2300|3500|> 3500|
|External flow <br> e.g., over cylinder, sphere|$10^5$|$3\times 10^5$|$>3\times 10^5$|
|Flat plate boundary layer|$<5\times 10^5$|$10^6$|$>10^6$|


## Prantl 
It is the ratio of momentum diffusivity and thermal diffusivity
It relate the behavior of the thermal boundary layer and velocity boundary layer  $L_{vbl} / L_{tbl} = P_r^n$

$$
P_r = \frac{C_p\mu}{k}
$$
$C_p$ is specific heat capacity $J.kg^{-1}K^{-1}$
$\mu$ is fluid dynamic viscosity $kg.m^{-1}s^{-1}$
$k$ is fluid thermal conductivity $W.m^{-1}K^{-1}$


## Grashof
It quantifies the ratio of buoyancy forces to viscous forces
Higher the ratio, more dominant are the buoyancy forces $\implies$ stronger natural convection

$$
G_r = \frac{g \beta (T_s - T_{ambient}) L_c^3}{\nu^2}
$$
$g$ gravitational constant $m/s^2$
$\beta = {1}/{T_{avg}}$
$T_s$ is surface temperature
$L_c$ is characteristic length [[#^1ffba7]]
$\nu$ is [[#Kinematic viscosity|kinematic viscosity]] $m^2.s$ (yes, meter squared)


## Nusselt
$N_u$ is the ratio of convection and conduction heat transfer at the layer of the fluid

$$
N_u \geq 1
$$

If $N_u = 1$, heat transfer only happens from conduction, i.e., no contribution from fluid motion.
The most important application of $N_u$ is the calculation of the convective heat transfer of a fluid.

## Rayleigh 

## Biot $B_i$
- Biot number is the ratio of thermal resistance for conduction inside a body to the resistance for convection at the surface of the body.
- Problems involving small Biot number ($<<1$) are analytically simpler.
	- this makes temperature uniform inside the body
	- enabling lumped capacitance modeling for body temperature evolution
$$
B_i = \frac{h}{k}L_c
$$
$$
L_c = \frac{Body\ volume}{Heated/ cooled\ surface\ area}
$$

$h$ is convective heat transfer $W.m^{-2}K{-1}$
$k$ is thermal conductivity $W.m^{-1}K^{-1}$
$L_c$ is characteristic length $m$

## How to calculate these numbers for complex shapes?

# Terminologies
1. dynamic pressure
2. viscosity 
	1. dynamic viscosity
	2. turbulent dynamic viscosity
3. Biot number


