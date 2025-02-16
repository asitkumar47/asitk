# Linearization basics
* Linearization is Taylor expanding a function about a point and ignoring the higher order terms
* We do the expansion about a fixed point
	* quesiton - can we expand about any point and still inearize a system?

## Taylor expansion
Taylor expand 
$ \dot x = f(x, u) $ to approximate $ f(x + \Delta x, u + \Delta u) $    
with $ \Delta x = x-x_0, \Delta u = u-u_0$

$ \dot x = \frac {d}{dt}(x_0+\Delta x) = \frac {d}{dt} \Delta x$, OR $ f(x, u) = \frac {d}{dt} \Delta x $


$$ f(x, u)\bigg\rvert_{x_0, u_0} = f(x_0, u_0) + 
						\frac{\partial f}{\partial x} \bigg\rvert_{x_0, u_0} . (x - x_0) + \
						\frac{\partial f}{\partial u} \bigg\rvert_{x_0, u_0} . (u - u_0) + \ $$
$$\frac{1}{2!} \frac{\partial^2 f}{\partial x^2} \bigg\rvert_{x_0, u_0} . (x - x_0)^2 + \
\frac{1}{2!} \frac{\partial^2 f}{\partial u^2} \bigg\rvert_{x_0, u_0} . (u - u_0)^2 + \
						\ ...$$
						
Since linearization is to be valid in a small zone around the *fixed points* 
$$ (x-x_0)^n \approx (u - u_0)^n \approx 0 \ \  \forall \ n \geq 2 $$
$$ f(x_0, u_0) = 0$$

Hence we can say
$$ \dot {\Delta x} \bigg\rvert_{x_0, u_0} = \frac{\partial f}{\partial x} \bigg\rvert_{x_0, u_0} . (x - x_0) + \
						\frac{\partial f}{\partial u} \bigg\rvert_{x_0, u_0} . (u - u_0) $$
						
$$ \dot {\Delta x} = \frac {Df}{Dx} \Delta x + \frac {Df}{Du} \Delta u $$
$$ \dot {\Delta x} = A \Delta x + B \Delta u $$

It is customary (abuse of notation) to drop the $\Delta$. Hence,
$\dot x = Ax + Bu$

$ D $ is the Jacobian matrix if $ x $ and $ u $ are vectors (system of equations)   

$$ \frac {Df}{Dx} = 
\begin{bmatrix} \frac{f_1}{x_1}, \frac{f_1}{x_2} 
\\ 
\frac{f_2}{x_1} ,\frac{f_2}{x_2}\end{bmatrix}, \
\frac {Df}{Du} = 
\begin{bmatrix} \frac{f_1}{u_1}, \frac{f_1}{xu_2} 
\\ 
\frac{f_2}{u_1} ,\frac{f_2}{u_2}\end{bmatrix} 
$$ 



## Example
### Propeller mechanical model
$$
J\dot{\omega} + b(\omega)\omega^2 = T_{aero}
$$

$$
\dot{\omega} =  - \frac{b(\omega)\omega^2}{J} + \frac{T_{aero}}{J}
$$

$ J = properller\ inertia\ (kg.m^2) $  
$ b(w) = aero\ damping\ coefficient\ (Nm.s^2) $  
$ \omega = speed\ of\ the\ propeller (rad/s) \leftarrow\ x $ (state)  
$ T_{aero} = aero\ resistive\ torque\ (Nm) \leftarrow\ u  $  (input)

 