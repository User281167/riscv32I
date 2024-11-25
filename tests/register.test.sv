`timescale 1ns/1ns

module test_register;
    logic clk;
    logic [31:0] data_save;
    logic [31:0] data_out;

    int half_period = 10;
    int period = 20;
    int expected = 0;

    register utt (
        .clk(clk),
        .data_save(data_save),
        .data_out(data_out)
    );

    initial begin
        $dumpfile("register.vcd");
        $dumpvars(0, test_register);
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
        #period

        if (data_out != expected) begin
            $display("Test 1 Failed: data_out: 0x%x (expected data_out: 0x%x)", data_out, expected);
            #period $finish;
        end

        #period
        data_save = 32'h000002b3;
        expected = 32'h000002b3;
        #period

        if (data_out != expected) begin
            $display("Test 2 Failed: data_out: 0x%x (expected data_out: 0x%x)", data_out, expected);
            #period $finish;
        end

        #period
        data_save = 32'h02060063;
        expected = 32'h02060063;
        #period

        if (data_out != expected) begin
            $display("Test 3 Failed: data_out: 0x%x (expected data_out: 0x%x)", data_out, expected);
            #period $finish;
        end

        #period
        data_save = 32'hffffffff;
        expected = 32'hffffffff;
        #period

        if (data_out != expected) begin
            $display("Test 4 Failed: data_out: 0x%x (expected data_out: 0x%x)", data_out, expected);
            #period $finish;
        end

        #period
        data_save = 32'h00000064;
        expected = 32'h00000064;
        #period

        if (data_out != expected) begin
            $display("Test 5 Failed: data_out: 0x%x (expected data_out: 0x%x)", data_out, expected);
            #period $finish;
        end

        #period
        data_save = 32'hcccccccc;
        expected = 32'hcccccccc;
        #period

        if (data_out != expected) begin
            $display("Test 6 Failed: data_out: 0x%x (expected data_out: 0x%x)", data_out, expected);
            #period $finish;
        end

        #period
        data_save = 32'h00000000;
        expected = 32'h00000000;
        #period

        if (data_out != expected) begin
            $display("Test 7 Failed: data_out: 0x%x (expected data_out: 0x%x)", data_out, expected);
            #period $finish;
        end

        #half_period;
        data_save = 32'h00000064;
        #half_period

        if (data_out != expected) begin
            $display("Test 8 Failed: data_out: 0x%x (expected data_out: 0x%x)", data_out, expected);
            #period $finish;
        end

        #half_period
        data_save = 32'h000002b3;
        expected = 32'h000002b3;
        #period

        if (data_out != expected) begin
            $display("Test 9 Failed: data_out: 0x%x (expected data_out: 0x%x)", data_out, expected);
            #period $finish;
        end

        #half_period
        data_save = 32'h02060063;
        expected = 32'h02060063;
        #half_period

        if (data_out != expected) begin
            $display("Test 10 Failed: data_out: 0x%x (expected data_out: 0x%x)", data_out, expected);
            #period $finish;
        end

        #period $finish;
    end
endmodule