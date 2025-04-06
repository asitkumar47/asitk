# Introduction
Filters play a significant role in signal processing, noise reduction, and state estimation. A filter takes in an input $x(t)$ and produces a desired output $y(t)$ often with attenuating undesired components like noise, certain frequencies, etc... Filters can be classified as
- linear vs. nonlinear
- time-invariant vs. time-variant
- causal vs. non-causal
- analog vs. digital
- active vs. passive
****
# LTI filters
Linear time-invariant filters can be represented as transfer functions, impulse response, or state space format. The most common representation is a transfer function.
Common types of LTI filters are
- low pass
- high pass
- band (notch) pass

# Metrics to evaluate a filter
1. Frequency response metrics
	  - magnitude response
	  - phase response
	  - delay
2. Time domain metrics
	  - step response
	  - impulse response
3. Bandwidth characteristics
	  - roll-off rate (filter order)
	  - transition width
4. stopband, passband characteristics
	  - stopband attenuation
	  - passband ripple
	  - stopband ripple
 5. stability and causality

## Frequency response
Both magnitude and phase response are given by a ```bode``` plot.

### Magnitude response
1. describes how the filter attenuates / amplifies different frequency components
2. this is typically measured in decibels (dB)   
$$
|H(jw)|_{dB} = log_{10}|H(jw)|
$$

3. metrics used
	  - passband gain
	  - stopband attenuation
	  - cut-off frequency

### Phase response
This defines the phase shift at different frequencies

## Bandwidth characteristics
Bandwidth refers to the range of frequencies a filter allows to pass through or attenuate. Bandwidth can mean slightly different for the type of filter.
- low pass filter: bandwidth refers to the cut-off frequency $\omega_c$ (beyond which the gain (magnitude response) drops by -3dB)
- high pass filter: bandwidth defined from the cut-off frequency $\omega_c$ to infinity
- band-stop (notch) filter: bandwidth is the range of frequencies that are attenuated

### Roll-off rate
This is the rate at which the filter transitions from the passband (frequency passed through) to the stopband  
This is given in dB/decade (1 decade is an order of magnitude of frequency)  
- **An $n^{th}$ order filter has a roll-off rate of $20 \times N\ dB/decade$**
- **An $n^{th}$ order has an equivalent delay of $n-1$ time steps**

A second-order filter is common as it provides a high enough roll-off, but it adds one time-step delay. Why $\rightarrow$  
In the time domain, a second-order filter has two integrators, which means it need two past values to produce an output, hence one time-step transport delay


****
# Active vs. passive filters
Passive filters use passive components like R, L, and C. Active filters, in addition to R, L, and C, contain active components like transistor and opAmps.

