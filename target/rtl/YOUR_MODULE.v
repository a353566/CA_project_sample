module YOUR_MODULE (INPUT1,INPUT2,OUTPUT);

input	[7:0]	INPUT1;
input	[7:0]	INPUT2;
output	[15:0]	OUTPUT;


assign OUTPUT = INPUT1 * INPUT2;

endmodule
