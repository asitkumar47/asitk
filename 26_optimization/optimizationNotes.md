# Terminologies

1. Objective function
	- a mathematical function that is usually minimized
2. Constraints
	- limitations on decision variables
3. Decision variables
	- design variables to be found (influence the value of objective function)
4. Feasible region
	- set of all values of decision variables that satisfies the constraints
5. Optimal solution
	- set of values of decision variables that satisfies the constraints and minimizes the objective function
6. Types of optimizations
	1. constraint and unconstraint
	2. linear and nonlinear
	3. continuous and discrete (integer)
	4. convex and non-convex optimization
7. Lagrangian multipliers
8. Gradient descent
	1. stochastic vs regular gradient descent
9. Back propagation
10. Methods of optimization
	1. Simplex
	2. Gradient descent
	3. Newton's method
	4. GA
	5. Simulated annealing
	6. Stochastic gradient descent
11. KKT (Karush-Kuhn-Tucker)
12. First and second order optimization
13. Duality principle
14. Automatic differentiation
15. MDO


# Convex vs. non-convex
Formal definition
If the minimum of a function lies at or below any two point on the space spanned by the function, then the function convex. A convex function has one minima.

A non-convex function has multiple peaks and valleys and have multiple local minima at which a gradient-based method can get stuck in a local minima. Advanced techniques like GA, simulated annealing, stochastic gradient descent maybe required.

# Lagrangian multiplier
## General idea
Idea is to **bake the constraints of an optimization function to the objective function**, essentially transforming a constraint OP to an unconstraint OP. In an constraint OP since the feasible region is limited, there's good advantage in converting it into an unconstraint OP that enables us to use standard optimization techniques like gradient descent.

## Mathematical definition
$$
\mathcal{L}(x, y, \lambda) = f(x, y) - \lambda g(x, y)
$$
$\mathcal{L}$ is the Lagrange function
$f(x, y)$ is the original objective function (without constraint baked in)
$g(x, y)$ is the constraint function
$\lambda$ is the Lagrange multiplier, which represents how much the objective function changes when the constraint is slightly relaxed

## Mathematical idea
The key idea is **at the optimal point**
- the gradient of the objective function $\nabla f$ is **parallel** to the gradient of the constraint $\nabla g$
- the Lagrange multiplier $\lambda$ scales the **constraint gradient** to **match** the **objective function gradient**

It works for nonlinear constraints as well, but they have to be differentiable

## Limitations
- only works for equality constraints
	- but can be extended using KKT (Karush-Kuhn-Tucker) conditions
- only guarantees local optimum

# KKT
Karush-Kuhn-Tucker

## General idea
It is the generalization of Lagrange multiplier. Lagrange multiplier way of solving a constraint OP only works for equality constraint. KKT can handle both equality and inequality constraints

## Mathematical idea


It works for nonlinear constraints as well, but they have to be differentiable

## Limitations
- only guarantees local optimum for non-convex OP
- applies to continuous systems


