module register_en (
    input logic clk,
    input logic enable,
    input logic clear,
    input logic [31:0] data_save,
    output logic [31:0] data_out
);
    always @(posedge clk or clear) begin
        if (enable) begin
            data_out <= data_save;
        end
    end

    always @(clear) begin
        if (clear) begin
            data_out <= 0;
        end
    end
endmodule
