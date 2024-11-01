module instruction_memory(
    input logic [31:0] address,
    output logic [31:0] instruction
);
    logic [31:0] memory [0:1023]; // 4kb memory

    initial begin
        // clear memory
        for (int i = 0; i < 1024; i = i + 1) begin
            memory[i] = 32'd0;
        end

        $readmemh("../programs/mul.hex", memory);
    end

    always @(address) begin
        instruction <= memory[address];
    end
endmodule