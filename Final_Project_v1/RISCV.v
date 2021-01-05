// Your code

// definition of operations
parameter ADD_OP = 4'b0;
parameter SLL_OP = 4'b0001;
parameter SLT_OP = 4'b0010;
parameter XOR_OP = 4'b0100;
parameter SRL_OP = 4'b0101;
parameter  OR_OP = 4'b0110;
parameter AND_OP = 4'b0111;
parameter SUB_OP = 4'b1000;
parameter SRA_OP = 4'b1101;

module RISCV(clk,
            rst_n,
            // for mem_D
            mem_wen_D,
            mem_addr_D,
            mem_wdata_D,
            mem_rdata_D,
            // for mem_I
            mem_addr_I,
            mem_rdata_I);

    input clk, rst_n;
    output reg [31:2] mem_addr_I ;
    input  [31:0] mem_rdata_I    ;
    output mem_wen_D ;
    output reg [31:2] mem_addr_D; // address to data memory
    output reg [63:0] mem_wdata_D;
    input [63:0] mem_rdata_D;

    wire [11:0] control_signal;
    wire [3:0] alu_op  = control_signal[11:8]; // ALUOp
    wire reg_write = control_signal[6]; // RegWrite
    wire alu_src = control_signal[7]; // ALUSrc


    wire [63:0] write_data;
    wire [4:0] rs1 = mem_rdata_I[19:15];
    wire [4:0] rs2 = mem_rdata_I[24:20];
    wire [4:0] rd  = mem_rdata_I[11:7];
    wire [63:0] r_data_1;
    wire [63:0] r_data_2;

    // assign write_data = 


    Controller ctrl(clk,
            rst_n,
            // mem_addr_I,
            mem_rdata_I,
			ctrl_signal,
			immediate,
			);

    Registers registers(rst_n,
            clk,
            reg_write,
            write_data,
            rd,
            rs1,
            rs2,
            r_data_1,
            r_data_2
    );

    Imm_gen imm_gen();

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
        end
            mem_addr_I <= 30'b0;
            mem_addr_D <= 30'b0;
            mem_wen_D <= 1'b0;
            mem_wdata_D <= 64'b0;

        else begin
            mem_addr_I <= mem_addr_I + 1'b1; // program counter
        end
    end

    always @(*) begin
        // mem_addr_D
        // TODO: fecth instructions from mem_i
        
        // decode instructions
        // check mem type
        // output control signals
        
    end


endmodule

module Registers(rst_n,
    clk,
    wen,    // RegWrite
    w_data, // Write Data
    w_reg,
    r_reg_1,
    r_reg_2,
    r_data_1,
    r_data_2,
    );

    input rst, wen, clk;
    input [63:0] w_data;
    input [4:0] r_reg_1;
    input [4:0] r_reg_2;
    input [4:0] w_reg;
    output [63:0] r_data_1;
    output [63:0] r_data_2;

    // 64 bit register x 32
    reg [64:0] data[0:31];

    always @(*) begin
        // read memory data
        r_data_1 = data[r_reg_1];
        r_data_2 = data[r_reg_2];
    end

    always @(posedge clk) begin
        if (wen == 1'b1)
            data[w_reg] <= w_data;
    end

    always @(negedge rst_n) begin
        for (i = 0 ; i < 32; i = i+1)
            data[i] <= 32'b0;
    end

endmodule

module ALU(
    alu_op
    in_1,
    in_2,
    zero,
    out);

    input [3:0] alu_op;
    input [63:0] in_1;
    input [63:0] in_2;
    output zero;
    output [63:0] out;

    always @(*) begin

        case (alu_op)
            ADD_OP: begin
                out = in_1 + in_2;
            end
            SLL_OP: begin
                out = in_1 << in_2;
            end
            SLT_OP: begin
                out = in_1 < in_2;
            end
            XOR_OP: begin
                out = in_2 ^ in_2;
            end
            SRL_OP: begin
                out = in_1 >> in_2;
            end
            OR_OP: begin
                out = in_1 | in_2;
            end
            AND_OP: begin
                out = in_1 & in_2;
            end
            SUB_OP: begin
                out = in_1 - in_2;
            end
            SRA_OP: begin
                out = in_1 >>> in_2;
            end
        endcase
    end

endmodule


module Imm_gen(in, out);
    input [31:12] in;
    output [63:0] out;

    assign out = {{32{in[31]}}, in};
endmodule

