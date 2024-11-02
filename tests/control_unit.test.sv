module test_control_unit;
    logic [6:0] opcode;
    logic [2:0] funct3;
    logic [6:0] funct7;

    logic register_write_en;
    logic [2:0] imm_src;
    logic alu_a;
    logic alu_b;
    logic [3:0] alu_op;
    logic [4:0] branch_op;
    logic data_write_en;
    logic [2:0] dm_control;
    logic [1:0] rd_data;

    int half_period = 10;
    int period = 20;

    control_unit uut (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
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

    initial begin
        $dumpfile("control_unit.vcd");
        $dumpvars(0, test_control_unit);
    end

    initial begin
        // check sum controls
        opcode = 7'b0110011;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        #period;

        if (
            register_write_en != 1 ||
            imm_src != 3'bxxx ||
            alu_a != 0 ||
            alu_b != 0 ||
            alu_op != 4'b0000 ||
            branch_op != 5'b00xxx ||
            data_write_en != 0 ||
            dm_control != 3'bxxx ||
            rd_data != 2'b00
        ) begin
            $display("Sum controls failed");
            $finish;
        end

        // check sub controls
        opcode = 7'b0110011;
        funct3 = 3'b000;
        funct7 = 7'h20;
        #period;

        if (
            register_write_en != 1 ||
            imm_src != 3'bxxx ||
            alu_a != 0 ||
            alu_b != 0 ||
            alu_op != 4'b1000 ||
            branch_op != 5'b00xxx ||
            data_write_en != 0 ||
            dm_control != 3'bxxx ||
            rd_data != 2'b00
        ) begin
            $display("Sub controls failed");
            $finish;
        end

        // check addi controls
        opcode = 7'b0010011;
        funct3 = 3'b000;
        funct7 = 7'hxx;
        #period;

        if (
            register_write_en != 1 ||
            imm_src != 3'b000 ||
            alu_a != 0 ||
            alu_b != 1 ||
            alu_op != 4'b0000 ||
            branch_op != 5'b00xxx ||
            data_write_en != 0 ||
            dm_control != 3'bxxx ||
            rd_data != 2'b00
        ) begin
            $display("Addi controls failed");
            $finish;
        end

        // check load byte
        opcode = 7'b0000011;
        funct3 = 3'b000;
        funct7 = 7'hxx;
        #period;

        if (
            register_write_en != 1 ||
            imm_src != 3'b000 ||
            alu_a != 0 ||
            alu_b != 1 ||
            alu_op != 4'b0000 ||
            branch_op != 5'b00xxx ||
            data_write_en != 0 ||
            dm_control != 3'b000 ||
            rd_data != 2'b01
        ) begin
            $display("Load byte controls failed");
            $finish;
        end

        // check load halfword unsigned
        opcode = 7'b0000011;
        funct3 = 3'h5;
        funct7 = 7'h23;
        #period;

        if (
            register_write_en != 1 ||
            imm_src != 3'b000 ||
            alu_a != 0 ||
            alu_b != 1 ||
            alu_op != 4'b0000 ||
            branch_op != 5'b00xxx ||
            data_write_en != 0 ||
            dm_control != 3'b101 ||
            rd_data != 2'b01
        ) begin
            $display("Load halfword unsigned controls failed");
            $finish;
        end

        // check storage word
        opcode = 7'b0100011;
        funct3 = 3'h2;
        funct7 = 7'h43;
        #period;

        if (
            register_write_en != 0 ||
            imm_src != 3'b001 ||
            alu_a != 0 ||
            alu_b != 1 ||
            alu_op != 4'b0000 ||
            branch_op != 5'b00xxx ||
            data_write_en != 1 ||
            dm_control != 3'b010 ||
            rd_data != 2'bxx
        ) begin
            $display("Storage word controls failed");
            $finish;
        end

        // check beq
        opcode = 7'b1100011;
        funct3 = 3'h0;
        funct7 = 7'hf;
        #period;

        if (
            register_write_en != 0 ||
            imm_src != 3'b101 ||
            alu_a != 1 ||
            alu_b != 1 ||
            alu_op != 4'b0000 ||
            branch_op != 5'b01000 ||
            data_write_en != 0 ||
            dm_control != 3'bxxx ||
            rd_data != 2'bxx
        ) begin
            $display("Beq controls failed");
            $finish;
        end

        // check bgeu
        opcode = 7'b1100011;
        funct3 = 3'h7;
        funct7 = 7'hf;
        #period;

        if (
            register_write_en != 0 ||
            imm_src != 3'b101 ||
            alu_a != 1 ||
            alu_b != 1 ||
            alu_op != 4'b0000 ||
            branch_op != 5'b01111 ||
            data_write_en != 0 ||
            dm_control != 3'bxxx ||
            rd_data != 2'bxx
        ) begin
            $display("Bgeu controls failed");
            $finish;
        end

        // check jal
        opcode = 7'b1101111;
        funct3 = 3'hx;
        funct7 = 7'hf;
        #period;

        if (
            register_write_en != 1 ||
            imm_src != 3'b110 ||
            alu_a != 1 ||
            alu_b != 1 ||
            alu_op != 4'b0000 ||
            branch_op != 5'b1xxxx ||
            data_write_en != 0 ||
            dm_control != 3'bxxx ||
            rd_data != 2'b10
        ) begin
            $display("Jal controls failed");
            $finish;
        end

        // check jalr
        opcode = 7'b1100111;
        funct3 = 3'h0;
        funct7 = 7'hx;
        #period;

        if (
            register_write_en != 1 ||
            imm_src != 3'b000 ||
            alu_a != 0 ||
            alu_b != 1 ||
            alu_op != 4'b0000 ||
            branch_op != 5'b1xxxx ||
            data_write_en != 0 ||
            dm_control != 3'bxxx ||
            rd_data != 2'b00
        ) begin
            $display("Jalr controls failed");
            $display("%x %x %x %x %x %x %x %x %x", register_write_en, imm_src, alu_a, alu_b, alu_op, branch_op, data_write_en, dm_control, rd_data);
            $finish;
        end

        #period $finish;
    end
endmodule