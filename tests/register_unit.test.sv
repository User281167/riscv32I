`timescale 1ns/1ns

module test_register_unit;
    logic clk;
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;
    logic [31:0] write_data;
    logic write_en;
    logic [31:0] rs1_data;
    logic [31:0] rs2_data;

    int half_period = 10;
    int period = 20;

    register_unit utt (
        .clk(clk),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_data),
        .write_en(write_en),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    initial begin
        $dumpfile("register_unit.vcd");
        $dumpvars(0, test_register_unit);

        #1000 #period $finish;
    end

    initial begin
        clk = 0;

        forever begin
             #half_period;
             clk = ~clk;
        end
    end

    initial begin
        // check that all registers are initialized to 0
        for (integer i = 0; i < 32; i = i + 1) begin
            if (utt.registers[i] !== 0) begin
                $display("Register %d is not initialized to 0", i);
                #period $finish;
            end
        end
    end

    initial begin
        #half_period;
        write_en = 1;
        rd = 3;
        write_data = 1;

        #period
        rd = 5;
        write_data = 32'h00000064;

        #period
        rd = 8;
        write_data = 32'h000002b3;

        #half_period
        rd = 25;
        write_data = 32'h02060063;

        #half_period
        rd = 31;
        write_data = 32'hffffffff;

        #period
        rd = 0;
        write_data = 32'h00000064;
        write_en = 0;

        #period
        rd = 10;
        write_data = 32'hcccccccc;

        #period
        rs1 = 3;
        rs2 = 5;
        #period

        if (rs1_data != 1 || rs2_data != 32'h00000064) begin
            $display("Test 1 Failed: rs1: 0x%x, rs2: 0x%x (expected rs1: 0x%x, rs2: 0x%x)", rs1_data, rs2_data, 1, 100);
            #period $finish;
        end

        #period
        rs1 = 8;
        rs2 = 25;
        #period

        if (rs1_data != 32'h000002b3 || rs2_data != 32'h00000000) begin
            $display("Test 2 Failed: rs1: 0x%x, rs2: 0x%x (expected rs1: 0x%x, rs2: 0x%x)", rs1_data, rs2_data, 32'h000002b3, 0);
            #period $finish;
        end

        #period
        rs1 = 25;
        rs2 = 31;
        #period

        if (rs1_data != 0 || rs2_data != 32'hffffffff) begin
            $display("Test 3 Failed: rs1: 0x%x, rs2: 0x%x (expected rs1: 0x%x, rs2: 0x%x)", rs1_data, rs2_data, 0, 32'hffffffff);
            #period $finish;
        end

        #period
        rs1 = 0;
        rs2 = 10;
        #period

        if (rs1_data != 0 || rs2_data != 0) begin
            $display("Test 4 Failed: rs1: 0x%x, rs2: 0x%x (expected rs1: 0x%x, rs2: 0x%x)", rs1_data, rs2_data, 0, 0);
            #period $finish;
        end

        #period $finish;
    end
endmodule