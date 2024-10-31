module imm_generate(
    input logic [24:0] imm,
    input logic [2:0] imm_type,
    output logic [31:0] imm_out
);

    always @(imm, imm_type) begin
        case (imm_type)
            3'b000: imm_out = {{21{imm[24]}}, imm[23:13]};
            3'b001: imm_out = {{21{imm[24]}}, imm[23:18], imm[4:0]};
            3'b101: imm_out = {{21{imm[24]}}, imm[0], imm[22:18], imm[4:1], 1'b0};
            3'b010: imm_out = {imm, 12'b0};
            3'b110: imm_out = {{12{imm[24]}}, imm[24], imm[12:5], imm[13], imm[23:14], 1'b0};
        endcase
    end
endmodule