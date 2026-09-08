module ALU_chained (
	input [31:0] a,
	input [31:0] b, 
	input [0:0] cin,
	input [2:0] operation,
	input [0:0] a_invert,
	
	output [31:0] result,
	output [0:0] cout,
	output [0:0] zero // used for nor -> beq
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
			.a_invert(a_invert),
			.b_negate(cin[0]),
			.base_op(operation),
			.less(i==0 ? result[31] : 1'b0), // for SLT, to change first bit to signed bit of 31st bit, one instance one driver only
			.result(result[i]),
			.cout(arth_cout[i+1])
			);
			
	end
endgenerate

assign cout = arth_cout[32];
assign zero = ~(|result);

endmodule
