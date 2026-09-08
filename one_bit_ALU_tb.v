`timescale 1ns/1ps
// needs to be updated
module one_bit_ALU_tb;
	
	reg [0:0] a;
	reg [0:0] b;
	reg [0:0] cin;
	reg [1:0] operation;
	reg [0:0] a_invert;
	
	wire [0:0] result;
	wire [0:0] cout;
	reg [1:0] expected;
	

// instantiate module being tested

one_bit_ALU ins0 (
	.a(a),
	.b(b),
	.cin(cin),
	.operation(operation),
	.a_invert(a_invert),
	.result(result),
	.cout(cout)
	);
	
// initial values to be tested

initial begin
	a = 1'b0;
	b = 1'b0;
	cin = 1'b0;
	a_invert = 1'b0;
	operation = 2'b00;
end

integer i, j, k, l, m;
integer count;
integer errors;


// maybe i shouldn't put it all into one loop 

initial begin
	count = 0;
	errors = 0;
	for (i=0; i<4; i=i+1) begin // operator
		
		for (j=0; j<2; j=j+1) begin // cin
			
			for (k=0; k<2; k=k+1) begin // b
				
				for (l=0; l<2; l=l+1) begin // a
					for (m=0; m<2; m=m+1) begin // a_invert
					a = a + 1; // will overflow safely
					#10
						
						
							
						
						case (operation)
							2'b00: expected = a & b;
							2'b01: expected = a | b;
							2'b10: expected = a + b + cin;
							2'b11: expected = {cout, 1'b0};
							
						endcase
					
					// checker
					
					$display("test: input a: %b, input b: %b, input cin: %b, input op: %b, input a_inv: %b, got: %b, expected: %b", 
						a, b, cin, operation, a_invert, result, expected);
					$display("Counter: %b", count);
					if (expected != {cout,result}) begin // should be fine for and/or conditions too
						errors = errors + 1;
						
						$display("FAIL: input a: %b, input b: %b, input cin: %b, input op: %b, got: %b, expected: %b", 
						a, b, cin, operation, result, expected);
					end
					
					count = count + 1;
					
					
					if (count == 64) begin
						#10
						if (errors == 0) $display("Success");
						
						$stop;
						
					end
					
					end
				a_invert = a_invert + 1;
				end
			b = b + 1;
			end
		cin = cin + 1;
		end
	operation = operation + 1;
	end
end
		
endmodule


