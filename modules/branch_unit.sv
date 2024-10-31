module branch_unit(
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [4:0] branch_op,
    output logic branch_out
);
    always @(*) begin
        if (branch_op[4:3] == 2'b00) begin
            branch_out = a == 0;
        end
        else if (branch_op == 5'b11111) begin
            branch_out = 1;
        end
        else if (branch_op[4] == 1) begin
            branch_out = a == 1;
        end

        case (branch_op)
            5'b01000: begin
                branch_out = a == b;
            end
            5'b01001: begin
                branch_out = a != b;
            end
            5'b01100: begin
                branch_out = a < b;
            end
            5'b01101: begin
                branch_out = a >= b;
            end
            5'b01110: begin
                branch_out = a < b;
            end
            5'b01111: begin
                branch_out = a >= b;
            end
        endcase
    end
endmodule