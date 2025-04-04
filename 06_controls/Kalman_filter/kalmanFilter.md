# Observer overview
![[observer.png|300]]
For a system $\dot x = Ax + Bu, y = Cx + Du$
The observer / estimator takes in output $y$ and input $u$ and outputs the full internal states $x$ of the system.

$$
\dot{\hat{x}} = A\hat{x} + Bu + K_f(y-\hat{y})
$$
$$
\hat{y} = C \hat{x}
$$

$$
\implies \dot{\hat{x}} = (A - K_fC)\ \hat{x} + [B\ K_f] \begin{bmatrix} u \\ y \end{bmatrix}
$$

- If $A$ and $C$ are observable we can place the eigen values of $(A - K_fC)$  anywhere we want with the right $K_f$ and when we can make an optimal choice, we can call $K_f$ Kalman gain
- - If the dynamics of $(A - K_fC)$ are stable $\hat{x}$ will stably converge to $x$

# Kalman filter Overview
It's just an optimal observer
![[KF.png|500]]

For a system,
$$
\dot x = Ax + Bu + W_d
$$
$$
y = Cx + W_n
$$

$W_d$ is a Gaussian disturbance ($n\times n$ matrix) with (co)variance $V_d$
$W_n$ is a Gaussian noise with (co)variance $V_n$

If there are big disturbances $W_d \uparrow$ (system's getting kicked around a lot) the Kalman filter should trust the measurements $y = Cx + W_n$ more
If there are big sensor noise $W_n \uparrow$ the Kalman filter should trust the model $\dot x = Ax + Bu + W_d$ more

In other words, trust the model or measurement depending on the ratio of the co-variance matrices ($V_d, V_n$)

If the noise and disturbance are not independent, then there's a process and measurement noise cross-covariance matrix

# Mathematical representation
## System augmentation
To include the disturbance and noise, we augment the system matrices for $\dot x, y$

$$
\dot x = Ax + Bu + V_dd + 0.n
$$
$$
y = Cx + Du + 0.d + V_nn
$$

So now the $B$ and $D$ matrices and $u$ get augmented
$$
B_a =
\begin{bmatrix}
    B \\
    V_d \\
	0
\end{bmatrix}
$$

$$
D_a =
\begin{bmatrix}
    D & 0 & V_n
    
\end{bmatrix}
$$
$$
u_a =
\begin{bmatrix}
    u \\
    d \\
	n
\end{bmatrix}
$$

Note the $0$ above is a zero matrix of the appropriate size.

## Finding the Kalman gain


## Simulating
Once we have the Kalman gain we can estimate the full state optimally such that $\hat{x} \rightarrow x$ faster than the system dynamics and use $\hat{x}$ as full state feedback to an LQR regulator to control the system.

# Other notes
## Which output(s) to measure?
This is basically how to choose the C matrix / or finding out which output measurement would make it easiest to *observe* the rest of the states. This can be found by finding the **determinant of the observability gramian** of the system with different possible C matrices. Note - this is choosing among the C matrices for which the combination (A, C) is fully observable... it's finding out *how much* observable it is.

```Matlab
det(gram(sys, 'o'))
```

This gives the volume of the observability ellipsoid. 