# Contents
This contains the notes for both the motor and inverter.
1. Motor
	1. Types of motors
	2. 
2. Inverter
	1. modulation strategy
	2. inverter topology
	3. control strategy
3. Other components
	1. DC-capacitor
	2. Switches
4. Modeling
	1. loss modelin
	2. thermal modeling
****
# Motor



****
# Inverter
![[inverterSchematic.png|400]]
Schematic of a two-level drive inverter
****

# DC capacitor
Reference - [DC_capacitor_sizing_paper.pdf](https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=9807220)
[googleDrive](https://drive.google.com/file/d/1MW1S8p4kbWLll2d0LCQThpAXMReQ3lCD/view?usp=drive_link)

## Why is it needed?
The DC link capacitor for a 3-phase inverter in an electric drive motor is critical for 
- smooth out voltage ripple from switching 
	- not stabilizing the variation from DC supply
- absorbing ripple currents
- supporting transient loads
## High-level notes
1. DC link capacitor is usually the bulkiest component of the inverter
2. it imposes a limit on power density of the converter (inverter)
	1. power density of the inverter has been greatly improved by
		1. the use of wide bandgap semiconductor devices like SiC MOSFETs and GaN HEMTs
		2. adoption of multi-level inverter topologies
	2. so the large size of DC-link capacitor is the most constraining one 
3. 

## Metrics of performance for DC-link capacitor
1. specific capacitance ($F/m^3$)
2. RMS current capability (low equivalent series (ESR) resistance and high thermal conductivity)
3. high self-resonance frequency (equivalent series inductance)
4. decreasing resistance with frequency $\uparrow$ (hence take adv. of higher frequency operation)
	1. higher frequency of switching $f_{sw}$? or higher electrical frequency $f_e$, i.e., high speed motor operation?


## Types of DC-link capacitors
![[dcLinkCapConstruction.png|400]]
Internal layers of a) film capacitors, b) ceramic capcitors

1. electrolytic
	1. high energy density
	2. other metrics - not so good
2. film-based
	1. prevalent in automotive applications
	2. pros:
		1. suited for high-temperature operation (100-125 degC)
		2. reliable (self-healing property)
	3. cons:
		1. ESR stays constant in the frequency range of 10-100 kHz
			1. beyond that $\text{ESR} \propto \sqrt f_{sw}$ due to AC skin effect
			2. so power loss and RMS current capacity remain constant or get worse with increase in frequency
		2. ESR stays constant with temperature
		3. low self-resonance (high equivalent series inductance) due to large physical size
		4. they self-heat and require thermal management
3. ceramic-based
	1. three types - class I (C0G), II (X7R), III (PLZT)
	2. the internal structure is usually multilayered 
	3. pros:
		1. ESR decreases with switching frequency $\rightarrow \text{ESR} \propto f_{sw}$
		2. ESR decreases with temperature (class III)
			1. even if ESR decreases with temperature, the capacitance also reduces (higher current)
			2. this provides a natural balancing effect and avoids thermal run away
			3. since, resistance decreases and current increases, heat generation doesn't necessarily decrease
			4. but it is still better than film-capacitors at very high $f_{sw}$ as its ESR stays constant with temperature, but increases with frequency $\text{ESR} \propto \sqrt{f_{sw}}$
		3. in general, higher specific RMS current capacity compared to film capacitors
			1. $I_{RMS} \propto f_{sw}$
		4. low equivalent series inductance
	4. cons:
		1. class II ceramic caps are prone to crack with vibrations
		2. class II ceramic caps have reduced capacitance with increasing DC voltage and temperature

![[filmVsCeramicPropertyComparison.png|400]]
ESR dependence on switching frequency and capacitor temperature for film-capacitors (a, c) and ceramic-capacitors (b, d)

****



