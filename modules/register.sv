module register #(
    parameter WIDTH = 32
) (
    input logic clk,
    input logic [WIDTH-1:0] data_save,
    output logic [WIDTH-1:0] data_out = 0
);
    always @(posedge clk) begin
        data_out <= data_save;
    end
endmodule