`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.10.2026 13:54:17
// Design Name: 
// Module Name: if_stage_tb
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



module if_stage_tb;

logic clk, reset, stall, and_out;
logic [31:0] PC_so;
logic [31:0] address, PC_new;

// Instantiate DUT
if_stage dut (
    .clk(clk),
    .reset(reset),
    .stall(stall),
    .and_out(and_out),
    .PC_so(PC_so),
    .address(address),
    .PC_new(PC_new)
);

// Clock generation: 10 ns period
always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    stall = 0;
    and_out = 0;
    PC_so = 0;

    // Test 1: Reset
    #10;
    reset = 0;
    #10;

    // Test 2: Normal PC increment
    and_out = 0;
    #10;

    // Test 3: Branch taken
    and_out = 1;
    PC_so = 32'h8000_0010;
    #10;

    // Test 4: Stall
    stall = 1;
    and_out = 0;
    #10;

    // Test 5: Resume
    stall = 0;
    #10;

    $finish;
end

initial begin
    $monitor("Time=%0t reset=%b stall=%b and_out=%b PC_so=%h address=%h PC_new=%h",
             $time, reset, stall, and_out, PC_so, address, PC_new);
end

endmodule
