# Mass spring damper (unforced $\rightarrow F_{ext} = 0$)

## 1. Equations of motion

The equation of motion for the unforced mass-spring-damper system:

$$
m \ddot{x} + c \dot{x} + kx = F_{ext} = 0
$$

State variables:

* $x_1 = x$ (position)
* $x_2 = \dot{x}$ (velocity)

First-order form:

$$
\begin{cases}
\dot{x}_1 = x_2 \\
\dot{x}_2 = -k/m x_1 -c/m x_2
\end{cases}
$$

State-space form:

$$
\begin{bmatrix} \dot{x}_1 \\ \dot{x}_2 \end{bmatrix} =
\begin{bmatrix} 0 & 1 \\ -\frac{k}{m} & -\frac{c}{m} \end{bmatrix}
\begin{bmatrix} x_1 \\ x_2 \end{bmatrix}
$$

or

$$ \dot{\mathbf{x}} = A \mathbf{x} $$

where:

$$
A = \begin{bmatrix} 0 & 1 \\ -\frac{k}{m} & -\frac{c}{m} \end{bmatrix}
$$

---

## 2. State-space equations in $\omega_n$ and $\zeta$ form

Using the natural frequency:

$$ \omega_n = \sqrt{\frac{k}{m}} $$

and the damping ratio:

$$ \zeta = \frac{c}{2\sqrt{mk}} $$

we rewrite the system equation:

$$ \ddot{x} + 2\zeta \omega_n \dot{x} + \omega_n^2 x = 0 $$

which gives the state-space form:

$$
\begin{bmatrix} \dot{x}_1 \\ \dot{x}_2 \end{bmatrix} =
\begin{bmatrix} 0 & 1 \\ -\omega_n^2 & -2\zeta \omega_n \end{bmatrix}
\begin{bmatrix} x_1 \\ x_2 \end{bmatrix}
$$

So, in terms of $\omega_n$ and $\zeta$:

$$
A = \begin{bmatrix} 0 & 1 \\ -\omega_n^2 & -2\zeta \omega_n \end{bmatrix}
$$

---

## 3. Time constant of a second order system

The time constant $\tau$ describes how quickly the system’s response decays. For a **first-order system**, the time constant is the time it takes for the response to decay to $1/e$ of its initial value.

For a **second-order system**, the dominant time constant is related to the real part of the eigenvalues of $A$. The characteristic equation is:

$$ s^2 + 2\zeta \omega_n s + \omega_n^2 = 0 $$

with roots:

$$ s = -\zeta \omega_n \pm \omega_n \sqrt{\zeta^2 - 1} $$

- If $\zeta < 1$ (underdamped), the real part is $-\zeta \omega_n$, so the time constant is:
  
  $$
  \tau = \frac{1}{\zeta \omega_n}
  $$

- If $\zeta \geq 1$ (overdamped or critically damped), the dominant pole determines $\tau$, but for practical purposes, we still use:
  
  $$
  \tau \approx \frac{1}{\zeta \omega_n}
  $$
  
  But note the farthest pole is $-\zeta\omega_n - \omega_n\sqrt{\zeta^2-1}$

### **Intuition behind time constant**
- A **larger $\tau$** means a slower response.
- A **smaller $\tau$** means a faster response.
- In **underdamped** systems, $\tau$ governs how fast the oscillations decay.
- In **overdamped** systems, $\tau$ determines how quickly the system settles.