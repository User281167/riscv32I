`timescale 1ns/1ns

module test_instruction_memory;
    logic [31:0] address;
    logic [31:0] instruction;
	 int expected;

    instruction_memory utt (
        .address(address),
        .instruction(instruction)
    );

    initial begin
        $dumpfile("instruction_memory.vcd");
        $dumpvars(0, test_instruction_memory);
    end

    initial begin
        address = 0;
        expected = 32'h02000863;
        #10;

        if (instruction != expected) begin
            $display("Test 1 Failed: address: 0x%x, instruction: 0x%x (expected instruction: 0x%x)", address, instruction, expected);
            $finish;
        end

        address = 1 * 4;
        expected = 32'h000002b3;
        #10;

        if (instruction != expected) begin
            $display("Test 2 Failed: address: 0x%x, instruction: 0x%x (expected instruction: 0x%x)", address, instruction, expected);
            $finish;
        end

        address = 2 * 4;
        expected = 32'h02060063;
        #10;

        if (instruction != expected) begin
            $display("Test 3 Failed: address: 0x%x, instruction: 0x%x (expected instruction: 0x%x)", address, instruction, expected);
            $finish;
        end

        address = 3 * 4;
        expected = 32'h00064863;
        #10;

        if (instruction != expected) begin
            $display("Test 4 Failed: address: 0x%x, instruction: 0x%x (expected instruction: 0x%x)", address, instruction, expected);
            $finish;
        end

        address = 17 * 4;
        expected = 32'h00000000;
        #10;

        if (instruction != expected) begin
            $display("Test 5 Failed: address: 0x%x, instruction: 0x%x (expected instruction: 0x%x)", address, instruction, expected);
            $finish;
        end

        $finish;
    end
endmodule