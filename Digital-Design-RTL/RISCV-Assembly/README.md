
This project focused on low-level system optimization and hardware-software co-design using the **AFTx07 SoC** (System on Chip). The primary objective was to implement specific algorithms in **RISC-V assembly** to understand the trade-offs between execution speed and security (timing side-channels), followed by designing a hardware accelerator to offload these tasks.

## Tools & Technologies

- **ISA:** RISC-V (RV32I) 2
- **Simulation:** Verilator & AFTx07 SoC 3
- **Build System:** CMake, Make, GCC Toolchain 4
- **Concepts:** Application Binary Interface (ABI), Memory-Mapped I/O (MMIO), Side-Channel Attacks
## Key Implementations

### 1. System Configuration & Linker Scripting

To run the simulation on the AFT-dev hardware, I modified the system linker script (`link.ld`). This involved defining the memory map to ensure the software loaded correctly into the SoC's RAM.

- **Configuration:** Set RAM Origin to `0x8400` with a length of `8K` to match the AFTx07 memory specifications.
### 2. Assembly Algorithm Design: Population Count (POPCNT)

I developed two distinct assembly implementations of the "Population Count" algorithm (counting the number of set bits in a 32-bit integer) to analyze architectural trade-offs.
#### A. "Early Exit" Optimization

This implementation utilized a conditional branch (`beqz`) to exit the loop immediately once the input register became zero.

- **Advantage:** Highly efficient for sparse inputs (e.g., `0x00000001` runs very fast).
- **Disadvantage:** Created a high **runtime variance**, as the execution time depended directly on the input data.

#### B. Timing-Safe Security Implementation

To mitigate **Timing Side-Channel Attacks**, I implemented a `popcnt_secure` routine.

- **Security Theory:** Attackers can deduce private data (like passwords) by measuring how long a function takes to execute.
- **Implementation:** I removed data-dependent branches, forcing the algorithm to iterate through all 32 bits regardless of the input value.
- **Result:** This reduced the runtime variance significantly (from ~2463 cycles down to ~23 cycles in my analysis), ensuring constant-time execution.

### 3. Hardware Accelerator Architecture (RTL)

To overcome the limitations of software execution, I designed the Register Transfer Level (RTL) architecture for a dedicated hardware peripheral.

- **Interface:** Designed a bus-based **Memory-Mapped I/O (MMIO)** interface.
- **Register Map:**
    - **Data Register:** For 32-bit input.
    - **Result Register:** Stores the bit count.
    - **Control Register:** Starts the operation (writing '1' starts it).
    - **Status Register:** Indicates busy/done status.
    
- **Logic:** The design utilizes a Finite State Machine (FSM) to manage the shifting and counting logic in hardware, allowing the CPU to offload this intensive task.

---

## Gallery

### Performance Benchmarks

Terminal output showing the variance analysis between the "Early Exit" and "Timing-Safe" assembly implementations.

### Accelerator RTL Diagram

Block diagram of the custom hardware peripheral designed to offload the POPCNT task via MMIO.

