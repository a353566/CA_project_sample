module target (A,B,OUTPUT,enable,reset,clk);

parameter n_A = 8; 
parameter n_B = 8;
parameter n_OUTPUT = 16;

input				enable;
input	[n_A-1:0]		A;
input	[n_B-1:0]		B;
input				reset;
input				clk;

output	[n_OUTPUT -1:0]	OUTPUT;

reg 	[n_A-1:0]		R_A;
reg	[n_B-1:0]		R_B;
reg	[n_OUTPUT-1:0]		OUTPUT;
reg				R_enable;

wire	[n_OUTPUT-1:0]		data_out;


YOUR_MODULE NAME(
	.INPUT1(R_A),
	.INPUT2(R_B),
	.OUTPUT(data_out)
);


always @(posedge clk) begin
	R_enable <= (reset)? 1'b0: enable;
	R_A <= (reset)? {(n_A){1'b0}} : A;
	R_B <= (reset)? {(n_B){1'b0}} : B;
end



always @(posedge clk) begin
	if (reset)
		OUTPUT <= {(n_OUTPUT){1'b0}};
	else if (R_enable)
		OUTPUT <= data_out;
	else
		OUTPUT <= OUTPUT;
end

endmodule




