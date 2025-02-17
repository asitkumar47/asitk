# Stiff systems
## Define stiffness
* The curve is smooth
* But the time step required to integrated is *very* small
* Or, for a linear system eigen values of the system are different by orders of magnitude, such that the time step of integration is dictated by the smallest one
* This might result in
    * solver failure
    * *slow* integration

# Solvers
* Explicit solvers are bad at handling stiffness e.g., `ode45`
* Implicit solvers are inherently better `ode15s, 23s, 23t, 23tb`
* A good practice is to provide analytic Jacobians in solver options, or the solver numerically comptues it
* Solver options are given by `odeset` [Link](https://www.mathworks.com/help/matlab/ref/odeset.html)

## Example problems
* an actuator / MSD hitting the bump stop
* a ball bouncing

## Methods to *handle* stiff problems
Yes, *handle*, not necessarily *solve*. 

1. use a stiff solver mentioned above
2. replace the stiff dynamics with algebriac equation
    3. by using knowledge of the system
    4. by conservation laws like mass / energy
5. replace the stiff dynamics with a black box (NN)
    6. which outputs the steady state value (like method2)


## Reference
* [Matlab documentation](https://www.mathworks.com/help/matlab/math/solve-stiff-odes.html)
* 