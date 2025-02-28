# List of topics

## Linear algebra
* Eigen values, vectors
* Phase portraits
* SVD
* Toy examples
	* Compression
	* Model reduction

## Linear ODEs
* Types of ODEs
	* Unforced ODEs
	* Forced ODEs
* Examples
	* Mass-spring-damper
	* Damped pendulum
	* Flexible shaft
* Analysis
	* Different methods to solve
	* MSD to natural frequency and damping ratio
	* Oscillation
	* Time constant intuition for second order systems
	* Phase plots (vector fields)

## Numerical methods
* Taylor series
* Linearization
    * 1-state system example
    * 2-state system example
    	* compare phase space (`quiver`) 
* Integrators
	* Forward Euler
	* Backward Euler
	* Runge-kutta
	* ode45 in Matlab
	* Simplectic integrators
* Stiff ODEs
	* examples
	* solutions (with examples)
		* use stiff integrators
		* replace ODE with algebraic equation
		* replace ODE with NNs
* Differentiators

## System Identification, param estimation
* Terminologies
    * Regression
    * Grammiams
    * Lagrange polynomials
    * Polynomial wiggle
* Linear
    * manual method `Ax = b` 
    * setting up a least squares method
    * examples
        * motor param estimation
        * battery param estimation
    * POD
    * BPOD
    * ERA
* Non-linear
    * ARX
    * SINDy
    * Genetic programming
* Curve fitting
    * polynomial fit
    * spline fit (matching 1st and 2nd derivatives)

## Optimization
* `fminsearch`
* `fmincon`

## Model reduction
* SVD
* Balanced truncation

## Fourier series, transform
* DFT
* FFT

## Vector calculus
* Grad
* Div
* Curl

## PDEs
* Motivating equations
* Toy examples
	* 1d moving wave
	* 1d shock wave

## Common problems
### Dynamical systems
* MSD
* Quarter car model
* Flexible shaft
### Parameterization
* Reflected inertia


## Object oriented programming
* Uncoupled ODE
* Coupled ODE