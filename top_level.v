`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:14:44 01/12/2015 
// Design Name: 
// Module Name:    top_level 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top_level(     

//clock input
input CLK,
input [7:0] sw,

output [7:0] seg,
output dp,
output [3:0] an,
output [7:0] Led


);    

/*scrolling_name scrolling_name(
.clock(CLK),
.reset(RESET),
.a(seg[0]),
.b(seg[1]),
.c(seg[2]),
.d(seg[3]),
.e(seg[4]),
.f(seg[5]),
.g(seg[6]),
.dp(dp),
.an(an),
//.XPosition(XPosition),
//.YPosition(YPosition)
.XPosition(8'hFA),
.YPosition(8'hAF)
);*/

digit_driver digit_driver(
.CLK(CLK),
.altClock(sw[0]),
.Led(Led),
.switches(sw),

.SegOut(seg),
.DpOut(dp),
.AnOut(an)
);

endmodule
