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
        // storage memory
        write_en = 1;
        dm_control = 3'b010;
        address = 32'h00000000;
        write_data = 32'h000fff;
        #period;

        // storage in memory
        write_en = 1;
        dm_control = 3'b000;
        address = 32'h00000005;
        write_data = 32'h000fff;
        #period;

        // load memory
        write_en = 0;
        dm_control = 3'b010;
        address = 32'h00000000;
        expected = 32'h000fff;
        #period;

        if (read_data != expected) begin
            $display("Test 1 Failed: read_data: 0x%x (expected read_data: 0x%x)", read_data, expected);
            $finish;
        end

        // load in memory
        write_en = 0;
        dm_control = 3'b000;
        address = 32'h00000005;
        expected = 32'hffffffff;
        #period;

        if (read_data != expected) begin
            $display("Test 2 Failed: read_data: 0x%x (expected read_data: 0x%x)", read_data, expected);
            $finish;
        end

        #period $finish;
    end
endmodule