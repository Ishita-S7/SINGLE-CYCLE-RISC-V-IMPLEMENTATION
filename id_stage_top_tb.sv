`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2026 18:49:16
// Design Name: 
// Module Name: id_stage_top_tb
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
module id_stage_top_tb;

    // Inputs
    logic clk;
    logic reset;
    logic [31:0] instruction;
    logic [31:0] wb_data;
    logic reg_write;

    // Final outputs
    logic [31:0] rs1_data;
    logic [31:0] rs2_data;
    logic [31:0] imm_output;

    // Intermediate outputs
    logic [4:0] rs1, rs2, rd;
    logic [6:0] opcode;
    logic [2:0] fn3;
    logic fn7_5;
    logic [11:0] imm;
    logic [19:0] imm_uj;
    logic [11:4] imm11_5;

    // Control outputs
    logic [1:0] memtoreg;
    logic branch, memread, memwrite;
    logic alusrc, regwrite;
    logic [2:0] aluop;
    logic mux_inp;

    // Instantiate top-level module
    id_stage_top dut (
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .wb_data(wb_data),
        .reg_write(reg_write),

        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .imm_output(imm_output),

        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .opcode(opcode),
        .fn3(fn3),
        .fn7_5(fn7_5),
        .imm(imm),
        .imm_uj(imm_uj),
        .imm11_5(imm11_5),

        .memtoreg(memtoreg),
        .branch(branch),
        .memread(memread),
        .memwrite(memwrite),
        .alusrc(alusrc),
        .regwrite(regwrite),
        .aluop(aluop),
        .mux_inp(mux_inp)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin

        // Initial values
        clk = 0;
        reset = 1;
        instruction = 0;
        wb_data = 0;
        reg_write = 0;

        // Reset
        #10;
        reset = 0;
        // TEST 1: ADD x5, x6, x7
        instruction = 32'b0000000_00111_00110_000_00101_0110011;
        #10;

        $display("===== TEST 1: ADD =====");
        $display("Instruction = %h", instruction);
        $display("Opcode      = %b", opcode);
        $display("rd          = %0d", rd);
        $display("rs1         = %0d", rs1);
        $display("rs2         = %0d", rs2);
        $display("funct3      = %b", fn3);
        $display("ALUOp       = %b", aluop);
        $display("RegWrite    = %b", regwrite);
        // TEST 2: ADDI x5, x6, 10
        instruction = 32'b000000001010_00110_000_00101_0010011;
        #10;

        $display("===== TEST 2: ADDI =====");
        $display("Opcode      = %b", opcode);
        $display("rd          = %0d", rd);
        $display("rs1         = %0d", rs1);
        $display("Immediate   = %h", imm_output);
        $display("ALUOp       = %b", aluop);
        $display("ALUSrc      = %b", alusrc);
        // TEST 3: LW x5, 8(x6)
        instruction = 32'b000000001000_00110_010_00101_0000011;
        #10;

        $display("===== TEST 3: LOAD =====");
        $display("Opcode      = %b", opcode);
        $display("rd          = %0d", rd);
        $display("rs1         = %0d", rs1);
        $display("Immediate   = %h", imm_output);
        $display("MemRead     = %b", memread);
        $display("MemtoReg    = %b", memtoreg);

        // --------------------------------
        // TEST 4: SW x7, 12(x6)
        // --------------------------------

        instruction = 32'b0000000_00111_00110_010_01100_0100011;
        #10;

        $display("===== TEST 4: STORE =====");
        $display("Opcode      = %b", opcode);
        $display("rs1         = %0d", rs1);
        $display("rs2         = %0d", rs2);
        $display("Immediate   = %h", imm_output);
        $display("MemWrite    = %b", memwrite);

        // --------------------------------
        // TEST 5: BEQ x6, x7, offset
        // --------------------------------

        instruction = 32'b0000000_00111_00110_000_00000_1100011;
        #10;

        $display("===== TEST 5: BEQ =====");
        $display("Opcode      = %b", opcode);
        $display("Branch      = %b", branch);
        $display("rs1         = %0d", rs1);
        $display("rs2         = %0d", rs2);
        $display("Immediate   = %h", imm_output);

        #10;
        $display("===== TESTBENCH COMPLETED =====");

        $finish;

    end

    // Monitor signals
    initial begin
        $monitor(
            "Time=%0t | opcode=%b | rd=%0d | rs1=%0d | rs2=%0d | ALUOp=%b | imm=%h",
            $time, opcode, rd, rs1, rs2, aluop, imm_output
        );
    end

endmodule



