`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2026 00:19:21
// Design Name: 
// Module Name: imem
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


module imem (input  logic [31:0] a,
             output logic [31:0] rd);
  logic [31:0] RAM [63:0];
  initial $readmemh("riscvtest.txt", RAM);
  assign rd = RAM[a[31:2]];
endmodule
