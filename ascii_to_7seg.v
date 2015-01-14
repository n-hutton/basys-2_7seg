`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:37:56 01/14/2015 
// Design Name: 
// Module Name:    ascii_to_7seg 
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
module ascii_to_7seg(

input [7:0] asciiOne,
input [7:0] asciiTwo,
input [7:0] asciiThree,
input [7:0] asciiFour,
output [7:0] sevenSegOne,
output [7:0] sevenSegTwo,
output [7:0] sevenSegThree,
output [7:0] sevenSegFour
    );


ascii_convert asciiOneConvert(
.asciiIn(asciiOne),
.segmentOut(sevenSegOne)
);

ascii_convert asciiTwoConvert(
.asciiIn(asciiTwo),
.segmentOut(sevenSegTwo)
);

ascii_convert asciiThreeConvert(
.asciiIn(asciiThree),
.segmentOut(sevenSegThree)
);

ascii_convert asciiFourConvert(
.asciiIn(asciiFour),
.segmentOut(sevenSegFour)
);

endmodule
