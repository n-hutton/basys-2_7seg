`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:31:30 01/13/2015 
// Design Name: 
// Module Name:    digit_driver 
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
module digit_driver(
input CLK,
input altClock,
input [7:0] switches,
output [7:0] Led,
output reg [7:0] SegOut,
output DpOut,
output [3:0] AnOut


);
	 
reg [7:0] argh;
reg [3:0] argh1;
reg [3:0] argh2;
reg [3:0] an_inverted;

assign Led = argh;
//assign Led = altClock;
assign AnOut = ~an_inverted;

reg [28:0] ticker;
reg altClock2;
reg [30:0] tempSwitch;

always @ (posedge CLK)
begin
	tempSwitch <= (switches << 11);
	
	if(ticker >= tempSwitch) //reset after 1 second
	begin
		ticker <= 0;
		if(altClock == 1)
			altClock2 <= 1;
	end
	else
	begin
		ticker <= ticker + 1;
		altClock2 <= 0;	
	end
end


always @ (posedge altClock2)
begin

	
	//argh[3:0] <= an_inverted;
	//argh[7:4] <= argh[7:4] + 1;
	//argh[ <= argh + 1;
	
	argh[3:0] <= argh1;
	argh[7:4] <= argh2;
	
	argh1 <= an_inverted;
	argh2 <= argh2 + 1;
//	
//	if(argh[3:0] <= 4'b1000)
//	begin
//		argh <= 0;
//	end
//	else
//	begin
//		argh <= argh + 1;
//	end
	

	//Strobe across each of the segments
	if(an_inverted == 4'b0)
	begin
		an_inverted <= 4'b0001;
	end
	else if(an_inverted >= 4'b1000)
	begin
		an_inverted <= 4'b0001;
	end
	else
	begin
		an_inverted <= an_inverted << 1;
	end
	
	case(an_inverted)
	
	4'b0001:
	begin
		SegOut <= 7'b0001110; //to display F
	end
	
	4'b0010:
	begin
		SegOut <= 7'b0000011; //to display B;
	end
	
	4'b0100:
	begin
		SegOut <= 7'b1000110; //to display C;
	end
	
	4'b1000:
	begin
		SegOut <= 7'b0100001; //to display D
	end
	
	default:
	begin
		SegOut <= 7'b1111111;//Display nothing
		//argh[7:4] <= argh[7:4] + 1;
	end
	endcase
end

endmodule
