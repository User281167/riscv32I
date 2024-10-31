module test_mux_2();
    logic [31:0] a, b;
    logic sel;
    logic [31:0] out_mux;
    int period = 10;

    mux_2 uut(
        .a(a),
        .b(b),
        .sel(sel),
        .out_mux(out_mux)
    );

    initial begin
        $dumpfile("mux_2.vcd");
        $dumpvars(0, test_mux_2);
    end

    initial begin
        a = 32'h00000000;
        b = 32'hffffffff;
        sel = 1'b1;
        #(period);

        if (out_mux != a) begin
            $display("Test 1 failed");
            $finish;
        end

        sel = 1'b0;
        #(period);

        if (out_mux != b) begin
            $display("Test 2 failed");
            $finish;
        end

        #period $finish;
    end
endmodule