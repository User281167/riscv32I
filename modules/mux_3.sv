module mux_3(
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [31:0] c,
    input logic [1:0] sel,
    output logic [31:0] out_mux
);
    always @(*) begin
        case (sel)
            2'b00: out_mux = a;
            2'b01: out_mux = b;
            2'b10: out_mux = c;
        endcase
    end
endmodule