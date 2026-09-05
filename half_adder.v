module half_adder (
	input [0:0] a,
	input [0:0] b,
	output [0:0] cout,
	output [0:0] sum
	
);
	// carry (upper bit)
	assign cout = a & b;
	
	// sum (lower bit)
	// assign sum = ( (~A) & B ) + ( A & (~B) );
	assign sum = a ^ b;

endmodule
	