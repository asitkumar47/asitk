# Why use $I_{rms}$ for find power loss in AC circuits?
AC instantaneous current is given by 
$$ i(t) = I_{peak}sin(\omega t)$$

Instantaneous power is given by 
$$p(t) = i^2(t)R = I_{peak}^2sin^2(\omega t) R$$

Average power in one cycle
$$P_{avg} = \frac{1}{T} \int_{0}^{T}I_{peak}^2sin^2(\omega t)R\ dt = \frac{1}{2}I_{peak}^2R = I_{rms}^2R$$

with 
$$I_{rms} = \frac{I_{peak}}{\sqrt 2}$$

Comparing the expression for $P_{avvg}$ with DC power loss expression of $P_{loss} = i^2 r$ $I_{rms}$ represents the DC equivalent current for the same power dissipation in a resistor in an AC circuit.

Example usage - Total copper loss in the windings of a 3-phase motor's stators is given by $P_{Cu} = 3I_{rms}^2R_{winding}$