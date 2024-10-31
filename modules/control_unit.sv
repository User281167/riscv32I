module control_unit(
    input logic [6:0] opcode,
    input logic [2:0] funct3,
    input logic [6:0] funct7,
    output logic register_write_en,
    output logic [2:0] imm_src,
    output logic alu_a,
    output logic alu_b,
    output logic [3:0] alu_op,
    output logic [4:0] branch_op,
    output logic data_write_en,
    output logic [2:0] dm_control,
    output logic [1:0] rd_data
);
    always @(*) begin
        // instruction type R
        if (opcode == 7'b0110011) begin
            register_write_en = 1;
            imm_src = 3'bxxx;

            alu_a = 0;
            alu_b = 0;
            branch_op = 5'bxxxxx;

            data_write_en = 0;
            dm_control = 3'bxxx;
            rd_data = 0;

            if (funct7 == 7'h00) begin
                case (funct3)
                    3'h0: begin
                        alu_op = 4'b0000; // add
                    end
                    3'h4: begin
                        alu_op = 4'b0100; // xor
                    end
                    3'h6: begin
                        alu_op = 4'b0110; // or
                    end
                    3'h7: begin
                        alu_op = 4'b0111; // and
                    end
                    3'h1: begin
                        alu_op = 4'b0001; // sll
                    end
                    3'h5: begin
                        alu_op = 4'b0101; // srl
                    end
                    3'h2: begin
                        alu_op = 4'b0010; // slt
                    end
                    3'h3: begin
                        alu_op = 4'b0011; // sltu
                    end
                endcase
            end

            if (funct7 == 7'h20) begin
                case (funct3)
                    3'h0: begin
                        alu_op = 4'b1000; // sub
                    end
                    3'h4: begin
                        alu_op = 4'b1101; // sra
                    end
                endcase
            end
        end

        // instruction type I
        if (opcode == 7'b0010011) begin
            register_write_en = 1;
            imm_src = 3'b000;

            alu_a = 0;
            alu_b = 1;
            branch_op = 5'bxxxxx;

            data_write_en = 0;
            dm_control = 3'bxxx;
            rd_data = 0;

            case (funct3)
                3'h0: begin
                    alu_op = 4'b0000; // addi
                end
                3'h4: begin
                    alu_op = 4'b0100; // xori
                end
                3'h6: begin
                    alu_op = 4'b0110; // ori
                end
                3'h7: begin
                    alu_op = 4'b0111; // andi
                end
                3'h1: begin
                    alu_op = 4'b0001; // slli
                end
                3'h5: begin
                    alu_op = 4'b0101; // srli
                end
                3'h5: begin
                    alu_op = 4'b1101; // srai
                end
                3'h2: begin
                    alu_op = 4'b0010; // slti
                end
                3'h3: begin
                    alu_op = 4'b0011; // sltiu
                end
            endcase
        end

        // instruction type Load
        if (opcode == 7'b0000011) begin
            register_write_en = 1;
            imm_src = 3'b000;

            alu_a = 0;
            alu_b = 1;
            alu_op = 4'b0000;
            branch_op = 5'bxxxxx;

            data_write_en = 0;
            rd_data = 2'b01;

            case (funct3)
                3'h0: begin
                    dm_control = 3'b000; // load byte
                end
                3'h1: begin
                    dm_control = 3'b001; // load halfword
                end
                3'h2: begin
                    dm_control = 3'b010; // load word
                end
                3'h4: begin
                    dm_control = 3'b100; // load byte unsigned
                end
                3'h5: begin
                    dm_control = 3'b101; // load halfword unsigned
                end
            endcase
        end

        // instruction type S
        if (opcode == 7'b0100011) begin
            register_write_en = 0;
            imm_src = 3'b001;

            alu_a = 0;
            alu_b = 1;
            alu_op = 4'b0000;
            branch_op = 5'bxxxxx;

            data_write_en = 1;
            rd_data = 2'bxx;

            case (funct3)
                3'h0: begin
                    dm_control = 3'b000; // store byte
                end
                3'h1: begin
                    dm_control = 3'b001; // store halfword
                end
                3'h2: begin
                    dm_control = 3'b010; // store word
                end
            endcase
        end

        // instruction type B
        if (opcode == 7'b1100011) begin
            register_write_en = 0;
            imm_src = 3'b101;

            alu_a = 1;
            alu_b = 1;
            alu_op = 4'b0000;

            data_write_en = 0;
            dm_control = 3'bxxx;
            rd_data = 2'bxx;

            case (funct3)
                3'h0: begin
                    branch_op = 5'b01000; // beq
                end
                3'h1: begin
                    branch_op = 5'b01001; // bnq
                end
                3'h4: begin
                    branch_op = 5'b01100; // blt
                end
                3'h5: begin
                    branch_op = 5'b01101; // bge
                end
                3'h6: begin
                    branch_op = 5'b01110; // bltu
                end
                3'h7: begin
                    branch_op = 5'b01111; // bgeu
                end
                3'h7: begin
                    branch_op = 5'b00xxx; // beq0
                end
                3'h7: begin
                    branch_op = 5'b1xxxx; // beq1
                end
            endcase
        end

        // instruction type U lui
        if (opcode == 7'b0110111) begin
            register_write_en = 1;
            imm_src = 3'b010;
            // falta agregar un multiplexor a la alu
            alu_a = 0;
            alu_b = 1;
            alu_op = 4'b0000;

            data_write_en = 0;
            dm_control = 3'bxxx;
            rd_data = 2'bxx;
        end

        // instruction type J jal
        if (opcode == 7'b1101111) begin
            register_write_en = 1;
            imm_src = 3'b110;

            alu_a = 1;
            alu_b = 1;
            alu_op = 4'b0000;

            data_write_en = 0;
            dm_control = 3'bxxx;
            rd_data = 2'b10;

            branch_op = 5'b11111;
        end

        // instruction type J jalr
        if (opcode == 7'b1100111) begin
            register_write_en = 1;
            imm_src = 3'b000;

            alu_a = 0;
            alu_b = 1;
            alu_op = 4'b0000;

            data_write_en = 0;
            dm_control = 3'bxxx;
            rd_data = 2'b10;

            case (funct3)
                3'h0: begin
                    branch_op = 5'b11111;
                end
            endcase
        end
    end
endmodule