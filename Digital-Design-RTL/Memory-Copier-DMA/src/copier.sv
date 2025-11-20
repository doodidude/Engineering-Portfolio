
module copier (
    input CLK,
    input nRST,
    input logic [7:0] src_addr,
    input logic [7:0] dst_addr,
    input logic [7:0] copy_size,
    input logic start,
    output logic finished,
    memory_if.request memif
);

    typedef enum logic [1:0] {
        IDLE,
        READ,
        WRITE,
        FINISH
    } State;

    State current_state, next_state;

    // Internal signals
    logic read_data_reg_we;
    logic count_en;
    logic count_clear;
    logic [7:0] read_addr;
    logic [7:0] write_addr;
    logic [7:0] count_val;
    logic [7:0] data_to_write;
    logic count_rollover;

    // State machine sequential logic
    always_ff @(posedge CLK or negedge nRST) begin
        if (!nRST) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // State machine combinational logic
    always_comb begin
        // Default values for all outputs
        next_state = current_state;
        memif.ren = 1'b0;
        memif.wen = 1'b0;
        memif.addr = '0;
        memif.wdata = '0;
        finished = 1'b0;
        read_data_reg_we = 1'b0;
        count_en = 1'b0;
        count_clear = 1'b0;

        // Address generation
        read_addr = src_addr + count_val;
        write_addr = dst_addr + count_val;

        case (current_state)
            IDLE: begin
                count_clear = 1'b1;
                if (start) begin
                    if (copy_size == 0) begin
                        next_state = FINISH;
                    end else begin
                        next_state = READ;
                    end
                end
            end

            READ: begin
                memif.ren = 1'b1;
                memif.addr = read_addr;

                if (memif.ready) begin
                    read_data_reg_we = 1'b1;
                    next_state = WRITE;
                end
            end

            WRITE: begin
                memif.wen = 1'b1;
                memif.addr = write_addr;
                memif.wdata = data_to_write;

                if (memif.ready) begin
                    count_en = 1'b1;

                    if (count_val == copy_size - 1) begin
                        next_state = FINISH;
                    end else begin
                        next_state = READ;
                    end
                end
            end

            FINISH: begin
                finished = 1'b1;
                count_clear = 1'b1;
                if (!start) begin
                    next_state = IDLE;
                end
            end
            
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    data_register d_reg (
        .CLK(CLK),
        .nRST(nRST),
        .WEN(read_data_reg_we),
        .wdata(memif.rdata),
        .data(data_to_write)
    );

    flex_counter #(.NUM_CNT_BITS(8)) f_counter (
        .clk(CLK),
        .n_rst(nRST),
        .clear(count_clear),
        .rollover_val(copy_size - 1),
        .count_enable(count_en),
        .count_out(count_val),
        .rollover_flag(count_rollover)
    );

endmodule
