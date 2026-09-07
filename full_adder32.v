// this file should be deleted

module full_adder32 (
	input [31:0] a,
	input [31:0] b, 
	input [0:0] cin,
	output [31:0] sum,
	output [0:0] cout
	);
	
	wire [32:0] carry; // outputs of the carry
	assign carry[0] = cin;
	assign cout = carry[31];
	

	
	genvar i;
	
	generate
		// system verilog vs verilog 2001
		// think about the propagation delay and LUT here
		// critical path -> 32 full adders
		for (i=0; i<32; i = i+1) begin : full_adder_block // label? -> full_adder32.full_adder_block[i] to index
			full_adder ins0 (
			.a(a[i]),
			.b(b[i]),
			.cin(carry[i]),
			.sum(sum[i]),
			.cout(carry[i+1]));
	
		end
	endgenerate
	
endmodule