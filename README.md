# Engineering Portfolio

**Hadi Althawab**
*Computer Engineering Student @ Purdue University*

## Overview
This repository documents my engineering projects :)

These projects demonstrate a progression from discrete analog components to complex SystemVerilog architectures and hardware-software co-design. My focus lies in bridging the gap between high-level software algorithms and low-level hardware implementation.

---

## 🛠 Skills Matrix

| Domain | Languages & Technologies | Tools & Hardware |
| :--- | :--- | :--- |
| **Digital Design (RTL)** | SystemVerilog, RISC-V Assembly (RV32I), C | Verilator, Yosys, GTKWave, Logic.ly, FreePDK45 |
| **Embedded Systems** | C/C++, Arduino, QMK Firmware | RP2040 (Pico), ATMega328P, PCA9685 Drivers |
| **Analog Electronics** | Circuit Analysis, Signal Processing | 555 Timers, Op-Amps (LT1721), Oscilloscope Analysis |
| **Fabrication** | G-Code, Marlin Firmware, CAD | 3D Printing, Soldering, Mechanical Assembly |

---

## 📂 Project Directory

### 1. Digital Design & Computer Architecture
*Located in: [`./Digital-Design-RTL/`](./Digital-Design-RTL)*

* **[RISC-V Hardware Accelerator & Security](./Digital-Design-RTL/RISCV-SoC-Accelerator)**
    * **Objective:** Designed a hardware-software co-design system to mitigate timing side-channel attacks on an AFTx07 SoC.
    * **Key Tech:** RISC-V Assembly, MMIO, SystemVerilog, FSM.
    * **Outcome:** Optimized assembly for constant-time execution (variance reduced from ~2400 to 23 cycles) and offloaded population count operations to custom hardware.

* **[DMA Controller (Memory Copier)](./Digital-Design-RTL/Memory-Copier-DMA)**
    * **Objective:** Implemented a specialized hardware unit to offload memory transfer tasks from a central processor.
    * **Key Tech:** Hierarchical Design, Moore FSM, Verification Testbenches.
    * **Outcome:** Validated support for burst copies and corner cases (single-byte transfers) using dual-port memory testbenches.

* **[FSM Logic Synthesis & Verification](./Digital-Design-RTL/FSM-Logic-Synthesis)**
    * **Objective:** Designed a "Divide-by-5" serial processor and synthesized it to the FreePDK45 Standard Cell Library.
    * **Key Tech:** Yosys, Standard Cell Libraries, Automated Test Vectors.

* **[Fundamental Digital Logic](./Digital-Design-RTL/System-Verilog-Basics)**
    * **Objective:** Implementation of Ripple Carry Adders and Binary Counters using SystemVerilog and Logic.ly.

### 2. Embedded Systems & Robotics
*Located in: [`./Embedded-Systems-Robotics/`](./Embedded-Systems-Robotics)*

* **[6DOF Robotic Arm Control](./Embedded-Systems-Robotics/6DOF-Robotic-Arm)**
    * **Objective:** A complete mechanical and electronic rework of a deprecated robotic arm design.
    * **Key Tech:** Arduino, PCA9685 Servo Drivers, Inverse Kinematics.
    * **Outcome:** Achieved stable, coordinated motion of 9+ motors using dual joystick inputs.

* **[Handwired Split Ergonomic Keyboard](./Embedded-Systems-Robotics/Handwired-Keyboard)**
    * **Objective:** Fabrication of a Dactyl Manuform keyboard with a custom scanning matrix.
    * **Key Tech:** RP2040 Microcontroller, QMK Firmware, Matrix Scanning.

* **[Pedestrian Safety System](./Embedded-Systems-Robotics/Pedestrian-Safety-System)**
    * **Objective:** Designed a motion-sensing alert system to prevent collisions between cyclists and pedestrians at Purdue.
    * **Key Tech:** Ultrasonic Sensors, Arduino, LED Logic.

### 3. Mechanical Fabrication & Sustainability
*Located in: [`./Mechanical-Fabrication/`](./Mechanical-Fabrication)*

* **[Closed-Loop Plastic Recycler](./Mechanical-Fabrication/Plastic-Filament-Recycler)**
    * **Objective:** Converted an Ender 3 3D printer into a plastic filament extrusion machine to support sustainable prototyping.
    * **Key Tech:** Additive Manufacturing, Circular Economy Design.

* **[3D Printer Rebuild & Automation](./Mechanical-Fabrication/3D-Printer-Rebuild)**
    * **Objective:** Upgraded a printer with auto-leveling, direct drive extrusion, and AI failure detection.
    * **Key Tech:** Marlin Firmware Compilation, G-Code Streaming, AI Monitoring.

### 4. Analog Electronics
*Located in: [`./Analog-Electronics/`](./Analog-Electronics)*

* **[555 Timer Applications](./Analog-Electronics/555-Timer-Circuits)**
    * **Objective:** Designed and verified Monostable (One-Shot) and Astable (PWM) circuits simulating railroad signals.
    * **Key Tech:** Analog timing networks, Duty Cycle control.

* **[Op-Amp Characteristics](./Analog-Electronics/OpAmp-Characteristics)**
    * **Objective:** Analyzed saturation, slew rate, and bandwidth limitations of LT1721 Op-Amps and LTC6702 Comparators.

---

## 📬 Contact
* **Email:** halthawa@purdue.edu
* **LinkedIn:** www.linkedin.com/in/halthawab
