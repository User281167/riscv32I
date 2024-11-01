module test_data_memory();
    logic [31:0] address;
    logic [31:0] write_data;
    logic [2:0] dm_control;
    logic write_en;
    logic [31:0] read_data;
    int period = 10;
    int expected;

    data_memory uut(
        .write_en(write_en),
        .dm_control(dm_control),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)
    );

    initial begin
        $dumpfile("data_memory.vcd");
        $dumpvars(0, test_data_memory);
    end

    initial begin
        // load byte
        write_en = 0;
        dm_control = 3'b000;
        address = 32'h00000000;
        expected = 32'h00;
        #period;

        if (read_data != expected) begin
            $display("Test 0 Failed: read_data: 0x%x (expected read_data: 0x%x)", read_data, expected);
            $finish;
        end

        // storage byte
        write_en = 1;
        dm_control = 3'b000;
        address = 32'h00000000;
        write_data = 32'h000f83;
        #period;

        write_en = 0;
        expected = 32'hffffff83;
        #period;

        if (read_data != expected) begin
            $display("Test 1 Failed: read_data: 0x%x (expected read_data: 0x%x)", read_data, expected);
            $finish;
        end

        dm_control = 3'b100; // load unsigned byte
        expected = 32'h000083;
        #period;

        if (read_data != expected) begin
            $display("Test 2 Failed: read_data: 0x%x (expected read_data: 0x%x)", read_data, expected);
            $finish;
        end


        // storage halfword
        write_en = 1;
        dm_control = 3'b001;
        address = 32'h00000005;
        write_data = 32'h00001194;
        #period;

        address = 32'h0000000A;
        write_data = 32'h0000f94f;
        #period;

        // load halfword
        write_en = 0;
        address = 32'h00000005;
        expected = 32'h00001194;
        #period;

        if (read_data != expected) begin
            $display("Test 3 Failed: read_data: 0x%x (expected read_data: 0x%x)", read_data, expected);
            $finish;
        end

        dm_control = 3'b101;
        expected = 32'h00001194;
        #period;

        if (read_data != expected) begin
            $display("Test 4 Failed: read_data: 0x%x (expected read_data: 0x%x)", read_data, expected);
            $finish;
        end

        dm_control = 3'b001;
        address = 32'h0000000A;
        expected = 32'hfffff94f;
        #period;

        if (read_data != expected) begin
            $display("Test 5 Failed: read_data: 0x%x (expected read_data: 0x%x)", read_data, expected);
            $finish;
        end

        dm_control = 3'b101;
        expected = 32'h0000f94f;
        #period;

        if (read_data != expected) begin
            $display("Test 6 Failed: read_data: 0x%x (expected read_data: 0x%x)", read_data, expected);
            $finish;
        end

        // storage word
        write_en = 1;
        dm_control = 3'b010;
        address = 32'h0000000A;
        write_data = 32'h0fffffff;
        #period;

        address = 32'h000000F0;
        write_data = 32'hfffffffc;
        #period;

        // load word
        write_en = 0;
        address = 32'h0000000A;
        expected = 32'h0fffffff;
        #period;

        if (read_data != expected) begin
            $display("Test 7 Failed: read_data: 0x%x (expected read_data: 0x%x)", read_data, expected);
            $finish;
        end

        address = 32'h000000F0;
        expected = 32'hfffffffc;
        #period;

        if (read_data != expected) begin
            $display("Test 8 Failed: read_data: 0x%x (expected read_data: 0x%x)", read_data, expected);
            $finish;
        end

        #period $finish;
    end
endmodule