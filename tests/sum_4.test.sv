`timescale 1ns/1ns

module test_sum_4;
    logic [31:0] current_pc;
    logic [31:0] next_pc;

    sum_4 utt (
        .current_pc(current_pc),
        .next_pc(next_pc)
    );

    initial begin
        $dumpfile("sum_4.vcd");
        $dumpvars(0, test_sum_4);
    end

    initial begin
        current_pc = 0;
        #10;
        $display("Test 1 current_pc: 0x%x, next_pc: 0x%x (expected next_pc: 0x00000004)", current_pc, next_pc);
        if (next_pc != 32'h00000004) $finish;

        current_pc = 32'h00000004;
        #10;
        $display("Test 2 current_pc: 0x%x, next_pc: 0x%x (expected next_pc: 0x00000008)", current_pc, next_pc);
        if (next_pc != 32'h00000008) $finish;

        current_pc = 32'h00000008;
        #10;
        $display("Test 3 current_pc: 0x%x, next_pc: 0x%x (expected next_pc: 0x0000000c)", current_pc, next_pc);
        if (next_pc != 32'h0000000c) $finish;

        current_pc = 32'h0000000c;
        #10;
        $display("Test 4 current_pc: 0x%x, next_pc: 0x%x (expected next_pc: 0x00000010)", current_pc, next_pc);
        if (next_pc != 32'h00000010) $finish;

        current_pc = 32'h00000000;
        #10;
        $display("Test 5 current_pc: 0x%x, next_pc: 0x%x (expected next_pc: 0x00000004)", current_pc, next_pc);
        if (next_pc != 32'h00000004) $finish;

        current_pc = 32'hfffffffc;
        #10;
        $display("Test 6 current_pc: 0x%x, next_pc: 0x%x (expected next_pc: 0x00000000)", current_pc, next_pc);
        if (next_pc != 32'h00000000) $finish;

        $display("All tests passed");
        #10 $finish;
    end
endmodule