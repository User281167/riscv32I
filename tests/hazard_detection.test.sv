module test_hazard_detection;
    logic check;
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;
    logic stall;

    int period = 10;
    logic expected;

    hazard_detection utt(
        .check(check),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .stall(stall)
    );

    initial begin
        $dumpfile("hazard_detection.vcd");
        $dumpvars(0, test_hazard_detection);
    end

    initial begin
        check = 0;
        rs1 = 0;
        rs2 = 0;
        rd = 0;
        expected = 0;
        #period

        if (stall != expected) begin
            $display("ERROR Test 1: Expected %b, got %b", expected, stall);
            $finish;
        end

        check = 1;
        rs1 = 0;
        rs2 = 0;
        rd = 0;
        expected = 1;
        #period

        if (stall != expected) begin
            $display("ERROR Test 2: Expected %b, got %b", expected, stall);
            $finish;
        end

        check = 1;
        rs1 = 0;
        rs2 = 0;
        rd = 1;
        expected = 0;
        #period

        if (stall != expected) begin
            $display("ERROR Test 3: Expected %b, got %b", expected, stall);
            $finish;
        end

        check = 1;
        rs1 = 0;
        rs2 = 1;
        rd = 0;
        expected = 1;
        #period

        if (stall != expected) begin
            $display("ERROR Test 4: Expected %b, got %b", expected, stall);
            $finish;
        end

        check = 1;
        rs1 = 0;
        rs2 = 1;
        rd = 1;
        expected = 1;
        #period

        if (stall != expected) begin
            $display("ERROR Test 5: Expected %b, got %b", expected, stall);
            $finish;
        end

        #period $finish;
    end
endmodule