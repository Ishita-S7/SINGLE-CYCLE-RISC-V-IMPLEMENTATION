`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2026 18:38:07
// Design Name: 
// Module Name: id_stage_top
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
module id_stage_top(

    // Inputs
    input logic clk,
    input logic reset,
    input logic [31:0] instruction,

    // Register file write-back inputs
    input logic [31:0] wb_data,
    input logic reg_write,

    // Final ID stage outputs
    output logic [31:0] rs1_data,
    output logic [31:0] rs2_data,
    output logic [31:0] imm_output,

    // Intermediate instruction fields (debugging)
    output logic [4:0] rs1,
    output logic [4:0] rs2,
    output logic [4:0] rd,
    output logic [6:0] opcode,
    output logic [2:0] fn3,
    output logic fn7_5,
    output logic [11:0] imm,
    output logic [19:0] imm_uj,
    output logic [11:4] imm11_5,

    // Main control outputs
    output logic [1:0] memtoreg,
    output logic branch,
    output logic memread,
    output logic memwrite,
    output logic alusrc,
    output logic regwrite,
    output logic [2:0] aluop,
    output logic mux_inp
);
    
    // 1 ID STAGE - INSTRUCTION DECODER
    id_stage decoder (
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .opcode(opcode),
        .fn3(fn3),
        .fn7_5(fn7_5),
        .imm(imm),
        .imm_uj(imm_uj),
        .imm11_5(imm11_5),
        .instruction(instruction)
    );
    // 2. MAIN CONTROL UNIT
    maincontrol control (
        .memtoreg(memtoreg),
        .branch(branch),
        .memread(memread),
        .memwrite(memwrite),
        .alusrc(alusrc),
        .regwrite(regwrite),
        .aluop(aluop),
        .mux_inp(mux_inp),
        .opcode(opcode)
    );
    
    // 3. REGISTER FILE
    register_file registers (
        .reset(reset),
        .clk(clk),
        .rs1_sel(rs1),
        .rs2_sel(rs2),
        .rd_sel(rd),
        .wb_data(wb_data),
        .reg_write(reg_write),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );
  // 4 IMMEDIATE GENERATOR
    imm_generator immediate (
        .imm_input(imm),
        .fn3(fn3),
        .opcode(opcode),
        .imm_input_uj(imm_uj),
        .imm_output(imm_output)
    );

endmodule