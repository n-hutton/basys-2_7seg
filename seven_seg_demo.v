`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: None
// Engineer: N. Hutton
// 
// Create Date:    10:24:56 01/14/2015 
// Design Name: 
// Module Name:    	seven_seg_demo 
// Project Name: 		basys-2_7_segment
// Target Devices:	basys2 Spartan-3E 100k
// Tool versions: 
// Description: Top level module for seven segment scrolling display demo
//
// Dependencies: digit_scroll.v ascii_to_7seg.v digit_driver.v seven_seg_demo.ucf
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module seven_seg_demo(     

//clock input
input CLK,
input btn,

//Outputs are
output [6:0] seg,
output [3:0] an,
output dp
);    

wire [7:0] sevenSegOne;
wire [7:0] sevenSegTwo;
wire [7:0] sevenSegThree;
wire [7:0] sevenSegFour;

wire [7:0] asciiOneWire;
wire [7:0] asciiTwoWire;
wire [7:0] asciiThreeWire;
wire [7:0] asciiFourWire;

digit_scroll digit_scroll(
	.CLK(CLK),
	.RESET(btn),
	.cyclesPerStrobe(40000000),
	.asciiOne(asciiOneWire),
	.asciiTwo(asciiTwoWire),
	.asciiThree(asciiThreeWire),
	.asciiFour(asciiFourWire)
);

ascii_to_7seg ascii_to_7seg(
	.asciiOne(asciiOneWire),
	.asciiTwo(asciiTwoWire),
	.asciiThree(asciiThreeWire),
	.asciiFour(asciiFourWire),

	.sevenSegOne(sevenSegOne),
	.sevenSegTwo(sevenSegTwo),
	.sevenSegThree(sevenSegThree),
	.sevenSegFour(sevenSegFour)
);

digit_driver digit_driver(
	.CLK(CLK),
	.cyclesPerStrobe(50000),
	.digitOne(sevenSegOne),
	.digitTwo(sevenSegTwo),
	.digitThree(sevenSegThree),
	.digitFour(sevenSegFour),
	.SegOut(seg),
	.AnOut(an),
	.DpOut(dp)
);

endmodule