`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:03:09 01/14/2015 
// Design Name: 
// Module Name:    ascii_convert 
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
module ascii_convert(
input      [7:0] asciiIn,
output reg [7:0] segmentOut
 );

always @ (*)
begin
	case(asciiIn)
		"0" : segmentOut = 8'b11000000; //to display 0
		"1" : segmentOut = 8'b11001111; //to display 1
		"2" : segmentOut = 8'b10100100; //to display 2
		"3" : segmentOut = 8'b10110000; //to display 3
		"4" : segmentOut = 8'b10011001; //to display 4
		"5" : segmentOut = 8'b10010010; //to display 5
		"6" : segmentOut = 8'b10000011; //to display 6
		"7" : segmentOut = 8'b11111000; //to display 7
		"8" : segmentOut = 8'b10000000; //to display 8
		"9" : segmentOut = 8'b10011000; //to display 9
		"A" : segmentOut = 8'b10001000; //to display A
		"B" : segmentOut = 8'b10000011; //to display B
		"C" : segmentOut = 8'b11000110; //to display C
		"D" : segmentOut = 8'b10100001; //to display D
		"E" : segmentOut = 8'b10000110; //to display E
		"F" : segmentOut = 8'b10001110; //to display F
		default : segmentOut = 8'b11111111; //blank
	endcase
end

endmodule
