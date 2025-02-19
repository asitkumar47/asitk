# Step and impulse response notes
## Impulse response
* Theoretically, we impulse the system ONLY at the first time instant $(t=0)$ and measure the outputs
    * exampe would be whacking a MSD or flexible body with a hammer and measuring displacement
* Mathematically, we start with a unit IC in the $input\ u$ direction


For a linear system $\dot x = Ax + Bu$, the *initial condition* ($x_0$) respose ($u=0$) in given by
$$
x(t)_{IC} = e^{At}x_0
$$

For the same linear system, the *impulse* response will be given by
$$
x(t)_{impulse} = e^{At}B
$$

Comparing the above two equations we see $B = x_0$. This is giving a unit IC in the B direction. 

### Question
1. How does this change when we have multiple inputs $u$? (i.e., the $B$ matrix has more than one column) 

## Step response
* Step response is giving a unit input $u$ to a system from rest $x_0=0$ for all time
* Skipping the mathematical expression here as it involves convolution integrals and all


## Matlab simulation
| Method     | Impulse 			        | Step                  |   Code format|
| :----------| :---------------:      |:---------------------:|:-------------:|
| Built-in   |`impulse(linSys)`       |`step(linSys)`         |               |
| Manual1    |`lsim(linSys, 0, t, B)` |`lsim(linSys, 1, t, 0)`|`lsim(sys, u, t, x0)`|
| Manual2    |`expmv(A, B, t)`        |                       | $=e^{At}B$      |

For a simple MSD sytem here's a comparison plot of the above mentioned methods
![[manualImpulseAndStep.png | 600]]


## Other insights
1. Writing out impulse response for discrete systems generates the format of a controllability matrix. For a system with $n$ states, the ctrollability matrix $C$
$$
C = [B\,\ AB\,\ A^2B\,\ ...\ A^{n-1}B]
$$ 
2. This is why the *impule* response is tied to the how well we can control the system, i.e., are there any directions in $\mathbb{R}^n$ that are not touched by the designed input system $Bu$

## Future work
1. Use Matlab's `impulse` command to back out the mathematical definition of impulse response of a *multi-input* system
