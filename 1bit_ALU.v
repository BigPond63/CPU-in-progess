module 1bit_ALU (
	input [0:0] a,
	input [0:0] b,  
	input [0:0] cin, // b-invert
	input [2:0] operation,
	
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
			3'b000: result = a & b;
			3'b001: result = a | b;
			3'b010: result = {arth_cout, arth_sum}; // cout will be truncated
	
	
		endcase
	end
	
	endmodule