## 1. Task 8.10: AC vs DC Input to an Op-Amp

The objective was to compare the behavior and limitations of an Op-Amp (LT1721) when subjected to DC and AC input signals.

---
### Circuit and Theory

The circuit used **decoupling capacitors** ($C1$, $C2$, $0.1\mu F$) connected between the power rails ($V^+$, $V^-$) and ground near the Op-Amp, a standard practice to reduce noise and stabilize operation.

### Key Findings

- **DC Input Saturation:** At lower input voltages, the experimental gain closely matched the calculated gain. However, as the input voltage approached the power rail voltage (5V), the percentage error increased significantly (e.g., up to 52.39% at 5V input). This is because the Op-Amp cannot output a voltage higher than the supply voltage ($V^+$ or $V^-$). 

- **AC Input Limitations:** Similar voltage cutoff behavior was observed with AC inputs; the Op-Amp struggles to supply voltage beyond its internal supply rails.

- **Internal Voltage Drop:** In all cases, the Op-Amp consumed some voltage internally, meaning the theoretical maximum output was never achieved (i.e., the output saturated slightly below the rail voltage).

---
## 2. Task 8.11: The Adjustable Gain Amplifier

The objective was to build and test an adjustable gain amplifier using an Op-Amp and a potentiometer.

---
### Circuit and Application

The circuit used **potentiometers** to create voltage dividers, allowing the user to construct an amplifier with manually adjustable **gain**. The output was connected to a speaker to demonstrate a real-world application: **volume control**.

### Key Findings

- **Gain Adjustment:** As the potentiometer was turned, the **volume increased** due to the higher gain amplifying the input signal. 
- **Saturation at High Gain:** At the extreme setting (**maximum gain**), the speaker went **silent**. This occurred because the output sine wave was **clipped (saturated)** at the power rails, distorting the signal beyond the speaker's usable range. 
    
- **Output Waveforms:** Oscilloscope traces visually confirmed the gain adjustment from unity gain to medium gain and finally to maximum gain.


---
## 3. Task 8.12: Characteristics of Op-Amps and Comparators

The objective was to understand the characteristics of Comparators (LTC6702) and compare their behavior to Op-Amps, particularly in response to external pull-up resistors.

---
### Pull-Up Resistor Effect

- **Function:** A **pull-up resistor** allows the comparator to actively **pull the output up to the full $V^+$ supply voltage** (e.g., 5V). This is useful when the comparator itself cannot drive the output high, or when a strong logic-high signal is required. 
    
- **Unexpected Effect:** Initially, the pull-up resistor caused the output to stay either constantly low or constantly high, suppressing the normal switching effect.
    
### Op-Amp vs. Comparator

The lab demonstrated a key difference in speed and output capability between the two IC types:

- **Slew Rate:** The **slew rate** (the maximum rate of voltage change per unit of time) of the Op-Amp was observed to be **lower than the comparator**.
    
- **Output Response:** The comparator's **higher slew rate** allows circuits to switch following a condition quickly, allowing the Op-Amp to respond shortly after.
    
- **Frequency Limit:** When tested at high frequencies, the Op-Amp struggled to keep up with the alternating input, failing to constantly switch its output between $V^+$ and $V^-$. This highlights that Op-Amps have **bandwidth limitations** not typically shared by dedicated Comparators.