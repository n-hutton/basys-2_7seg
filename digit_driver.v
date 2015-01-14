`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:31:30 01/13/2015 
// Design Name: 
// Module Name:    	digit_driver 
// Project Name: 		basys-2_7_segment
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
module digit_driver(
        input CLK,
        input [31:0] cyclesPerStrobe,

        input [7:0] digitOne,
        input [7:0] digitTwo,
        input [7:0] digitThree,
        input [7:0] digitFour,

        output reg [6:0] SegOut,
        output [3:0] AnOut,
        output reg DpOut
);

reg [3:0] an_inverted;
assign AnOut = ~an_inverted;

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

    
    
//We want our 7 segment display to strobe each digit at this speed
always @ (posedge tickerClock)
begin

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
end

always @ (negedge tickerClock)
begin

	case(an_inverted)

        4'b1000:
        begin
            SegOut <= digitOne[6:0]; //to display F
				DpOut <= digitOne[7];
        end
        
        4'b0100:
        begin
            SegOut <= digitTwo[6:0]; //to display B; two
				DpOut <= digitTwo[7];
        end
        
        4'b0010:
        begin
            SegOut <= digitThree[6:0]; //to display C; three
				DpOut <= digitThree[7];
        end
        
        4'b0001:
        begin
            SegOut <= digitFour[6:0]; //to display D
				DpOut <= digitFour[7];
        end
        
        default:
        begin
            SegOut <= 7'b1111111;//Display nothing
        end
    endcase
end

endmodule
