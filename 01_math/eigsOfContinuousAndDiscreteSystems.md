# Eigen values
For the system to be stable the
* real parts of Eigen values of a continuous system must be $<0$
* absolute value of Eigen values of a discrete system must be $<1$ 

Note: this is only to get an intuition, not establish mathematical rigor.

## For a continuous system $\dot x = Ax$
The general solution is given by

$$x(t) = e^{At}$$
If $A$ it's a single state system

$$x(t) = e^{at}$$

$x(t)$ will decay (stable) onyl if $a<0$

## For a discrete system $x_{k+1} = \tilde Ax_k$
Note: for the same system, $\tilde A \neq A$
Writing the solution

$$x_1 = \tilde Ax_0$$
$$x_2 = \tilde Ax_2 = \tilde A^2x_0$$
$$x_3 = \tilde Ax_2 = \tilde A^3x_0$$
$$\vdots$$
$$x_n = \tilde A^nx_0$$

Or, for a system with one state

$$x_n = \tilde a^nx_0$$

$x_n$ will decay (stable) only if $|\tilde a| < 1$ 