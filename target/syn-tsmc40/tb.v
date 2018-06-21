`timescale 1ns/1ps

module tb;

reg					clk;

initial clk=0;
always #5 clk=~clk;

reg				enable;
reg		[31:0]	data_in;
reg				reset;
wire	[31:0]	data_out;

acc u_target (
	.enable (enable),
	.data_in (data_in),
	.data_out (data_out),
	.reset (reset),
	.clk (clk)
);

reg		[31:0]		sim_cycle;

initial begin
	$sdf_annotate("acc.sdf", u_target);
	$vcdplusfile("sim.vpd");
	$vcdpluson;

	reset = 1'b0;
	data_in = 1'b0;
	enable = 1'b0;

	@(posedge clk);
	reset = 1'b1;

	@(posedge clk);
	@(posedge clk);
	sim_cycle = 0;
	reset = 1'b0;

	while (sim_cycle<20) begin
		@(posedge clk);
		#2;
		case (sim_cycle)
			0: begin
				enable = 1'b1;
				data_in = 32'h0010;
			end

			1: begin
				enable = 1'b1;
				data_in = 32'h0005;
			end

			2: begin
				enable = 1'b1;
				data_in = 32'h0027;
			end

			5: begin
				enable = 1'b1;
				data_in = 32'h0030;
			end

			default: begin
				enable = 1'b0;
				data_in = 32'h0000;
			end
		endcase

		#7;
		$display ("%d: data_out='h%h", sim_cycle, data_out);

		sim_cycle = sim_cycle+1;
	end

	$finish(1);
end

endmodule




