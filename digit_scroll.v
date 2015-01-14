`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: None
// Engineer: N. Hutton
// 
// Create Date:    13:21:29 01/14/2015 
// Design Name: 
// Module Name:		digit_scroll 
// Project Name:		basys-2_7_segment
// Target Devices: 	basys2 Spartan-3E 100k
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
module digit_scroll(
	input CLK,
	input [31:0] cyclesPerStrobe,
	input RESET,
	
	output reg [7:0] asciiOne,
	output reg [7:0] asciiTwo,
	output reg [7:0] asciiThree,
	output reg [7:0] asciiFour
);

localparam STRING_TO_DISPLAY = "0123456789ABCDEF ";
localparam STRING_LENGTH = 17;

reg [(8*STRING_LENGTH)-1:0] stringvar;

reg [31:0] ticker;
reg tickerClock;

always @ (posedge CLK)
begin
    if(ticker >= cyclesPerStrobe) //reset after 1 second
        begin
            ticker <= 0;
            tickerClock <= 1;
        end
        else
        begin
            ticker <= ticker + 1;
            tickerClock <= 0;	
        end
end

always @ (posedge tickerClock or posedge RESET)
begin
	if(RESET)
	begin
		stringvar  <= STRING_TO_DISPLAY;
	   asciiOne   <= 8'b11111111;
		asciiTwo   <= 8'b11111111;
		asciiThree <= 8'b11111111;
		asciiFour  <= 8'b11111111;
	end
	else
	begin
		asciiOne   <= asciiTwo;
		asciiTwo   <= asciiThree;
		asciiThree <= asciiFour;
		asciiFour  <= stringvar[7:0]; 
		
		stringvar <= stringvar << 8;
		stringvar[7:0] <= stringvar[(8*STRING_LENGTH)-1:(8*STRING_LENGTH)-8];
	end
end

endmodule