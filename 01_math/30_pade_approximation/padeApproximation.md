# Pade approximation (PA)
## General description
* At it's core the PA is a fucntion approximation.   
* Any fucntion can be approximated as a rational (ratio of) polynominal function. 
	* The numerator and denominator can be of different order.  
* In the dynamical-systems world, it is commonly used to approximate a time delay.
* A linear ODE can be represented as a Transfer Function. 

## Mathematically
A system $ G(s) $ with a time delay can be represented as
$$ 
G(s) = e^{-st} \frac{1}{\tau s + 1}
$$
PA approximates $ e^{-st} $ part and the TF becomes, e.g., 
$$
G(s) \approx \frac{1-0.5s}{1+0.5s}.\frac{1}{\tau s + 1}
$$

More generally the Pade approximation is of the form
$$
\frac{\sum_{j=0\rightarrow m}a_j x^j}{1+\sum_{k=1\rightarrow n}b_k x_k}
$$
This is equated to the first $ m+n $ terms of the Taylor exapnsion of $ e^{-s} $ which is given by
$$ 
e^{-s} = \sum_{n=o\rightarrow \infty} \frac {(-s)^n}{n!}
$$

* We typically ignore a higher order coefficient matching for some reason, and that somehow produces better approximations had we considered it.  
* We use similar order for numerator and denominator, otherwise the gain of the TF also gets affected (steep fall off at high frequencies)

## Example
$$
TF = \frac{1}{s^2 + 0.5s + 1}
$$
$$
TF_{delay} = e^{-st}\frac{1}{s^2 + 0.5s + 1}
$$
$$
TF_{pade(order2)}= \frac{s^2 - 6s + 12}{s^2 + 6s + 12}
$$
$$
TF_{delayPA} = \frac{s^2 - 6s + 12}{s^4 + 6.5s^2 + 16s^2 + 12s + 12}
$$

<img src = "/Users/asitkumar/Documents/GitHub/asitk/01_math/30_pade_approximation/padePlot.png" width="760">

We can see that $TF_{delayPA}$ (black dotted) is approximating $TF_{delay}$ (red dotted) by matching the phase margin at the cross-over frequency (frequency at -3dB gain)

**Note - PA approximates the delay, it does NOT remove the delay meaning it does NOT alleviate the lesser phase margin that comes with delay.** It only returns a TF with finite poles so that controller design can be done to increase the phase margin.


### Why time delay matters?
* Short answer - it reduces phase margins
* Stability margins are given by i) gain margin, ii) phase margin
    * gain margin - how much (dB) can the system gain increase before system becomes unstable
    * phase margin - how much phase shift can happen before system becomes unstable. It is measured in degrees as $180^0 - phase$ at cross-over frequency (0dB gain frequency)
* Systems with delays mathematically have $\infty$ poles (or states). So controllers like LQR can not be used.
    * this is why pade approximation works as it converters a $ \infty $ pole system to a finite one (depending on the order of PA)

### How to choose the order of PA
* Short answer - PA should match the phase at cut-off frequency (-3dB gain) of the system **with delay** 
* Increase the order till that happens 


## Other usage of PA

## Other ways of approximating delays


## Asides
1. Number of poles of a system with time delay is $\infty$



## Link, and resources
1. [Brian Douglas, Matlab Techtalk](https://www.youtube.com/watch?v=3TK8Fi_I0h0)
2. [pade from Matlab](https://www.mathworks.com/help/control/ref/dynamicsystem.pade.html)
 