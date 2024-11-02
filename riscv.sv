`include "modules/sum_4.sv"
`include "modules/program_counter.sv"
`include "modules/instruction_memory.sv"

`include "modules/control_unit.sv"
`include "modules/register_unit.sv"
`include "modules/imm_generate.sv"

`include "modules/mux_2.sv"
`include "modules/alu.sv"
`include "modules/branch_unit.sv"

`include "modules/data_memory.sv"
`include "modules/mux_3.sv"

module riscv(
    input logic clk
);
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

    always_comb begin
        if (instruction == 0) $finish;
    end

    // fetch
    sum_4 _sum4 (
        .current_pc(pc),
        .next_pc(pc_4)
    );

    program_counter _pc (
        .clk(clk),
        .next_pc(next_pc),
        .current_pc(pc)
    );

    instruction_memory _i_mem (
        .address(pc),
        .instruction(instruction)
    );

    // decode
    control_unit _control_unit(
        .opcode(instruction[6:0]),
        .funct3(instruction[14:12]),
        .funct7(instruction[31:25]),
        .register_write_en(register_write_en),
        .imm_src(imm_src),
        .alu_a(alu_a),
        .alu_b(alu_b),
        .alu_op(alu_op),
        .branch_op(branch_op),
        .data_write_en(data_write_en),
        .dm_control(dm_control),
        .rd_data(rd_data)
    );

    register_unit _reg_unit(
        .clk(clk),
        .rs1(instruction[19:15]),
        .rs2(instruction[24:20]),
        .rd(instruction[11:7]),
        .write_data(write_rd_data),
        .write_en(register_write_en),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    imm_generate _imm_gen(
        .imm(instruction[31:7]),
        .imm_type(imm_src),
        .imm_out(imm)
    );

    // execute
    mux_2 _alu_a(
        .a(rs1_data),
        .b(pc),
        .sel(alu_a),
        .mux_out(a)
    );

    mux_2 _alu_b(
        .a(rs2_data),
        .b(imm),
        .sel(alu_b),
        .mux_out(b)
    );

    alu _alu(
        .a(a),
        .b(b),
        .alu_op(alu_op),
        .alu_out(alu_out)
    );

    branch_unit _branch_unit(
        .a(rs1_data),
        .b(rs2_data),
        .branch_op(branch_op),
        .branch_out(branch_out)
    );

    // memory
    data_memory _data_mem(
        .write_en(data_write_en),
        .dm_control(dm_control),
        .address(alu_out),
        .write_data(rs2_data),
        .read_data(read_data)
    );

    // write back
    mux_2 _next_pc(
        .a(pc_4),
        .b(alu_out),
        .sel(branch_out),
        .mux_out(next_pc)
    );

    mux_3 _rd_data(
        .a(alu_out),
        .b(read_data),
        .c(pc_4),
        .sel(rd_data),
        .mux_out(write_rd_data)
    );
endmodule