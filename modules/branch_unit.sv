module branch_unit(
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [4:0] branch_op,
    output logic branch_out
);
    always @(*) begin
        case (branch_op)
            5'b00xxx: begin
                branch_out <= 0;
            end
            5'b01000: begin
                branch_out <= a == b;
            end
            5'b01001: begin
                branch_out <= a != b;
            end
            5'b01100: begin
                branch_out <= $signed(a) < $signed(b); // by default input logic is unsigned
            end
            5'b01101: begin
                branch_out <= $signed(a) >= $signed(b);
            end
            5'b01110: begin
                branch_out <= a < b;
            end
            5'b01111: begin
                branch_out <= a >= b;
            end
            5'b1xxxx: begin
                branch_out <= 1;
            end
        endcase
    end
endmodule