`timescale 1ns/1ns

module test_program_counter;
    logic clk;
    logic [31:0] next_pc;
    logic [31:0] current_pc;

    program_counter utt (
        .clk(clk),
        .next_pc(next_pc),
        .current_pc(current_pc)
    );

    initial begin
        $dumpfile("program_counter.vcd");
        $dumpvars(0, test_program_counter);
    end

    initial begin
        clk = 0;

        forever begin
             #10;
             clk = ~clk;
        end
    end

    initial begin
        next_pc = 0;
        $display("Test 1 current_pc: 0x%x, next_pc: 0x%x (expected current_pc: 0x00000000)", current_pc, next_pc);
        if (current_pc != 32'h00000000) $finish;
        #10;

        next_pc = 32'h00000004;
        $display("Test 2 current_pc: 0x%x, next_pc: 0x%x (expected current_pc: 0x00000000)", current_pc, next_pc);
        if (current_pc != 32'h00000000) $finish;
        #10;

        next_pc = 32'h00000008;
        $display("Test 3 current_pc: 0x%x, next_pc: 0x%x (expected current_pc: 0x00000004)", current_pc, next_pc);
        if (current_pc != 32'h00000004) $finish;
        #5;

        next_pc = 32'h0000000c;
        $display("Test 4 current_pc: 0x%x, next_pc: 0x%x (expected current_pc: 0x00000004)", current_pc, next_pc);
        if (current_pc != 32'h00000004) $finish;
        #5;

        next_pc = 32'h00000010;
        $display("Test 5 current_pc: 0x%x, next_pc: 0x%x (expected current_pc: 0x00000004)", current_pc, next_pc);
        if (current_pc != 32'h00000004) $finish;
        #10;

        next_pc = 32'hfffffffc;
        $display("Test 6 current_pc: 0x%x, next_pc: 0x%x (expected current_pc: 0x00000010)", current_pc, next_pc);
        if (current_pc != 32'h00000010) $finish;
        #20;

        next_pc = 32'h00000000;
        $display("Test 7 current_pc: 0x%x, next_pc: 0x%x (expected current_pc: 0xfffffffc)", current_pc, next_pc);
        if (current_pc != 32'hfffffffc) $finish;
        #10;

        $display("All tests passed");
        #10;
        $finish;
    end
endmodule