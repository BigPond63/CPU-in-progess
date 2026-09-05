module ALU (
	input wire clk,
	input [31:0] a, // rs1
	input [31:0] b, // rs2
	input [0:0] cin, // also dooubles as Binvert signal
	input [2:0] operation,
	input [0:0] Ainvert,
	output reg [31:0] result,
	output reg [0:0] less

);
	wire [31:0] arth_result;
	wire [0:0] arth_cout;
	
	reg [31:0] arth_b;
	reg [31:0] arth_a;
	
	// ripple carry adder of size 32
	full_adder32 ins0 (
		.a(arth_a),
		.b(arth_b),
		.cin(cin),
		.sum(arth_result),
		.cout(arth_cout)
	);
	
	// subtraction: invert all bits and add 1. (two's complement)
	// need control signal for cin (indicate that it is subtraction)
	// why do we choose cin?
		// cin is not actually needed in addition, it is for the lsb and that doesn't actually use the cin symbol
		
	assign operation = operation + less;
	always @(*) begin
		case (cin)
			1'b0: arth_b = b; // no change if no cin signal -> no + or -
			1'b1: arth_b = (~b); // the two's complement is already supplied in cin (+1)
			
		endcase
		
		case (Ainvert)
			1'b0: arth_a = a;
			1'b1: arth_a = (~a);
		
		endcase
		
	end
	
	
	

	
	always @(*) begin
		case (operation) 
			// won't the extra 33rd bit be cut off in normal program executions
			3'b000: result = {1'b0, arth_a & arth_b}; // nor here
			3'b001: result = {1'b0, arth_a | arth_b}; // nand, both utilise demorgan's law
			3'b010: result = {arth_cout, arth_result};
			3'b011: result = {31'b0, arth_cout};
		
		endcase
	
	end
	



endmodule