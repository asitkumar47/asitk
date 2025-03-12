# What is uncertainty analysis?
Two methods to analysis
1. analytical (using calculus)
2. numerical (Monte-carlo)

# Example problem used
Let's say we have a model to find certain output from given inputs and parameters, e.g., density of an iron cylinder. We measure the following parameters with measurement uncertainties given as:
- weight $w \rightarrow 100\pm 1N$ 
- height $h \rightarrow 30\pm 0.001m$
- diameter $d \rightarrow 7.4\pm 0.001m$
$$
\rho = \frac{M}{V} = \frac{w/g}{\pi (d/2)^2 h} = \frac{4w}{\pi g d^2 h}
$$

# Analytical method
## Propagation of error
Propagation of error is a technique used to estimate uncertainty in a result when it depends on multiple measured variables, each with its own uncertainty.

If we have a model 
$$
Y = f(x1,\ x2,\ ...,\ x_n )
$$
and each variable $x_k$ has an uncertainty of $\Delta x_k$ with the assumptions
- errors $\Delta x_k$ in input variables are small
- errors of each variables are independent (uncorrelated)

then uncertainty $\Delta Y$ is estimated as
$$
\Delta Y = \sqrt{\left(\frac{\partial Y}{\partial x_1}\Delta x_1\right)^2 + 
			\left(\frac{\partial Y}{\partial x_2}\Delta x_2\right)^2 +\ ...\ +
			\left(\frac{\partial Y}{\partial x_n}\Delta x_n\right)^2 }
$$


## Density example
$$x_1,\ x_2,\ x_3 = w, d, h$$
$$Y = \rho = \frac{4w}{\pi g d^2 h}$$
$$\frac{\partial Y}{\partial x_1} = \frac{\partial \rho}{\partial w} = \frac{4}{\pi d^2 h}$$
$$\frac{\partial Y}{\partial x_2} = \frac{\partial \rho}{\partial d} = \frac{-8w}{\pi d^3 h}$$
$$\frac{\partial Y}{\partial x_3} = \frac{\partial \rho}{\partial h} = \frac{-4w}{\pi d^2 h^2}$$

<br>

# Numerical method
## Monte-Carlo simulations


Find $\rho_{mc}$ for a whole bunch of weight, height and diameter *normally* varying within the measurement uncertainty bounds and plot the distribution. 

So with uncertainty taken into account, density with 95% confidence interval
$$
\rho = mean(\rho_{mc})\ \pm\ 2\times std(\rho_{mc})
$$

For the above-mentioned numbers (for iron)
$\rho = 7909\ \pm\ 42\ kg/m^3$

![[densityDistribution.png|600]]

Note: in Matlab it is not straightforward to generate normally distributed random numbers *between two bounds*. The following method is used to generate `n` (e.g., 10000) normally distributed random numbers [Link](https://www.mathworks.com/matlabcentral/answers/395185-normal-distribution-for-a-given-range-of-numbers)

```
normRandNumber = xmin + (xmax - xmin) * sum(rand(n, p), 2)/p
```



