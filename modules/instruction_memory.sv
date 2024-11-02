module instruction_memory(
    input logic [31:0] address,
    output logic [31:0] instruction
);
    logic [7:0] memory [0:4095]; // 4kb memory

    initial begin
        // clear memory
        for (int i = 0; i < 4096; i = i + 1) begin
            memory[i] = 0;
        end

        $readmemb("../programs/mul.byte", memory);
    end

    always_comb begin
        instruction = {memory[address], memory[address + 1], memory[address + 2], memory[address + 3]};
    end
endmodule