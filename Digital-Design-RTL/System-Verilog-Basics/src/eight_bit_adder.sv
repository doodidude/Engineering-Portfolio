module eight_bit_adder(
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [8:0] c
);
    logic [6:0] carries;
genvar i; 
generate 
	for (i = 0; i < 8; i++) begin 
	if (i == 0) begin 
	full_adder u1 (.a(a[i]), .b(b[i]), .cin(1'b0), .s(c[i]), .cout(carries[i])); 
	end 
	else if (i < 7) begin 
	full_adder u2 (.a(a[i]), .b(b[i]), .cin(carries[i-1]), .s(c[i]), .cout(carries[i]));
	end 
	else begin 
	full_adder u3 (.a(a[i]), .b(b[i]), .cin(carries[i-1]), .s(c[i]), .cout(c[8]));
	end
	end
endgenerate
endmodule
