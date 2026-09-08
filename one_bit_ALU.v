module one_bit_ALU (
	input [0:0] a,
	input [0:0] b,  
	input [0:0] cin, // b-invert for cin[0]
	input [0:0] a_invert,
	input [0:0] b_negate,
	input [1:0] base_op,
	input [0:0] less,
	
	output reg [0:0] result, // set if result[31]
	output reg [0:0] cout
	);
	
	wire [0:0] arth_cout;
	wire [0:0] arth_sum;
	reg [0:0] arth_a;
	reg [0:0] arth_b;
	
	
	full_adder ins0 (
		.a(arth_a),
		.b(arth_b),
		.cin(cin),
		.sum(arth_sum),
		.cout(arth_cout)
	);
	
	always @(*) begin
		
		arth_a = a_invert ? ~a : a;
	
		arth_b = b_negate ? ~b : b; // two's complement -> cin = 1 gives the +1
		
		
		// ALU control line = {a_invert, b_negate, base_op};
		// 0000 AND
		// 0001 OR
		// 0010 ADD
		// 0110 SUB
		// 0111 SLT
		// 1100 NOR
		case (base_op) 
			2'b00: result <= arth_a & arth_b; // and / NOR
			2'b01: result <= arth_a | arth_b; // or / NAND
			2'b10: result <= {arth_cout, arth_sum}; // add / sub -> cout will be truncated
			2'b11: result <= less; // signed bit -> 0's for 1-31 bit, 0/1 for bit 0.
		
		endcase
		
		cout <= arth_cout;
	end
	
	
	
	endmodule