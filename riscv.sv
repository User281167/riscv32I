`include "modules/sum_4.sv"
`include "modules/program_counter.sv"

module riscv(
    input logic clk
);
    logic [31:0] next_pc;
    logic [31:0] pc;

    sum_4 _sum4 (
        pc,
        next_pc
    );

    program_counter _pc (
        clk,
        next_pc,
        pc
    );
endmodule