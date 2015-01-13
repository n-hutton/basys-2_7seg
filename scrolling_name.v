`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:19:05 01/12/2015 
// Design Name: 
// Module Name:    scrolling_name 
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
`timescale 1ns / 1ps

module scrolling_name(
input clock,
input reset,
output a,
output b,
output c,
output d,
output e,
output f,
output g,
output dp,
output [3:0] an,
input [7:0] XPosition,
input [7:0] YPosition
);

reg [28:0] ticker; //to hold a count of 50M
wire click;
reg [3:0] fourth, third, second, first; // registers to hold the LED values

always @ (posedge clock or posedge reset) //always block for the ticker
begin
if(reset)
ticker <= 0;
else if(ticker == 50000000) //reset after 1 second
ticker <= 0;
else
ticker <= ticker + 1;
end

reg [3:0] clickcount; //register to hold the count upto 9. That is why a 4 bit     register is used. 3 bit would not have been enough.

assign click = ((ticker == 50000000)?1'b1:1'b0); //click every second

always @ (posedge click or posedge reset)
begin
 if(reset)
  clickcount <= 0;
 else if(clickcount == 8)
   clickcount <= 0;
  else
  clickcount <= clickcount + 1;

end

always@(posedge clock)
begin
fourth = XPosition[7:4]; 
third = XPosition[3:0]; 

second = YPosition[7:4]; 
first = YPosition[3:0]; 
end

//see my other post on explanation of LED multiplexing.

localparam N = 18;

reg [N-1:0]count;

always @ (posedge clock or posedge reset)
 begin
  if (reset)
   count <= 0;
  else
   count <= count + 1;
 end

reg [6:0]sseg;
reg [3:0]an_temp;

always @ (*)
 begin
  case(count[N-1:N-2])

   2'b00 :
    begin
     sseg = first;
     an_temp = 4'b1110;
    end

   2'b01:
    begin
     sseg = second;
     an_temp = 4'b1101;
    end

   2'b10:
    begin
     sseg = third;
     an_temp = 4'b1011;
    end

   2'b11:
    begin
     sseg = fourth;
     an_temp = 4'b0111;
    end
  endcase
 end
assign an = an_temp;

reg [6:0] sseg_temp;

always @ (*)
 begin
  case(sseg)
   0 : sseg_temp = 7'b1000000; //to display 0
   1 : sseg_temp = 7'b1001111; //to display 1
   2 : sseg_temp = 7'b0100100; //to display 2
   3 : sseg_temp = 7'b0110000; //to display 3
   4 : sseg_temp = 7'b0011001; //to display 4
   5 : sseg_temp = 7'b0010010; //to display 5
   6 : sseg_temp = 7'b0000011; //to display 6
   7 : sseg_temp = 7'b1111000; //to display 7
   8 : sseg_temp = 7'b0000000; //to display 8
   9 : sseg_temp = 7'b0011000; //to display 9
   10 : sseg_temp = 7'b0001000; //to display A
   11 : sseg_temp = 7'b0000011; //to display B
   12 : sseg_temp = 7'b1000110; //to display C
   13 : sseg_temp = 7'b0100001; //to display D
   14 : sseg_temp = 7'b0000110; //to display E
   15 : sseg_temp = 7'b0001110; //to display F

default : sseg_temp = 7'b1111111; //blank
endcase
end

assign {g, f, e, d, c, b, a} = sseg_temp;
assign dp = 1'b1;

endmodule