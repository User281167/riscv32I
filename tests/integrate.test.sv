module test_integrate;
    logic clk;
    int half_period = 10;
    int period = 20;

    // fetch
    logic [31:0] next_pc, pc_4, pc, instruction;

    // decode
    logic register_write_en;
    logic [2:0] imm_src;
    logic alu_a;
    logic alu_b;
    logic [3:0] alu_op;
    logic [4:0] branch_op;
    logic data_write_en;
    logic [2:0] dm_control;
    logic [1:0] rd_data;

    logic [31:0] rs1_data, rs2_data;
    logic [31:0] imm;

    // execute
    logic [31:0] a, b, alu_out;
    logic branch_out;

    // memory
    logic [31:0] read_data;

    // write back
    logic [31:0] write_rd_data;

    begin
        $dumpfile("integrate.vcd");
        $dumpvars(0, test_integrate);

        #1000 $finish;
    end

    initial begin
        clk = 0;

        forever begin
             #period
             clk = ~clk;
        end
    end

    // fetch
    sum_4 _sum4 (
        .current_pc(pc),
        .next_pc(pc_4)
    );

    program_counter _pc (
        .clk(clk),
        .next_pc(pc_4),
        .current_pc(pc)
    );
endmodule;