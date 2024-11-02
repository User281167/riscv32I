`timescale 1ns/1ns

module test_riscv;
    logic clk;
    int period = 10;
    int time_run = 2000;

    riscv utt(
        .clk(clk)
    );

    initial begin
        $dumpfile("riscv.vcd");
        $dumpvars(0, test_riscv);

        #time_run $finish;
    end

    initial begin
        clk = 1;

        forever begin
            #10 clk = ~clk;
        end
    end
endmodule