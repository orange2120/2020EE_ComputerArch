// Your code
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
    output [31:2] mem_addr_I ;
    input  [31:0] mem_rdata_I;
    output mem_wen_D;
    output [31:2] mem_addr_D; // address to data memory
    output [63:0] mem_wdata_D;
    input [63:0] mem_rdata_D;

    // wire for control unit
    wire [11:0] control_signal;
    wire [3:0] alu_op  = control_signal[11:8]; // ALUOp
    wire alu_src = control_signal[7];          // ALUSrc
    wire reg_write = control_signal[6];        // RegWrite
    wire mem_2_reg = control_signal[5];        // MemtoReg
    wire mem_wen_D = control_signal[4];        // MemWrite
    wire mem_read = control_signal[3];         // MemRead may not use
    wire branch = control_signal[2];           // Branch
    wire JALR_sig = control_signal[1];
    wire JAL_sig = control_signal[0];
    wire [31:0] immediate;

    wire [63:0] write_data;
    wire [31:0] mem_rdata_I_out;
    wire [4:0]  rs1 = mem_rdata_I_out[19:15];
    wire [4:0]  rs2 = mem_rdata_I_out[24:20];
    wire [4:0]  rd  = mem_rdata_I_out[11:7];
    wire [63:0] reg_rdata_1;
    wire [63:0] reg_rdata_2;
    wire [64:0] alu_in_2; // ALU second input
    wire alu_zero;
    wire [63:0] alu_out; // ALU result
    wire [63:0] mem_rdata_D_out;

    wire [63:0] mem_out_D;

    wire [31:0] next_addr;
    wire [31:2] pc_in;
    wire [31:0] addr_sum;
    wire [31:0] addr_src;
    wire jal_sel;
    wire [31:0] ret_addr; // return address

    wire [63:0] imm_out;

    // assign mem_wdata_D = reg_rdata_2;
    assign alu_in_2 = alu_src ? imm_out : reg_rdata_2; // 1: from immediate gen | 0: from register
    assign mem_addr_D = alu_out;
    assign mem_out_D = mem_2_reg ? mem_rdata_D_out : alu_out; // 1: from data memory | 0: from ALU (bypass mem)
    assign write_data = (JAL_sig | JALR_sig) ? {32'b0, next_addr} : mem_out_D; // 1: next instruction addr | 0: from data memory
    assign addr_sum = mem_rdata_I_out + imm_out[31:0];
    assign next_addr = mem_rdata_I_out + 3'b100; // addr += 4
    assign addr_src = jal_sel ? addr_sum : next_addr;
    assign pc_in = JALR_sig ? ret_addr : addr_src; // 1: return address (JALR) | 0: addr_source
    assign ret_addr = imm_out + reg_rdata_1;
    assign jal_sel = JAL_sig | (branch & alu_zero);

    Controller ctrl(rst_n,
            mem_rdata_I_out,
            ctrl_signal,
            immediate,
            );

    Registers registers(clk,
            rst_n,
            reg_write,
            write_data,
            rd,
            rs1,
            rs2,
            reg_rdata_1,
            reg_rdata_2);

    ALU alu(rst_n,
            alu_op,
            reg_rdata_1,
            alu_in_2,
            alu_zero,
            alu_out);

    Program_counter pc(clk,
                    rst_n,
                    pc_in,
                    mem_addr_I);

    Imm_gen imm_gen(mem_rdata_I_out, imm_out);

    // convert between big-endian
    BE_converter_32 mem_I_out(mem_rdata_I, mem_rdata_I_out);
    BE_converter_64 mem_D_in(reg_rdata_2, mem_wdata_D);
    BE_converter_64 mem_D_out(mem_rdata_D, mem_rdata_D_out);
        
    // always @(*) begin
    //     // TODO: fecth instructions from mem_i
    //     // decode instructions
    //     // check mem type
    //     // output control signals
    // end
endmodule

module Registers(clk,
    rst_n,
    wen,    // RegWrite
    w_data, // Write Data
    w_reg,  // Write Register
    r_reg_1,
    r_reg_2,
    reg_rdata_1,
    reg_rdata_2,
    );

    input clk, rst_n, wen;
    input [63:0] w_data;
    input [4:0] r_reg_1;
    input [4:0] r_reg_2;
    input [4:0] w_reg;
    output reg [63:0] reg_rdata_1;
    output reg [63:0] reg_rdata_2;

    // 64 bit register x 32
    reg [64:0] data[0:31];
    integer i;

    always @(*) begin
        // read memory data
        reg_rdata_1 = data[r_reg_1];
        reg_rdata_2 = data[r_reg_2];
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0 ; i < 32; i = i+1)
                data[i] <= 32'b0;
            reg_rdata_1 <= 64'b0;
            reg_rdata_2 <= 64'b0;
        end
        else begin 
            if (wen) // write to register
                data[w_reg] <= w_data;
        end
    end
endmodule

// ALU + ALU control
module ALU(rst_n,
        alu_op,
        in_1,
        in_2,
        zero, // Zero
        ret); // ALU result

    input rst_n;
    input [3:0] alu_op;
    input [63:0] in_1;
    input [63:0] in_2;
    output zero;
    output reg [63:0] ret;

    // definition of operations
    localparam ADD_OP = 4'b0;
    localparam SLL_OP = 4'b0001;
    localparam SLT_OP = 4'b0010;
    localparam XOR_OP = 4'b0100;
    localparam SRL_OP = 4'b0101;
    localparam  OR_OP = 4'b0110;
    localparam AND_OP = 4'b0111;
    localparam SUB_OP = 4'b1000;
    localparam SRA_OP = 4'b1101;

    assign zero = (!ret);

    always @(*) begin
        case (alu_op)
            ADD_OP:  ret = in_1 + in_2;
            SLL_OP:  ret = in_1 << in_2;
            SLT_OP:  ret = in_1 < in_2;
            XOR_OP:  ret = in_2 ^ in_2;
            SRL_OP:  ret = in_1 >> in_2;
            OR_OP:   ret = in_1 | in_2;
            AND_OP:  ret = in_1 & in_2;
            SUB_OP:  ret = in_1 - in_2;
            SRA_OP:  ret = in_1 >>> in_2;
            default: ret = 64'b0;
        endcase
    end

    always @(negedge rst_n) begin
        if (!rst_n)
            ret <= 64'b0; 
    end

endmodule

// Immediate generator
module Imm_gen(in, out);
    input [31:12] in;
    output [63:0] out;
    // sign-extended
    assign out = {{32{in[31]}}, in};
endmodule

module Program_counter(clk,
    rst_n,
    addr_in,
    addr_out);

    input clk, rst_n;
    input [31:0] addr_in;
    output reg [31:2] addr_out;
    
    reg [31:0] next_inst;

    always @(*) begin
     next_inst = addr_in;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            addr_out <= 30'b0;
            next_inst <= 32'b0;
        end
        else begin
            addr_out <= next_inst;
        end
    end
endmodule

module Controller(rst_n,
            mem_rdata_I,
            ctrl_signal,
            immediate);

    input  rst_n;
    input  [31:0] mem_rdata_I    ;
    output reg [11:0] ctrl_signal;
    output reg [31:0] immediate;

    // wire/reg 
    wire [2:0] func3 = mem_rdata_I[14:12];
    wire [6:0] func7 = mem_rdata_I[31:25];
    reg [22:0] instruction_type;
    reg [ 4:0] instruction_format;

    localparam NONE_TYPE = 23'bx;
    localparam JAL  = {1'b1, 22'b0};
    localparam JALR = {1'b0, 1'b1, 21'b0};
    localparam BEQ  = {2'b0, 1'b1, 20'b0};
    localparam BNE  = {3'b0, 1'b1, 19'b0};
    localparam LD   = {4'b0, 1'b1, 18'b0};
    localparam SD   = {5'b0, 1'b1, 17'b0};
    localparam ADDI = {6'b0, 1'b1, 16'b0};
    localparam SLTI = {7'b0, 1'b1, 15'b0};
    localparam XORI = {8'b0, 1'b1, 14'b0};
    localparam ORI  = {9'b0, 1'b1, 13'b0};
    localparam ANDI = {10'b0, 1'b1, 12'b0};
    localparam SLLI = {11'b0, 1'b1, 11'b0};
    localparam SRLI = {12'b0, 1'b1, 10'b0};
    localparam SRAI = {13'b0, 1'b1, 9'b0};
    localparam ADD  = {14'b0, 1'b1, 8'b0};
    localparam SUB  = {15'b0, 1'b1, 7'b0};
    localparam SLL  = {16'b0, 1'b1, 6'b0};
    localparam SLT  = {17'b0, 1'b1, 5'b0};
    localparam XOR  = {18'b0, 1'b1, 4'b0};
    localparam SRL  = {19'b0, 1'b1, 3'b0};
    localparam SRA  = {20'b0, 1'b1, 2'b0};
    localparam OR   = {21'b0, 1'b1, 1'b0};
    localparam AND  = {22'b0, 1'b1};

    localparam NONE_FORMAT = 5'bx;
    localparam R_FORMAT = 5'b10000;
    localparam I_FORMAT = 5'b01000;
    localparam S_FORMAT = 5'b00100;
    localparam B_FORMAT = 5'b00010;
    localparam J_FORMAT = 5'b00001;

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

    always @(*) begin
         case (mem_rdata_I[6:0]) // opcode
                7'b1101111: begin // UJ type
                    instruction_format = J_FORMAT;
                    instruction_type = JAL;
                end

                7'b1100111: begin // I type
                    instruction_format = I_FORMAT;
                    instruction_type = JALR;
                end

                7'b1100011: begin // SB type
                    instruction_format = B_FORMAT;
                    case (func3)
                        3'b000:  instruction_type = BEQ;
                        3'b001:  instruction_type = BNE;
                        default: instruction_type = NONE_TYPE;
                    endcase
                end

                7'b0000011: begin // I type
                    instruction_format = I_FORMAT;
                    case (func3)
                        3'b011:  instruction_type = LD;
                        default: instruction_type = NONE_TYPE;
                    endcase
                end

                7'b0100011: begin // S type
                    instruction_format = S_FORMAT;
                    case (func3)
                        3'b011:  instruction_type = SD;
                        default: instruction_type = NONE_TYPE;
                    endcase
                end

                7'b0010011: begin // I type
                    case (func3)
                        3'b000: instruction_type = ADDI;
                        3'b010: instruction_type = SLTI;
                        3'b100: instruction_type = XORI;
                        3'b110: instruction_type = ORI;
                        3'b111: instruction_type = ANDI;
                        3'b001:
                        case (func7)
                            7'b0:    instruction_type = SLLI;
                            default: instruction_type = NONE_TYPE;
                        endcase

                        3'b101:
                        case (func7)
                            7'b0000000: instruction_type = SRLI;
                            7'b0100000: instruction_type = SRAI;
                            default:    instruction_type = NONE_TYPE;
                        endcase

                        default: begin
                            instruction_format = {5'bx};
                            instruction_type = {23'bx};
                        end
                    endcase
                    instruction_format = I_FORMAT;
                end

                7'b0110011: begin // R type
                    case (func3)
                        3'b000:
                        case (func7)
                            7'b0100000: instruction_type = SUB;     
                            7'b0000000: instruction_type = ADD;
                            default:    instruction_type = NONE_TYPE;
                        
                        endcase
                        3'b001: instruction_type = SLL;
                        3'b010: instruction_type = SLT;
                        3'b100: instruction_type = XOR;
                        3'b101:
                        case (func7)
                            7'b0000000: instruction_type = SRL;
                            7'b0100000: instruction_type = SRA;
                            default:    instruction_type = NONE_TYPE;
                        endcase
                        3'b110: instruction_type = OR;
                        3'b111: instruction_type = AND;
                        default: begin                    
                            instruction_format = {5'bx};
                            instruction_type = {23'bx};
                        end
                    endcase
                    instruction_format = R_FORMAT;
                end
                
                default: begin
                    instruction_format = {5'bx};
                    instruction_type = {23'bx};
                end
            endcase

        case (instruction_format)
            R_FORMAT: begin
                immediate = 32'b0;
                ctrl_signal[11:4] = 8'b00000010;
                case (instruction_type)
                    ADD: ctrl_signal[3:0] = ADD_OP;
                    SUB: ctrl_signal[3:0] = SUB_OP;
                    SLL: ctrl_signal[3:0] = SLL_OP;
                    SLT: ctrl_signal[3:0] = SLT_OP;
                    XOR: ctrl_signal[3:0] = XOR_OP;
                    SRL: ctrl_signal[3:0] = SRL_OP;
                    SRA: ctrl_signal[3:0] = SRA_OP;
                    OR:  ctrl_signal[3:0] = OR_OP;
                    AND: ctrl_signal[3:0] = AND_OP;
                    default: ctrl_signal[3:0] = 4'bx;
                endcase
            end

            I_FORMAT: begin
                immediate = {{20{mem_rdata_I[31]}}, mem_rdata_I[31:20]};
                ctrl_signal[11:4] = 8'b00000011;
                case (instruction_type)
                    LD:   ctrl_signal = 12'b000101110000;
                    JALR: ctrl_signal = 12'b010000100000;
                    ADDI: ctrl_signal[3:0] = ADD_OP;
                    SLLI: ctrl_signal[3:0] = SLL_OP;
                    SLTI: ctrl_signal[3:0] = SLT_OP;
                    XORI: ctrl_signal[3:0] = XOR_OP;
                    SRLI: ctrl_signal[3:0] = SRL_OP;
                    SRAI: ctrl_signal[3:0] = SRA_OP;
                    ORI:  ctrl_signal[3:0] = OR_OP;
                    ANDI: ctrl_signal[3:0] = AND_OP;
                    default: ctrl_signal[3:0] = 4'bx;
                endcase
            end

            S_FORMAT: begin
                //                                  11:5                4:0
                immediate = {{12{mem_rdata_I[31]}}, mem_rdata_I[31:25], mem_rdata_I[11:7]};
                ctrl_signal = 12'b000010010000;
            end

            B_FORMAT: begin
                //            31:13                 12               11              10:5                4:1                0
                immediate = {{19{mem_rdata_I[31]}}, mem_rdata_I[31], mem_rdata_I[7], mem_rdata_I[30:25], mem_rdata_I[11:8], 1'b0};
                ctrl_signal = 12'b001000000000;
            end

            J_FORMAT: begin // JAL
                //           31:21                   20               19:12               11               10:1                0
                immediate = {{11{mem_rdata_I[31]}} , mem_rdata_I[31], mem_rdata_I[19:12], mem_rdata_I[20], mem_rdata_I[30:21], 1'b0}; // JAL imm[20|10:1|11|19:12]
                ctrl_signal = 12'b100000100000;
            end

            default: begin
                immediate = 32'bx;
                ctrl_signal = 12'bx;
            end
        endcase
    end

    always @(negedge rst_n) begin
        if (!rst_n) begin
            ctrl_signal <= 12'b0;
            immediate <= 32'b0;
            instruction_type <= 23'b0;
            instruction_format <= 5'b0;
        end
    end
endmodule

module BE_converter_64 (in, out);
    input  [63:0] in;
    output [63:0] out;

    assign out[7:0]   = in[63:55];
    assign out[15:8]  = in[55:48];
    assign out[23:16] = in[47:40];
    assign out[31:24] = in[39:32];
    assign out[39:32] = in[31:24];
    assign out[47:40] = in[23:16];
    assign out[55:48] = in[15:8];
    assign out[63:56] = in[7:0];
endmodule

module BE_converter_32 (in, out);
    input  [31:0] in;
    output [31:0] out;

    assign out[7:0]   = in[31:24];
    assign out[15:8]  = in[23:16];
    assign out[23:16] = in[15:8];
    assign out[31:24] = in[7:0];
endmodule