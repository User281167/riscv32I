module register (
    input logic clk,
    input logic [31:0] data_save,
    output logic [31:0] data_out
);
    always @(posedge clk) begin
        data_out <= data_save;
    end
endmodule