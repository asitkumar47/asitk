# ECM model
## Schematic

![[ECM.svg]]

$E_0 \rightarrow open\ circuit\ voltage\ (V)$
$V_t \rightarrow terminal\ voltage\ (V) \leftarrow output\ of\ the\ model$
$i \rightarrow current\ draw\ (A) \leftarrow input\ to\ the\ model$
$r_n, c_n \rightarrow resistance\ and\ capacitances\ (\ohm, F)$

## Equations
### Model equations
$$V_t=E_0-\sum_{1\rightarrow n}V_{c_n}-ir_0$$
$$\frac{dV_{c_n}}{dt}=\frac{i}{c_n}-\frac{V_{c_n}}{r_nc_n}$$
$$\frac{soc}{dt}=\frac{-i}{Q_{Ah}\times 3600}$$

### Post-processing equations
$$P_{heat}=i^2r_0 + \sum_{1\rightarrow n}\frac{V_{c_n}^2}{r_n}$$

