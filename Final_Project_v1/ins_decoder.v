module ins_decoder(clk,
            rst_n,
            // for mem_I
            // mem_addr_I,
            mem_rdata_I,
			// for result output
			instruction_type,
			instruction_format,
			);

    input      clk, rst_n        ;
    // input      rst_n        ;
    // output [31:2] mem_addr_I        ;
    input  [31:0] mem_rdata_I       ;
	output reg [22:0] instruction_type  ;
	output reg [ 4:0] instruction_format;

    wire [2:0] func3 = mem_rdata_I[14:12];
    wire [6:0] func7 = mem_rdata_I[31:25];

    parameter NONE_TYPE = 23'bx;
    parameter JAL  = {1'b1, 22'b0};
    parameter JALR = {1'b0, 1'b1, 21'b0};
    parameter BEQ  = {2'b0, 1'b1, 20'b0};
    parameter BNE  = {3'b0, 1'b1, 19'b0};
    parameter LD   = {4'b0, 1'b1, 18'b0};
    parameter ADDI = {6'b0, 1'b1, 16'b0};
    parameter SLTI = {7'b0, 1'b1, 15'b0};
    parameter XORI = {8'b0, 1'b1, 14'b0};
    parameter ORI  = {9'b0, 1'b1, 13'b0};
    parameter ANDI = {10'b0, 1'b1, 12'b0};
    parameter SLLI = {11'b0, 1'b1, 11'b0};
    parameter SRLI = {12'b0, 1'b1, 10'b0};
    parameter SRAI = {13'b0, 1'b1, 9'b0};
    parameter ADD  = {14'b0, 1'b1, 8'b0};
    parameter SUB  = {15'b0, 1'b1, 7'b0};
    parameter SLL  = {16'b0, 1'b1, 6'b0};
    parameter SLT  = {17'b0, 1'b1, 5'b0};
    parameter XOR  = {18'b0, 1'b1, 4'b0};
    parameter SRL  = {19'b0, 1'b1, 3'b0};
    parameter SRA  = {20'b0, 1'b1, 2'b0};
    parameter OR   = {21'b0, 1'b1, 1'b0};
    parameter AND  = {22'b0, 1'b1};

    parameter NONE_FORMAT = 5'bx;
    parameter R_FORMAT = 5'b10000;
    parameter I_FORMAT = 5'b01000;
    parameter S_FORMAT = 5'b00100;
    parameter B_FORMAT = 5'b00010;
    parameter J_FORMAT = 5'b00001;

always @(*) begin
            // mem_addr_I = mem_addr_I + 1'b1;

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
                        3'b000:
                            instruction_type = BEQ;
                        3'b001:
                            instruction_type = BNE;
                        default:
                            instruction_type = NONE_TYPE;
                    endcase
                end

                7'b0000011: begin // I type
                    instruction_format = I_FORMAT;
                    case (func3)
                        3'b011:
                            instruction_type = {4'b0, 1'b1, 18'b0}; // LD
                        default:
                            instruction_type = NONE_TYPE;
                    endcase
                end

                7'b0100011: begin // S type
                    instruction_format = S_FORMAT;
                    case (func3)
                        3'b011: 
                            instruction_type = {5'b0, 1'b1, 17'b0}; // SD
                        default:
                            instruction_type = NONE_TYPE;
                    endcase
                end

                7'b0010011: begin // I type
                    case (func3)
                        3'b000:
                        instruction_type = ADDI;
                        3'b010:
                        instruction_type = SLTI;
                        3'b100:
                        instruction_type = XORI;
                        3'b110:
                        instruction_type = ORI;
                        3'b111: 
                        instruction_type = ANDI;
                        3'b001:
                        case (func7)
                            7'b0: 
                                instruction_type = SLLI;
                            default:
                                instruction_type = NONE_TYPE;
                        endcase

                        3'b101:
                        case (func7)
                            7'b0:
                                instruction_type = SRLI;
                            7'b0100000:
                                instruction_type = SRAI;
                            default:
                                instruction_type = NONE_TYPE;
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
                            7'b0:
                                instruction_type = ADD;
                            7'b0100000:
                                instruction_type = SUB;     
                            default:
                                instruction_type = NONE_TYPE;
                        
                        endcase
                        3'b001:
                        instruction_type = SLL;
                        3'b010:
                        instruction_type = SLT;
                        3'b100:
                        instruction_type = XOR;
                        3'b101:
                        case (func7)
                            7'b0:
                                instruction_type = SRL;
                            7'b0100000:
                                instruction_type = SRA;
                            default:
                                instruction_type = NONE_TYPE;
                        endcase
                        3'b110:
                        instruction_type = OR;
                        3'b111:
                        instruction_type = AND;
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
    end

    // always @(posedge clk or negedge rst_n) begin
    // always @(negedge rst_n) begin
    //     if (!rst_n) begin
    //         instruction_type <= 23'b0;
    //         instruction_format <= 5'b0;
    //     end
    //     // else begin
            
    //     // end
    // end

endmodule
