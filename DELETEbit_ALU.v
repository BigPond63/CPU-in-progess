// this file should be deleted


module 32bit_ALU (
	input [31:0] a,
	input [31:0] b,
	input [0:0] cin,
	input [2:0] operation, 
	
	output reg [31:0] result
	);
	
	wire [31:0] arth_cout;
	assign arth_cout[0] = cin[0];
	
	
	// loop the ripple carry adder 32x to get the result for add/sub
	genvar i;
	for (i=0; i<32; i=i+1) begin: Label
		1bit_ALU ins0 (
			.a(a[i]),
			.b(b[i]),
			.cin(arth_cout[i]),
			.operation(operation),
			.result(result[i]),
			.cout(arth_cout[i+1])
		); // result will correspond to whatever operation it is asked to do
		
		
	
	end
	endgenerate
	
