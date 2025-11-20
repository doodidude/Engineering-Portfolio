This project expanded on digital logic fundamentals by introducing Finite State Machines (FSMs) for serial data processing and the concept of Logic Synthesis. The primary objective was to design a "Divide-by-5" detector that processes a serial bit stream and asserts a signal whenever the accumulated binary value is divisible by 5. The design was verified using an advanced SystemVerilog testbench and then synthesized into a 45nm Standard Cell Library using Yosys.

## Tools & Technologies

- **Language:** SystemVerilog 
- **Simulation:** Verilator & GTKWave
- **Synthesis:** Yosys 
- **Cell Library:** FreePDK45 
- **Schematic Design:** Logic.ly / CircuitLab

## Key Implementations

### 1. Finite State Machine (Divide-by-5)

Designed a Moore machine to calculate the modulo-5 remainder of a serial input stream.

- **Logic:** The FSM tracks 5 states (`S0` to `S4`), representing the current remainder.
- **Transition:** Used the property `Next_Remainder = (Current_Remainder * 2 + Input_Bit) % 5`.
- **Optimization:** Used `typedef enum` for state definitions to ensure code readability and prevent "magic number" errors.

**Code Snippet: Next State Logic**

Code snippet

```
// State definition
typedef enum logic [2:0] {
    S0, S1, S2, S3, S4
} state_t;

// Combinational Next-State Logic
always_comb begin
    case (state)
        S0: next = data ? S1 : S0;
        S1: next = data ? S3 : S2;
        S2: next = data ? S0 : S4;
        S3: next = data ? S2 : S1;
        S4: next = data ? S4 : S3;
        default: next = S0;
    endcase
end

// Output Logic: Accept only when remainder is 0 (S0)
assign accept = (state == S0);
```

### 2. Advanced Verification (Testbench)

Moving beyond simple loops, this lab utilized **SystemVerilog structs** and **tasks** to create a modular and scalable test environment.

- **Data Structures:** Implemented a `TestVector` struct to bundle input streams with their expected results.
- **Tasks:** Created `send_stream` to automate bit-shifting and clock pulsing, allowing for rapid testing of complex vectors.
- **Coverage:** Verified corner cases (0, 255, etc.) and generated test vectors dynamically.

**Code Snippet: Stream Testing Task**

Code snippet

```
task send_stream(TestVector vec);
    begin
        current_test = vec.test_number;
        reset(); // Reset FSM before new stream

        // Loop through bits (MSB first)
        for (int i = 7; i >= 0; i--) begin
            send_bit(vec.data_stream[i]);
        end

        #(1); // Wait for logic to settle
        
        // Verify Output
        if (tb_accept != vec.expected_output) begin
            $display("[FAILED] Test %d failed on input %d. Expected %b, got %b", 
                     vec.test_number, vec.data_stream, vec.expected_output, tb_accept);
        end else begin
            $display("[PASSED] Test %d passed.", vec.test_number);
        end
    end
endtask
```

### 3. Logic Synthesis (Yosys & FreePDK45)

The design was synthesized from behavioral SystemVerilog into a gate-level netlist using the FreePDK45 library.

- **Area Analysis:** The synthesized design utilized 24 cells, with 3 D-Flip-Flops occupying ~43.8% of the total area.
- **Complex Gates:** Analyzed the tool's usage of optimization gates such as **OAI21** (OR-AND-Invert) and **AOI21**(AND-OR-Invert) 1 to reduce transistor count compared to standard AND/OR implementations.
- **Gate-Level Visualization:** Generated and inspected `post_syn.svg` to visualize the physical mapping of logic cones.

### 4. Hand Synthesis (Decoder)

Prior to automated synthesis, I manually designed a 2-to-4 Decoder circuit to understand the translation between HDL and Physical Gates.

- **Design:** Implemented using 2 D-Flip Flops (for address storage) and 4 AND gates for one-hot output decoding.
- **Schematic:** Created a clear gate-level diagram accounting for clock edges and asynchronous resets.