This project focused on the practical application of the NE555 timer IC to design analog control circuits. The goal was to engineer precise timing networks for both **Monostable** (One-Shot) and **Astable** (Oscillator) operations, culminating in a dual-timer application that simulates the alternating flash pattern of railroad crossing signals.

## 1. Circuit Design & Theory
The core of the design relied on manipulating the 555 timer's internal voltage divider and comparator network, which triggers state changes at 1/3 Vcc and 2/3 Vcc.

### Monostable Mode (One-Shot)
In this configuration, the timer acts as a triggered pulse generator. The output remains low until a negative trigger pulse drops below 1/3 Vcc, setting the internal flip-flop. The output pulse width (*T_high*) is determined by the charging time of an external RC network.

* **Design Target:** *T_high* = 3.0s
* **Calculated Components:** To achieve this, I derived a resistance of 27.27kΩ paired with a 100μF capacitor. Since 27.27kΩ is a non-standard value, I synthesized it by placing a 22kΩ and 5kΩ resistor in series to minimize tolerance error.


> **Figure 1:** Circuit schematic for the Monostable implementation.

### Astable Mode (PWM Generator)
Here, the timer operates as a free-running oscillator. The capacitor charges through two resistors (*Ra + Rb*) and discharges through *Rb*, creating a continuous square wave.

* **Duty Cycle Control:** By adjusting the ratio of *Ra* to *Rb*, I successfully targeted specific Duty Cycles (60% and 75%) to demonstrate Pulse Width Modulation (PWM) capabilities.


> **Figure 2:** Circuit schematic for the Astable Timer designed for 60% Duty Cycle.

---

## 2. Implementation & Oscilloscope Analysis
The circuits were built physically on a breadboard and verified using a Keysight oscilloscope to capture the real-time voltage characteristics of the timing capacitor (*Vc*) and the output pin (*Vout*).

### Waveform Verification
The oscilloscope traces revealed the classic "shark fin" charging curve of the capacitor. In Astable mode, the capacitor voltage bounced precisely between the trigger and threshold limits, confirming the internal comparators were functioning correctly.


> **Figure 3:** Oscilloscope capture showing the 3s output pulse (Yellow) and Capacitor Charge Curve (Green).

### Dual-Timer Application
The final system integrated two parallel astable circuits operating out of phase to drive alternating LED arrays.

* **Performance:** The flashing cycle was measured at **248ms**, deviating 11.29% from the theoretical 220ms target.
* **Visual Output:** The scope captured the alternating high/low states of the two timers, validating that when Timer A drove its LED high, Timer B was low, creating the desired "wig-wag" effect.


> **Figure 4:** Oscilloscope capture of the Dual-Timer signals operating out of phase.

---

## 3. Error Analysis & Optimization
While the single-timer circuits were highly accurate (2.9% error for the monostable design), the dual-timer application showed higher variance.

* **Tolerance Stacking:** The discrepancy was largely attributed to the tolerance stacking of multiple electrolytic capacitors (20% tolerance) and carbon-film resistors (5% tolerance).
* **Non-Standard Values:** The reliance on series-combined resistors to match theoretical calculations introduced additional contact resistance and tolerance variables.
* **Future Improvement:** Transitioning to **CMOS-based 555 timers** (like the LMC555) would significantly reduce internal propagation delays and threshold variances compared to the bipolar NE555 used in this lab.