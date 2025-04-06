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
5. 

## Types of DC-link capacitors
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
		2. beyond that $\text{ESR} \propto \sqrt f_{sw}$ due to AC skin effect
		3. so power loss and RMS current capacity remain constant or get worse with increase in frequency
		4. low self-resonance (high equivalent series inductance) due to large physical size
3. ceramic-based
****



