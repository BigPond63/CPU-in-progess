module ALU_chained (
	input [31:0] a,
	input [31:0] b, 
	input [0:0] cin,
	input [2:0] operation,
	input [0:0] a_invert,
	
	output [31:0] result,
	output [0:0] cout
);

wire [32:0] arth_cout;

assign arth_cout[0] = cin[0];

genvar i;
generate
	for (i=0; i<32; i = i+1) begin: label
		one_bit_ALU ins0 (
			.a(a[i]),
			.b(b[i]),
			.cin(arth_cout[i]),
			.operation(operation),
			.a_invert(a_invert),
			.b_invert(cin[0]),
			.less(1'b0),
			.result(result[i]),
			.cout(arth_cout[i+1])
			);
			
		if (i == 31) begin // for SLT, to change first bit to signed bit of 31st bit
			one_bit_ALU ins1 (
				.a(a[0]),
				.b(b[0]),
				.cin(arth_cout[0]),
				.operation(operation),
				.a_invert(a_invert),
				.b_invert(cin[0]),
				.less(result[31]),
				.result(result[0]),
				.cout(arth_cout[1])
				);
		end
	end
endgenerate

assign cout = arth_cout[32];

endmodule
