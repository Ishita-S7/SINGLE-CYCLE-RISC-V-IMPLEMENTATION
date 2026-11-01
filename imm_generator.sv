`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.10.2026 14:25:02
// Design Name: 
// Module Name: imm_generator
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
module imm_generator(
    input  logic [11:0] imm_input,
    input  logic [2:0]  fn3,
    input  logic [6:0]  opcode,
    input  logic [19:0] imm_input_uj,
    output logic [31:0] imm_output
);

always_comb begin
    // default (load, store, R-type, JALR, other): sign_extend(imm_input)
    imm_output = {{20{imm_input[11]}}, imm_input};

    case (opcode)
        7'b1100011: // Branch: sign_extend(imm_input) << 1
            imm_output = {{19{imm_input[11]}}, imm_input, 1'b0};
        7'b1101111: // JAL: sign_extend(imm_input_uj) << 1
            imm_output = {{11{imm_input_uj[19]}}, imm_input_uj, 1'b0};
        7'b0110111, 7'b0010111: // LUI, AUIPC
            imm_output = {imm_input_uj, 12'b0};
        7'b0010011: begin // I-type ALU
            if (fn3 == 3'b001 || fn3 == 3'b101) // shifts
                imm_output = {27'b0, imm_input[4:0]};
        end
        default: ;
    endcase
end
endmodule





