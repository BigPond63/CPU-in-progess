module program_counter (
	input [4:0] increment,
	input wire clk
	
); 
	reg [4:0] cur_adrs;
	
	// increment to the next instructional address
	always @(posedge clk) begin
		assign cur_adrs = cur_adrs + increment; // next instruction 4 bytes away (usually)

	end
	
	// what to do with branch and loop and jumps?

endmodule