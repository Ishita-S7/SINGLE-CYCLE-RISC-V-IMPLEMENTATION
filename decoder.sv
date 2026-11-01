`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.10.2026 14:49:04
// Design Name: 
// Module Name: decoder
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


module decoder(rs1,rs2,rd,opcode,fn3,fn7_5,imm,imm_uj,imm11_5,instruction);
input  logic [31:0] instruction;
output logic [4:0]  rs1,rs2,rd;
output logic [6:0]  opcode;
output logic [2:0]  fn3;
output logic        fn7_5;
output logic [11:0] imm;
output logic [19:0] imm_uj;
output logic [6:0]  imm11_5;

always_comb begin
    opcode  = instruction[6:0];
    rd      = instruction[11:7];
    fn3     = instruction[14:12];
    rs1     = instruction[19:15];
    rs2     = instruction[24:20];
    fn7_5   = instruction[30];
    imm_uj  = instruction[31:12];
    imm11_5 = instruction[31:25];
    case (instruction[6:0])
        7'b0100011: imm = {instruction[31:25], instruction[11:7]};  // store
        7'b1100011: imm = {instruction[31], instruction[30:25],
                           instruction[11:8], instruction[7]};      // branch
        default:    imm = instruction[31:20];                       // I-type, load, JALR
    endcase
end
endmodule
