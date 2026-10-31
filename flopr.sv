`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2026 00:14:54
// Design Name: 
// Module Name: flopr
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

module flopr #(parameter WIDTH = 8)
  (input  logic             clk, reset,
   input  logic [WIDTH-1:0] d,
   output logic [WIDTH-1:0] q);
  always_ff @(posedge clk or posedge reset)
    if (reset) q <= '0;
    else       q <= d;
endmodule

