## Drag
Specifically drag during fixed-wing cruise
- There are two types of [drag](https://aviation.stackexchange.com/questions/52494/what-creates-most-drag-during-flight-fuselage-or-wings)
	- parasitic drag $D_p$
		- non-lift related drag
		- drag coming from wetted surface (shape), friction, etc.
	- induced drag $D_i$
		- drag induced as a result of lift creation
		- this drag is produced at wing tips [NASA](https://www.grc.nasa.gov/www/k-12/VirtualAero/BottleRocket/airplane/dragco.html)
		- predominantly by the wings (as the fuselage also creates some lift)
		- this is physically a backward tilt of the lift vector 
- Induced drag dominates at low speed
- Parasitic drag dominates at high speed

![[dragCurve.png|400]]

The intersection of the two drags is technically the best range speed. But in practice, best-range cruise speed is set at a slightly higher speed. **The reason is stability.** If speed reduces slightly from the minimum drag point, drag increases and speed reduces further. Without the addition of thrust or initiation of descent this behavior is heading in the direction of stall / loss-of-control.

### Equations
Lift induced drag
$$
D_i = \frac{1}{2}\rho C_{D_i} V^2 S
$$
$$C_{D_i} = \frac{C_L^2}{\pi e (AR)}$$
$$C_L = \frac{2W}{\rho V^2 S}$$
$$\implies C_{D_i} = \frac{(\frac{2W}{\rho V^2 S})^2}{\pi e (AR)} = 
\frac{4W^2}{\pi e \rho^2 V^4 S^2 AR}$$

Parasitic drag
$$
D_p = \frac{1}{2} \rho C_{D_0} V^2 S
$$

|Symbol|Descriptio|Unit|
|--|--|--|
|$\rho$|air density|$kg/m^3$|
|$C_{D_i}$|coeff of induced drag|-|
|$C_{D_0}$|coeff of parasitic drag|-|
|$S$|reference wing area (to be clarified further)|$m^2$|


## Lift
