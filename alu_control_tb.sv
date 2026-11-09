`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2026 18:15:47
// Design Name: 
// Module Name: alu_control_tb
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
module alu_control_tb;

    logic [2:0] alu_op;
    logic [2:0] fn3;
    logic [6:0] imm11_5;
    logic fn7_5;

    logic [4:0] control_out;

    integer passed = 0;
    integer failed = 0;

    // DUT
    alu_control DUT (
        .alu_op(alu_op),
        .fn3(fn3),
        .imm11_5(imm11_5),
        .fn7_5(fn7_5),
        .control_out(control_out)
    );

    // Test task
    task check_result(
        input logic [2:0] test_alu_op,
        input logic [2:0] test_fn3,
        input logic [6:0] test_imm11_5,
        input logic test_fn7_5,
        input logic [4:0] expected
    );
    begin
        alu_op = test_alu_op;
        fn3 = test_fn3;
        imm11_5 = test_imm11_5;
        fn7_5 = test_fn7_5;

        #10;

        if (control_out === expected) begin
            $display("PASS: alu_op=%b fn3=%b control=%b",
                     alu_op, fn3, control_out);
            passed = passed + 1;
        end
        else begin
            $display("FAIL: alu_op=%b fn3=%b expected=%b actual=%b",
                     alu_op, fn3, expected, control_out);
            failed = failed + 1;
        end
    end
    endtask

    initial begin

        $display("--------------------------------");
        $display("   ALU CONTROL TESTBENCH");
        $display("--------------------------------");

        // R-Type
        check_result(3'b000, 3'b000, 7'b0000000, 1'b0, 5'b00000); // ADD
        check_result(3'b000, 3'b000, 7'b0000000, 1'b1, 5'b00001); // SUB
        check_result(3'b000, 3'b001, 7'b0000000, 1'b0, 5'b00101); // SLL
        check_result(3'b000, 3'b010, 7'b0000000, 1'b0, 5'b01000); // SLT
        check_result(3'b000, 3'b011, 7'b0000000, 1'b0, 5'b01001); // SLTU
        check_result(3'b000, 3'b100, 7'b0000000, 1'b0, 5'b00010); // XOR
        check_result(3'b000, 3'b101, 7'b0000000, 1'b0, 5'b00110); // SRL
        check_result(3'b000, 3'b101, 7'b0000000, 1'b1, 5'b00111); // SRA
        check_result(3'b000, 3'b110, 7'b0000000, 1'b0, 5'b00011); // OR
        check_result(3'b000, 3'b111, 7'b0000000, 1'b0, 5'b00100); // AND

        // I-Type
        check_result(3'b001, 3'b000, 7'b0000000, 1'b0, 5'b00000); // ADDI
        check_result(3'b001, 3'b001, 7'b0000000, 1'b0, 5'b00101); // SLLI
        check_result(3'b001, 3'b010, 7'b0000000, 1'b0, 5'b01000); // SLTI
        check_result(3'b001, 3'b011, 7'b0000000, 1'b0, 5'b01001); // SLTIU
        check_result(3'b001, 3'b100, 7'b0000000, 1'b0, 5'b00010); // XORI
        check_result(3'b001, 3'b101, 7'b0000000, 1'b0, 5'b00110); // SRLI
        check_result(3'b001, 3'b101, 7'b0100000, 1'b0, 5'b00111); // SRAI
        check_result(3'b001, 3'b110, 7'b0000000, 1'b0, 5'b00011); // ORI
        check_result(3'b001, 3'b111, 7'b0000000, 1'b0, 5'b00100); // ANDI

        // Load and Store
        check_result(3'b010, 3'b000, 7'b0000000, 1'b0, 5'b00000);
        check_result(3'b011, 3'b000, 7'b0000000, 1'b0, 5'b00000);

        // Branch
        check_result(3'b100, 3'b000, 7'b0000000, 1'b0, 5'b01010); // BEQ
        check_result(3'b100, 3'b001, 7'b0000000, 1'b0, 5'b01011); // BNE
        check_result(3'b100, 3'b100, 7'b0000000, 1'b0, 5'b01100); // BLT
        check_result(3'b100, 3'b101, 7'b0000000, 1'b0, 5'b01101); // BGE
        check_result(3'b100, 3'b110, 7'b0000000, 1'b0, 5'b01110); // BLTU
        check_result(3'b100, 3'b111, 7'b0000000, 1'b0, 5'b01111); // BGEU

        // JAL / LUI
        check_result(3'b110, 3'b000, 7'b0000000, 1'b0, 5'b00000);

        // Default case
        check_result(3'b101, 3'b000, 7'b0000000, 1'b0, 5'b00000);

        $display("--------------------------------");
        $display("TESTBENCH SUMMARY");
        $display("PASSED: %0d", passed);
        $display("FAILED: %0d", failed);
        $display("--------------------------------");

        if (failed == 0)
            $display("ALL TESTS PASSED!");
        else
            $display("SOME TESTS FAILED!");

        $finish;
    end

endmodule
