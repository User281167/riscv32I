module data_memory(
    input logic write_en,
    input logic [2:0] dm_control,
    input logic [31:0] address,
    input logic [31:0] write_data,
    output logic [31:0] read_data
);
    // 4 KB memory
    logic [31:0] memory[1023:0];

    initial begin
        for (int i = 0; i < 1024; i++) begin
            memory[i] = 32'h00000000;
        end
    end

    always @(*) begin
        if (write_en) begin
            memory[address] = write_data;
        end

        if (write_en == 0) begin
            case (dm_control)
                3'b000: begin
                    read_data = {{24{memory[address][7]}}, memory[address][7:0]};
                end
                3'b001: begin
                    read_data = {{16{memory[address][15]}}, memory[address][15:0]};
                end
                3'b010: begin
                    read_data = memory[address];
                end
                3'b100: begin
                    read_data = {{24{1'b0}}, memory[address][7:0]};
                end
                3'b101: begin
                    read_data = {{16{1'b0}}, memory[address][15:0]};
                end
            endcase
        end
    end
endmodule