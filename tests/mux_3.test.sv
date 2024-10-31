module test_mux_3;
    logic [31:0] a;
    logic [31:0] b;
    logic [31:0] c;
    logic [1:0] sel;
    logic [31:0] out_mux;
    int period = 10;

    mux_3 utt(
        .a(a),
        .b(b),
        .c(c),
        .sel(sel),
        .out_mux(out_mux)
    );

    initial begin
        $dumpfile("mux_3.vcd");
        $dumpvars(0, test_mux_3);
    end

    initial begin
        a = 32'h00000000;
        b = 32'hffffffff;
        c = 32'haaaaaaaa;
        sel = 2'b00;
        #period;

        if (out_mux != a) begin
            $display("Test 1 failed");
            $finish;
        end

        sel = 2'b01;
        #period;

        if (out_mux != b) begin
            $display("Test 2 failed");
            $finish;
        end

        sel = 2'b10;
        #period;

        if (out_mux != c) begin
            $display("Test 3 failed");
            $finish;
        end

        #period $finish;
    end
endmodule