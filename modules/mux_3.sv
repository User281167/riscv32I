module mux_3(
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [31:0] c,
    input logic [1:0] sel,
    output logic [31:0] out_mux
);
    always @(*) begin
        if (sel == 2'b00) begin
            out_mux = a;
        end
        else if (sel == 2'b01) begin
            out_mux = b;
        end
        else if (sel == 2'b10) begin
            out_mux = c;
        end
    end
endmodule