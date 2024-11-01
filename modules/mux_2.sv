module mux_2(
    input logic [31:0] a,
    input logic [31:0] b,
    input logic sel,
    output logic [31:0] out_mux
);
    always @(*) begin
        case (sel)
            1'b0: out_mux = a;
            1'b1: out_mux = b;
        endcase
    end
endmodule