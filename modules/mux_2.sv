module mux_2(
    input logic [31:0] a,
    input logic [31:0] b,
    input logic sel,
    output logic [31:0] out_mux
);
    always @(*) begin
        if (sel == 1) begin
            out_mux = a;
        end
        else begin
            out_mux = b;
        end
    end
endmodule