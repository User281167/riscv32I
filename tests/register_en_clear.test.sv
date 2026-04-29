`timescale 1ns/1ns

module test_register_en_clear;
    logic clk;
    logic enable;
    logic clear;
    logic [31:0] data_save;
    logic [31:0] data_out;

    int half_period = 10;
    int period = 20;
    int expected = 0;

    register_en_clear utt (
        .clk(clk),
        .enable(enable),
        .clear(clear),
        .data_save(data_save),
        .data_out(data_out)
    );

    initial begin
        $dumpfile("register_en_clear.vcd");
        $dumpvars(0, test_register_en_clear);
    end

    initial begin
        clk = 0;

        forever begin
             #half_period;
             clk = ~clk;
        end
    end

    initial begin
        #period
        #half_period
        data_save = 32'h00000000;
        expected = 32'h0000000;
        enable = 1;
        clear = 0;
        #period

        if (data_out != expected) begin
            $display("Test 1 Failed: data_out: 0x%x (expected data_out: 0x%x)", data_out, expected);
            #period $finish;
        end

        data_save = 189;
        enable = 0;
        #period

        if (data_out != expected) begin
            $display("Test 2 Failed: data_out: 0x%x (expected data_out: 0x%x)", data_out, expected);
            #period $finish;
        end

        enable = 1;
        expected = 189;
        #period

        if (data_out != expected) begin
            $display("Test 3 Failed: data_out: 0x%x (expected data_out: 0x%x)", data_out, expected);
            #period $finish;
        end

        clear = 1;
        expected = 0;
        #period

        if (data_out != expected) begin
            $display("Test 4 Failed: data_out: 0x%x (expected data_out: 0x%x)", data_out, expected);
            #period $finish;
        end

        expected = 189;
        clear = 0;
        #period

        if (data_out != expected) begin
            $display("Test 5 Failed: data_out: 0x%x (expected data_out: 0x%x)", data_out, expected);
            #period $finish;
        end

        #period $finish;
    end
endmodule