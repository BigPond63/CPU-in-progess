module one_bit_ALU (
	input [0:0] a,
	input [0:0] b,  
	input [0:0] cin, // b-invert
	input [1:0] operation,
	
	output reg [0:0] result,
	output reg [0:0] cout
	);
	
	wire [0:0] arth_cout;
	wire [0:0] arth_sum;
	
	full_adder ins0 (
		.a(a),
		.b(b),
		.cin(cin),
		.sum(arth_sum),
		.cout(arth_cout)
	);
	
	always @(*) begin
		case (operation) 
			2'b00: result = a & b;
			2'b01: result = a | b;
			2'b10: result = {arth_cout, arth_sum}; // cout will be truncated
			2'b11: result = 1'b0; // dummy logic here for now
	
	
		endcase
	end
	
	endmodule