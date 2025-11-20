
This project involved the design and verification of a **Memory Copier**, a specialized hardware unit that functions similarly to a Direct Memory Access (DMA) controller. The objective was to offload data transfer tasks from a central processor by autonomously reading data from a source address and writing it to a destination address in memory1.

The design emphasizes **Hierarchical Design** and **SystemVerilog Interfaces** to create modular, reusable, and clean Register Transfer Level (RTL) code.

## Technical Implementation

### 1. Architecture & Datapath

The system was designed with a clear separation between control and datapath logic, utilizing two primary submodules:

- **Flex Counter:** A parameterized counter used to track the number of bytes copied (`count_val`). It features a synchronous clear and is driven by the FSM during the write cycle2.
- **Data Register:** An 8-bit register that temporarily latches data read from the memory (`memif.rdata`) before writing it to the destination (`data_to_write`)3.

Address Calculation Logic:

To support burst copies, the address logic dynamically calculates pointers based on the current counter offset:

Code snippet

```
assign read_addr = src_addr + count_val;
assign write_addr = dst_addr + count_val;
```

### 2. Finite State Machine (FSM)

The control logic was implemented as a 4-state Moore Machine 4444444444444444 to orchestrate the handshaking signals (`ren`, `wen`, `ready`):

- **IDLE:** Resets the counter. Waits for the `start` signal. If `start` is asserted, it checks `copy_size` and transitions to **READ**.
- **READ:** Asserts `memif.ren` (Read Enable) and drives `memif.addr` with `read_addr`. It waits for `memif.ready` to latch data into the register and transition to **WRITE**.
- **WRITE:** Asserts `memif.wen` (Write Enable) and drives `memif.addr` with `write_addr`. Upon `memif.ready`, it increments the counter. It then checks if `count_val == copy_size - 1` to determine whether to loop back to **READ** or finish.
- **FINISH:** Asserts the `finished` signal and waits for `start` to de-assert before returning to **IDLE**5.

### 3. Verification Results

The design was verified using a dual-port memory testbench. The simulation terminal output confirms the successful completion of three distinct test scenarios666666666:

|**Test Case**|**Operation**|**Source Addr**|**Dest Addr**|**Result**|
|---|---|---|---|---|
|**Test 1**|Copy 5 bytes|`0x40`|`0x42`|**PASSED**|
|**Test 2**|Copy 8 bytes|`0x10`|`0x70`|**PASSED**|
|**Test 3**|Copy 10 bytes|`0x00`|`0x10`|**PASSED**|

## Gallery

### Top-Level Block Diagram

The top-level black box view showing the Memory Copier interface with start, copy_size, and memory address inputs. 7777

### RTL Schematic

A detailed view of the internal architecture, showing the interconnections between the Memory Copier control block, the Register (data storage), and the Flex Counter (address offset tracking). 8888

---

## Challenges & Solutions

### 1. Off-by-One Error in Counter Logic

**The Challenge:**

A common pitfall in designing controllers with counters is the mismatch between 0-based indexing (used by the hardware counter and memory addresses) and 1-based counting (used by the copy_size input). If the FSM simply checked if (count_val == copy_size), the system would attempt to copy one extra byte, potentially overwriting adjacent memory or causing a hang if the memory interface didn't expect the extra request.

**The Solution:**

I implemented a precise check in the WRITE state that compares the current counter value against copy_size - 1. This ensures the FSM transitions to FINISH exactly after the last valid byte is written.

**Code Snippet:**

```
// Inside WRITE state
if (memif.ready) begin
    count_en = 1'b1; // Increment counter

    // Check against size - 1 to handle 0-based indexing
    if (count_val == copy_size - 1) begin
        next_state = FINISH;
    end else begin
        next_state = READ;
    end
end
```

### 2. Handling "Single Byte" Corner Cases

**The Challenge:**

Standard logic often fails when the loop condition is met on the very first iteration (e.g., copy_size = 1). If the logic assumes a "loop back" structure, it might miss the exit condition for a single-byte copy.

**The Solution:**

By placing the completion check (count_val == copy_size - 1) immediately after the write handshake in the WRITE state, the FSM correctly identifies that the job is done even on the first pass. This was verified by Test Case 3, which successfully copied a small payload without hanging 2.
