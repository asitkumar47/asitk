# Physics
## Schematic

![[ECM.svg]]

$E_0 \rightarrow open\ circuit\ voltage\ (V)$
$V_t \rightarrow terminal\ voltage\ (V) \leftarrow output\ of\ the\ model$
$i \rightarrow current\ draw\ (A) \leftarrow input\ to\ the\ model$
$r_n, c_n \rightarrow resistance\ and\ capacitances\ (\ohm, F)$

## Model equations
### Electrical model
$$V_t=E_0-\sum_{1\rightarrow n}V_{c_n}-ir_0$$
$$\frac{dV_{c_n}}{dt}=\frac{i}{c_n}-\frac{V_{c_n}}{r_nc_n}$$
$$\frac{soc}{dt}=\frac{-i}{Q_{Ah}\times 3600}$$

### Thermal model
$$P_{heatGen}=i^2r_0 + \sum_{1\rightarrow n}\frac{V_{c_n}^2}{r_n}$$
$$P_{heatOut}=$$


<div style="page-break-after: always;"></div>

# BMS
## SOC estimation (real time)
1. Direct methods
	1. CC (Coulomb couting)
	2. ECC (Enhanced CC)
2. Model-based methods
	1. ECM observer models
3. Data-driven methods

### Define SOC
SOC is the ratio of the present charge content of the cell to the maximum possible charge content at a pre-defined temperature and C-rate
$$SOC=\frac{Q_{remaining}}{Q_{max}}\times100\ [\%]%$$

### Direct methods
#### Coulomb counting (CC)
In this method, the SOC of a cell (battery) is estimated by counting the amount of charge (coulombs) entering or leaving the battery
$$
SOC(t) = SOC(t_0) + \frac{1}{Q_{max_{As}}} \int_{0}^{T}idt \times 100 \%
$$

##### Problems
- requires high precision current measurement
- does not consider health of the battery (unless $Q_{max_{As}}$ is calibrated)


#### Enhance coulomb counting (ECC)
This follows the crux of couting charge, but adds corrections in terms of:
- reseting battery SOC from SOC-OCV table as it rests beyond its largest time constant 
- adding correction terms like discharge efficiency and Peukert equation coefficient and generic current-based polynomial to the term that is integrated
- the additional coefficients ($\eta_{coulumb}$, $k$, $n$, $a_n$) are tuned from repeated power draw $\leftrightarrow$ rest cycles with SOC-OCV resets baked in between the cycles
$$
SOC(t) = SOC(t_0) + \frac{\eta_{coulomb}}{Q_{max_{As}}} \int_{0}^{T}
[i^k + \sum_{0}^{n}(a_ni^n)]\ dt \times 100 \%
$$
- this method works for a particular power draw cycle



*Note: OCV measurement and EIS can be used to estimate SOCs for non-real-time applications*





### Model-based methods




