`timescale 1ns/1ns

module imm_generate_test();
    logic [24:0] imm;
    logic [2:0] imm_type;
    logic [31:0] imm_out;
    int period = 10;
    int expected;

    imm_generate imm_gen(imm, imm_type, imm_out);

    initial begin
        $dumpfile("imm_generate.vcd");
        $dumpvars(0, imm_generate_test);
    end

    initial begin
        // instruction I
        imm = 25'b0000100110100000000000000;
        imm_type = 3'b000;
        expected = 154;
        #period

        if (imm_out != expected) begin
            $display("Test 1 Failed: imm_out: 0x%x (expected imm_out: 0x%x)", imm_out, expected);
            $finish;
        end

        imm = 25'b1111011001100000000000000;
        imm_type = 3'b000;
        expected = -154;
        #period

        if (imm_out != expected) begin
            $display("Test 2 Failed: imm_out: 0x%x (expected imm_out: 0x%x)", imm_out, expected);
            $finish;
        end

        // intruction S
        imm = 25'b0000100000000000000011010;
        imm_type = 3'b001;
        expected = 154;
        #period

        if (imm_out != expected) begin
            $display("Test 3 Failed: imm_out: 0x%x (expected imm_out: 0x%x)", imm_out, expected);
            $finish;
        end

        imm = 25'b1111011111111111111100110;
        imm_type = 3'b001;
        expected = -154;
        #period

        if (imm_out != expected) begin
            $display("Test 3 Failed: imm_out: 0x%x (expected imm_out: 0x%x)", imm_out, expected);
            $finish;
        end

        // instruction B
        imm = 25'b0000100000000000000011010;
        imm_type = 3'b101;
        expected = 154;
        #period

        if (imm_out != expected) begin
            $display("Test 4 Failed: imm_out: 0x%x (expected imm_out: 0x%x)", imm_out, expected);
            $finish;
        end

        imm = 25'b1111011111111111101100111;
        imm_type = 3'b101;
        expected = -154;
        #period

        if (imm_out != expected) begin
            $display("Test 5 Failed: imm_out: 0x%x (expected imm_out: 0x%x)", imm_out, expected);
            $finish;
        end

        // instruction U
        imm = 20'h7FFFF;
        imm_type = 3'b010;
        expected = 32'h7FFFF000;
        #period

        if (imm_out != expected) begin
            $display("Test 6 Failed: imm_out: 0x%x (expected imm_out: 0x%x)", imm_out, expected);
            $finish;
        end

        imm = 20'h80000;
        imm_type = 3'b010;
        expected = 32'h80000000;
        #period

        if (imm_out != expected) begin
            $display("Test 7 Failed: imm_out: 0x%x (expected imm_out: 0x%x)", imm_out, expected);
            $finish;
        end

        // instruction J
        imm = 25'b0000100110100000000000000;
        imm_type = 3'b110;
        expected = 154;
        #period

        if (imm_out != expected) begin
            $display("Test 8 Failed: imm_out: 0x%x (expected imm_out: 0x%x)", imm_out, expected);
            $finish;
        end

        imm = 25'b1111011001111111111100110;
        imm_type = 3'b110;
        expected = -154;
        #period

        if (imm_out != expected) begin
            $display("Test 9 Failed: imm_out: 0x%x (expected imm_out: 0x%x)", imm_out, expected);
            $finish;
        end

        $display("All tests passed");
    end
endmodule