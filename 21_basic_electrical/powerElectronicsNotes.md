# Contents
1. Basic converters
	1. buck
	2. boost
2. Sizing the components of the above converters
3. Control of converters
4. Switch details
5. Losses
	1. switching losses
	2. resistive (conduction) losses
6. Thermal modeling

****
# Basic converters
1. Buck converter
2. boost converter

# Switch details
## Types of switches
- MOSFET - metal oxide semiconductor field effect transistor
- IGBT - insulated-gate bipolar transistor
- BJT - bipolar junction transistor
- GaNFET - Gallium nitride field effect transistor
- SiC MOSFET - Silicon carbide MOSFET 

| Operation type                     | Switch                        | Remarks                    |
| ---------------------------------- | ----------------------------- | -------------------------- |
| Unidirectional voltage and current | Diode                         | passive switch             |
|                                    | MOSFET                        | active, voltage controlled |
|                                    | IGBT                          |                            |
|                                    | BJT                           | active, current controlled |
| Bi-voltage, uni-current            | MOSFET with body diode        |                            |
|                                    | IGBT with anti-parallel diode |                            |
| Bi-current, uni-voltage            |                               |                            |
| bi-voltage, bi-current             |                               |                            |

## General comparison
- MOSFET best choice as long as voltage < 400V and total power < 10 kW
- IGBT best choice for high voltage and high power applications, when switching < 20kHz will be enough
- **The limitations of MOSFETs (medium voltage and power) is overcome by SiC MOSFETs (not Si)**
	- Tesla cars used to have IGBTs as MOSFETs couldn't handle high power applications
	- but now Tesla has moved to SiC MOSFETs
- Why MOSFET at *lower* vs. IGBT at *higher* voltage?
	- MOSFET's ON state looks like a resistor (higher the voltage, higher the forward-drop)
	- IGBT's ON state looks like a constant drop (forward-drop independent of voltage)

|**Feature**|**BJT**|**MOSFET**|**IGBT**|
|---|---|---|---|
|Control Type|Current-Controlled|Voltage-Controlled|Voltage-Controlled|
|Switching Speed|Slow|Very Fast|Moderate|
|Voltage Range|Low to Medium|Low to Medium (< 400V)|Medium to High (> 400V)|
|Power Handling|High|Medium (< 10kW)|High|
|Efficiency at High Frequency|Poor|Excellent|Moderate|
|Common Applications|Legacy power electronics, amplifiers|SMPS, DC-DC converters, RF, EV chargers|Motor drives, industrial inverters, high-power circuits|

## Heat generation comparison

| Parameter                | BJT (Worst) 🔥🔥🔥                   | MOSFET ❄                                | IGBT  🔥                                    |
| ------------------------ | ------------------------------------ | --------------------------------------- | ------------------------------------------- |
| Low Voltage (<400V)      | High Heat (High V<sub>CE(sat)</sub>) | Low Heat (Low R<sub>DS(on)</sub>)       | High Heat                                   |
| High Voltage (>400V)     | Extremely High Heat                  | Moderate Heat (High R<sub>DS(on)</sub>) | Low Heat                                    |
| High Frequency (>20 kHz) | Very High Heat (Switching losses)    | Very Low Heat (Fast switching)          | Moderate to High Heat                       |
| Low Frequency (<1 kHz)   | Moderate Heat                        | Very Low Heat                           | Low Heat (Best for high-power applications) |


## Relatively new
1. SiC MOSFET
2. GaN FET ($f_{sw} > 100 kHz$)

****


