# Introduction
Filters play a significant role in signal processing, noise reduction, and state estimation. A filter takes in an input $x(t)$ and produces a desired output $y(t)$ often with attenuating undesired components like noise, certain frequencies, etc... Filters can be classified as
- linear vs. nonlinear
- time-invariant vs. time-variant
- causal vs. non-causal
- analog vs. digital

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
```math
|H(jw)|_{dB} = log_{10}|H(jw)|
```

3. metrics used
  - passband gain
  - stopband attenuation
  - cut-off frequency

### Phase response
This defines the phase shift at different frequencies

