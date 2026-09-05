module register_file (
	input wire clk,
	input [4:0] rs1, // location
	input [4:0] rs2, // location
	input [4:0] rd, // destination
	input [31:0] write,
	input [0:0] regWrite, // y/n to write, control operation
	output [31:0] rd_out1,
	output [31:0] rd_out2
);

reg [31:0] register [0:31]; // values


		// register read
assign rd_out1 = register[rs1]; // rd_out1 should give value in that register
assign rd_out2 = register[rs2]; // rd_out2 give value in register
		
	
	// register write
	always @(posedge clk) begin
		if (regWrite==1 && rd!=5'd0) begin
			register[rd] <= write;
		end
	
	end
	

endmodule