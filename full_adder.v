module full_adder(
	input a, b, cin,
	output sum, cout
);
	wire s1;
	wire c1, c2;

	// add 3 1-bit binary digits together into a 2-bit form
	half_adder ins0 (.a(a), .b(b), .cout(c1), .sum(s1));
	
	// second half adder takes in value from previous sum and also cin -> first digit
	half_adder ins1 (.a(s1), .b(cin), .cout(c2), .sum(sum));
	
	// 
	assign cout = c1 | c2;
	
endmodule