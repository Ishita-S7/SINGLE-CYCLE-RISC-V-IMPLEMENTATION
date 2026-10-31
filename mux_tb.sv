`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2026 14:26:55
// Design Name: 
// Module Name: mux_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_tb();
reg  a;
reg b;
reg  s;
wire y;
mux dut(a,b,s,y);
initial begin
a=1'b0; b=1'b0;s=1'b0;
#10 a=1'b0; b=1'b0;s=1'b1;
#10 a=1'b0; b=1'b1;s=1'b0;
#10 a=1'b0; b=1'b1;s=1'b1;
#10 a=1'b1; b=1'b0;s=1'b0;
#10 a=1'b1; b=1'b0;s=1'b1;
#10 a=1'b1; b=1'b1;s=1'b0;
#10 a=1'b1; b=1'b1;s=1'b1;
end
endmodule
