`timescale 1ns / 1ps

module maincontrol(memtoreg, branch, memread, memwrite, alusrc, regwrite, aluop, mux_inp, opcode);
output logic [1:0] memtoreg;
output logic       branch;
output logic       memread;
output logic       memwrite;
output logic       alusrc;
output logic       regwrite;
output logic [2:0] aluop;
output logic       mux_inp;
input  logic [6:0] opcode;

always_comb begin
    // defaults: every output is always assigned, so no latch is inferred
    memtoreg = 2'b00;
    branch   = 1'b0;
    memread  = 1'b0;
    memwrite = 1'b0;
    alusrc   = 1'b0;
    regwrite = 1'b0;
    aluop    = 3'b000;
    mux_inp  = 1'b0;

    case (opcode)
        7'b0110011: begin // R type
            regwrite = 1'b1;
        end
        7'b0010011: begin // I type
            alusrc   = 1'b1;
            regwrite = 1'b1;
            aluop    = 3'b001;
        end
        7'b0000011: begin // Load
            memtoreg = 2'b01;
            memread  = 1'b1;
            alusrc   = 1'b1;
            regwrite = 1'b1;
            aluop    = 3'b010;
        end
        7'b0100011: begin // Store
            memtoreg = 2'b11;
            memwrite = 1'b1;
            alusrc   = 1'b1;
            aluop    = 3'b011;
        end
        7'b1100011: begin // Branch
            branch   = 1'b1;
            aluop    = 3'b100;
        end
        7'b1101111: begin // JAL
            memtoreg = 2'b10;
            alusrc   = 1'b1;
            regwrite = 1'b1;
            aluop    = 3'b110;
        end
        7'b1100111: begin // JALR
            memtoreg = 2'b10;
            alusrc   = 1'b1;
            regwrite = 1'b1;
            aluop    = 3'b001;
            mux_inp  = 1'b1;
        end
        7'b0110111: begin // LUI
            memtoreg = 2'b10;
            alusrc   = 1'b1;
            regwrite = 1'b1;
            aluop    = 3'b110;
        end
        7'b0010111: begin // AUIPC
            memtoreg = 2'b10;
            alusrc   = 1'b1;
            regwrite = 1'b1;
            aluop    = 3'b000;
        end
        default: ; // keep the defaults
    endcase
end
endmodule
