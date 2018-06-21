`timescale 1ns/1ps

module tb;

reg					clk;

initial clk=0;
always #5 clk=~clk;

parameter n_A = 8;
parameter n_B = 8;
parameter n_OUTPUT = 16;


reg			enable;
reg	[n_A-1:0]	data_inA;
reg 	[n_B-1:0]	data_inB;
reg			reset;

wire	[n_OUTPUT-1:0]	data_out;

target u_target (
	.enable (enable),
	.A (data_inA),
	.B (data_inB),
	.OUTPUT (data_out),
	.reset (reset),
	.clk (clk)
);

reg		[31:0]		sim_cycle;

initial begin
	$vcdplusfile("sim.vpd");
	$vcdpluson;

	reset = 1'b0;

	@(posedge clk);
	reset = 1'b1;

	@(posedge clk);
	@(posedge clk);
	sim_cycle = 0;
	reset = 1'b0;

	while (sim_cycle<20) begin
		@(posedge clk);
		#1;
		case (sim_cycle)
			0: begin
				enable = 1'b1;
				data_inA = 8'b0010;
				data_inB = 8'b1010;
			end


			1: begin
				enable = 1'b1;
				data_inA = 8'b10010;
				data_inB = 8'b01010;
			end

			2: begin
				enable = 1'b1;
				data_inA = 8'b0111;
				data_inB = 8'b1111;
			end

			3: begin
				enable = 1'b1;
				data_inA = 8'b10000010;
				data_inB = 8'b11001010;
			end

			default: begin
				enable = 1'b0;
				data_inA = {(n_A){1'b0}};
				data_inB = {(n_B){1'b0}};
			end
		endcase

		#7;
		$display ("%d: data_out='h%h", sim_cycle, data_out);

		sim_cycle = sim_cycle+1;
	end

	$finish(1);
end

endmodule




