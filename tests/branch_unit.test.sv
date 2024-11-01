module test_branch_unit();
    logic [31:0] a;
    logic [31:0] b;
    logic [4:0] branch_op;
    logic branch_out;
    int period = 10;

    branch_unit uut(
        .a(a),
        .b(b),
        .branch_op(branch_op),
        .branch_out(branch_out)
    );

    initial begin
        $dumpfile("branch_unit.vcd");
        $dumpvars(0, test_branch_unit);
    end

    initial begin
        a = 32'h00000000;
        b = 32'h00000000;
        branch_op = 5'b01000;
        #period;

        if (branch_out != 1) begin
            $display("Test 1 (==) failed");
            $finish;
        end

        a = 32'h00000001;
        b = 32'h00000000;
        #period;

        if (branch_out != 0) begin
            $display("Test 2 (==) failed");
            $finish;
        end

        a = 32'hffffff9c;
        b = 32'hffffff9c;
        #period;

        if (branch_out != 1) begin
            $display("Test 3 (==) failed");
            $finish;
        end

        branch_op = 5'b01001;
        #period;

        if (branch_out != 0) begin
            $display("Test 4 (!=) failed");
            $finish;
        end

        a = 32'h00000001;
        b = 32'h00000000;
        #period;

        if (branch_out != 1) begin
            $display("Test 5 (!=) failed");
            $finish;
        end

        a = 32'h00000001;
        b = 32'h00000001;
        branch_op = 5'b01100;
        #period;

        if (branch_out != 0) begin
            $display("Test 6 (<) failed");
            $finish;
        end

        a = 32'h00000000;
        b = 32'h00000001;
        #period;

        if (branch_out != 1) begin
            $display("Test 7 (<) failed");
            $finish;
        end

        a = 32'hffffff9c; // -100
        b = 32'h00000032; // 50
        #period;

        if (branch_out != 1) begin
            $display("Test 8 (<) failed");
            $finish;
        end

        a = 32'h00000000;
        b = 32'h00000001;
        branch_op = 5'b01101;
        #period;

        if (branch_out != 0) begin
            $display("Test 9 (>=) failed");
            $finish;
        end

        a = 32'h00000002;
        b = 32'h00000001;
        #period;

        if (branch_out != 1) begin
            $display("Test 10 (>=) failed");
            $finish;
        end

        a = 32'hffffff9c;
        b = 32'h00000032;
        #period;

        if (branch_out != 0) begin
            $display("Test 11 (>=) failed");
            $finish;
        end

        a = 32'h00000032;
        b = 32'hffffff9c;
        #period;

        if (branch_out != 1) begin
            $display("Test 12 (>=) failed");
            $finish;
        end

        a = 32'h00000032;
        b = 32'hffffff9c;
        branch_op = 5'b01110;
        #period;

        if (branch_out != 1) begin
            $display("Test 13 (< U) failed");
            $finish;
        end

        a = 32'h00000032;
        b = 32'hffffff9c;
        branch_op = 5'b01111;
        #period;

        if (branch_out != 0) begin
            $display("Test 14 (>= U) failed");
            $finish;
        end

        a = 32'hffffff9c;
        b = 32'h00000032;
        #period;

        if (branch_out != 1) begin
            $display("Test 15 (>= U) failed");
            $finish;
        end

        branch_op = 5'b1xxxx;
        #period;

        if (branch_out != 1) begin
            $display("Test 16 (1) failed");
            $finish;
        end

        branch_op = 5'b10011;
        #period;

        if (branch_out != 1) begin
            $display("Test 17 (1) failed");
            $finish;
        end

        branch_op = 5'b00xxx;
        #period;

        if (branch_out != 0) begin
            $display("Test 18 (0) failed");
            $finish;
        end

        #period $finish;
    end
endmodule