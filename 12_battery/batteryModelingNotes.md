# Physics (modeling)
ECM - equivalent circuit models
## Schematic

![[ECM.svg]]

$E_0 \rightarrow open\ circuit\ voltage\ (V)$  
$V_t \rightarrow terminal\ voltage\ (V) \leftarrow output\ of\ the\ model$  
$i \rightarrow current\ draw\ (A) \leftarrow input\ to\ the\ model$  
$r_n, c_n \rightarrow resistance\ and\ capacitances\ (\ohm, F)$  

## Model equations
### Electrical model
$$V_t=E_0-\sum_{1}^n V_{c_n}-ir_0$$
$$\frac{dV_{c_n}}{dt}=\frac{i}{c_n}-\frac{V_{c_n}}{r_nc_n}$$
$$\frac{soc}{dt}=\frac{-i}{Q_{Ah}\times 3600}$$

### Thermal model
$$P_{heatGen}=i^2r_0 + \sum_{1}^n\frac{V_{c_n}^2}{r_n}$$
$$P_{heatOut}=$$

## ECM vs. electrochemical models (EChM)
1. EChM are usually coupled nonlinear partial differential equations, which take significantly higher time to run, but they characterize battery impedance more accurately
2. They typically have higher number of parameters to be identified and hence are prone to overfitting
3. Fractional order models (FOM) seem to be a middle ground between ECM and EChM

<div style="page-break-after: always;"></div>

# Parameter estimation
The following parameters need to be estimated
1. SOC - OCV curve
	1. charge curve
	2. discharge curve
	3. average curve?
2. Coulombic charge efficiency $\eta_c$
3. Capacity 
	1. total (C/30)
	2. discharge (rated - usually 1C)
	3. nominal (tbd)
4. $r_0, r_n, c_n$ tables wrt SOC, temperature, charge/discharge (and maybe C-rate)

## $r_0, r_n, c_n$ estimation
A comprehensive method is not documented. Only a discharge part without temperature dependence is exemplified in the code `xyz.m`



## Quick doubts
1. Finding out OCV-SOC curve $\rightarrow$ the C/30 charge/discharge cycles are wrt time. It establishes 0% and 100% SOC in terms of pre-defined $v_{min}$ and  $v_{max}$. How do you define SOC-OCV in the intermediate points?
	- We find capacity $Q$ and convert the time x-axis to SOC (%) as $SOC = (1 - \sum_{1}^k \frac{i}{Q}) \times 100\ \\\%$
2. 

## Asides
1. Fractional order models


<div style="page-break-after: always;"></div>

# BMS
## SOC estimation (real time)
1. Direct methods
	1. CC (Coulomb couting)
	2. ECC (Enhanced CC)
2. Model-based methods
	1. Kalman filtering
3. Data-driven methods

### Define SOC
SOC is the ratio of the present charge content of the cell to the maximum possible charge content at a pre-defined temperature and C-rate

$$SOC=\frac{Q_{remaining}}{Q_{max}}\times100\ \\\%$$

### Direct methods
#### Coulomb counting (CC)
In this method, the SOC of a cell (battery) is estimated by counting the amount of charge (coulombs) entering or leaving the battery

$$
SOC(t) = SOC(t_0) + \frac{1}{Q_{max_{As}}} \int_{0}^{T}idt \times 100\ \\\%
$$

##### Problems
Cumulative error becomes larger and larger
- strong dependence of initial value of SOC
- requires high precision current measurement which is subject to temperature drift usually
- does not consider health of the battery (unless $Q_{max_{As}}$ is calibrated)


#### Enhanced coulomb counting (ECC)
This follows the crux of counting charge, but adds corrections in terms of:
- reseting battery SOC from SOC-OCV table as it rests beyond its largest time constant (this solves the initial SOC value problem with CC)
	- it may be a table or a analytic curve (usually a logarithm fit is used to avoid the need of higher order polynomial fit)
- adding correction terms like discharge efficiency and Peukert equation coefficient and generic current-based polynomial to the term that is integrated (this solves the lack of precision with current integration)
- the additional coefficients ($\eta_{coulumb}$, $k$, $n$, $a_n$) are tuned from repeated power draw $\leftrightarrow$ rest cycles with SOC-OCV resets baked in between the cycles

$$
SOC(t) = SOC(t_0) + \frac{\eta_{coulomb}}{Q_{max_{As}}} \int_{0}^{T}
[i^k + \sum_{0}^{n}(a_ni^n)]\ dt \times 100\ \\\%
$$
- this method works for a particular power draw cycle



*Note: Direct measurement methods encompass all types of estimations, like internal resistance, capacity, etc.. SOC specifically can also be estimated from OCV and EIS non-real-time applications*





### Model-based methods
**I read somewhere** $\rightarrow$ The main idea is to use a model to predict OCV from measurements like current and voltage, and then use the OCV to lookup SOC from the OCV-SOC relationship.
#### Non-EKF
- A state-space battery model is created and SOC is used as one of the *unobservable* states
- Measurements of current, temperature and terminal voltage error (predicted vs. measured) are used to observe the internal state of SOC
- The filter (observer) gain is tuned to balance how much we trust the predicted voltage vs. the measure voltage (basically how much weightage do we give to the voltage error)
- This method relies heavily of the accuracy of the battery model, specifically in corner cases like high/low SOCs, high C-rates, high/low temperatures
- Hence usually both model-based (HiFi) and ECC-based (LoFi) algorithms are run simultaneously and an algorithm decides when to use what, or if we need to fuse the SOCs predicted by both

#### EKF
- Most widely used SOC estimator
- In EKF we linearize the non-linear system and use KF on the linear system
- It overcomes both the issue of lack of sensor accuracy and the initial value problem
- An extension to EKF is adaptive-EKF
	- in the real world the measurement and observation noise change in real time
	- AEKF estimates and iteratively updates the noise covariance 
- Some use Kalman filtering without linearization like cubature KF (CKF) and unscented KF (UKF)

# References
1. [Fractional-order modeling and parameter identification for lithium-ion batteries](https://www.sciencedirect.com/science/article/pii/S0378775315009404)
2. 


