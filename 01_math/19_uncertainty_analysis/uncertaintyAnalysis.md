# What is uncertainty analysis?
Two methods to analysis
1. analytical (using calculus)
2. numerical (Monte-carlo)

# Numerical method
Let's say we have a model to find certain output from given inputs and parameters, e.g., density of a cylindrical object. We can measure the following with the following measurement uncertainties:
- weight $W \rightarrow 100\pm 1N$ 
- height $h \rightarrow 30\pm 0.001m$
- diameter $d \rightarrow 7.4\pm 0.001m$
$$
\rho = \frac{M}{V} = \frac{W/g}{\pi (d/2)^2 h} = \frac{4W}{\pi g d^2 h}
$$

Find $\rho_{mc}$ for a whole bunch of weight, height and diameter *normally* varying within the measurement uncertainty bounds and plot the distribution. 

So with uncertainty taken into account, density with 95% confidence interval
$$
\rho = mean(\rho_{mc})\ \pm\ 2\times std(\rho_{mc})
$$

For the above-mentioned numbers (for iron)
$\rho = 7909\ \pm\ 42\ kg/m^3$

![[densityDistribution.png|500]]

Note: in Matlab it is not straightforward to generate normally distributed random numbers *between two bounds*. The following method is used to generate `n` (e.g., 10000) normally distributed random numbers [Link](https://www.mathworks.com/matlabcentral/answers/395185-normal-distribution-for-a-given-range-of-numbers)

```
normRandNumber = xmin + (xmax - xmin) * sum(rand(n, p), 2)/p
```



