`timescale 1ns/1ns

module test_forwarding_unit;
    logic [4:0] rs1_de;
    logic [4:0] rs2_de;
    logic write_en_me;
    logic write_en_wb;
    logic [4:0] rd_me;
    logic [4:0] rd_wb;
    logic [1:0] alu_a_sel;
    logic [1:0] alu_b_sel;

    int period = 10;
    int expected_a;
    int expected_b;

    forwarding_unit uut (
        .rs1_de(rs1_de),
        .rs2_de(rs2_de),
        .write_en_me(write_en_me),
        .write_en_wb(write_en_wb),
        .rd_me(rd_me),
        .rd_wb(rd_wb),
        .alu_a_sel(alu_a_sel),
        .alu_b_sel(alu_b_sel)
    );

    initial begin
        $dumpfile("forwarding_unit.vcd");
        $dumpvars(0, test_forwarding_unit);
    end

    initial begin
        rs1_de = 0;
        rs2_de = 0;
        write_en_me = 0;
        write_en_wb = 0;
        rd_me = 0;
        rd_wb = 0;
        expected_a = 0;
        expected_b = 0;
        #period;

        if (alu_a_sel != expected_a || alu_b_sel != expected_b) begin
            $display("Test 1 Failed: Expected alu_a_sel = %d, alu_b_sel = %d", expected_a, expected_b);
            #period $finish;
        end

        rs1_de = 1;
        rs2_de = 2;
        write_en_me = 1;
        write_en_wb = 0;
        rd_me = 3;
        rd_wb = 0;
        expected_a = 0;
        expected_b = 0;
        #period;

        if (alu_a_sel != expected_a || alu_b_sel != expected_b) begin
            $display("Test 2 Failed: Expected alu_a_sel = %d, alu_b_sel = %d, current alu_a_sel = %d, alu_b_sel = %d", expected_a, expected_b, alu_a_sel, alu_b_sel);
            #period $finish;
        end

        rs1_de = 4;
        rs2_de = 5;
        write_en_me = 0;
        write_en_wb = 1;
        rd_me = 0;
        rd_wb = 5;
        expected_a = 0;
        expected_b = 2;
        #period;

        if (alu_a_sel != expected_a || alu_b_sel != expected_b) begin
            $display("Test 3 Failed: Expected alu_a_sel = %d, alu_b_sel = %d, current alu_a_sel = %d, alu_b_sel = %d", expected_a, expected_b, alu_a_sel, alu_b_sel);
            #period $finish;
        end

        rs1_de = 7;
        rs2_de = 8;
        write_en_me = 1;
        write_en_wb = 1;
        rd_me = 10;
        rd_wb = 7;
        expected_a = 2;
        expected_b = 0;
        #period;

        if (alu_a_sel != expected_a || alu_b_sel != expected_b) begin
            $display("Test 4 Failed: Expected alu_a_sel = %d, alu_b_sel = %d, current alu_a_sel = %d, alu_b_sel = %d", expected_a, expected_b, alu_a_sel, alu_b_sel);
            #period $finish;
        end

        rs1_de = 11;
        rs2_de = 12;
        write_en_me = 0;
        write_en_wb = 0;
        rd_me = 0;
        rd_wb = 0;
        expected_a = 0;
        expected_b = 0;
        #period;

        if (alu_a_sel != expected_a || alu_b_sel != expected_b) begin
            $display("Test 5 Failed: Expected alu_a_sel = %d, alu_b_sel = %d, current alu_a_sel = %d, alu_b_sel = %d", expected_a, expected_b, alu_a_sel, alu_b_sel);
            #period $finish;
        end
    end
endmodule