module CHIP(clk,
            rst_n,
            // for mem_I
            mem_addr_I,
            mem_rdata_I,
			// for result output
			instruction_type,
			instruction_format,
			);

    input         clk, rst_n        ;
    output reg [31:2] mem_addr_I        ;
    input  [31:0] mem_rdata_I       ;
	output reg [22:0] instruction_type  ;
	output reg [ 4:0] instruction_format;

    reg [31:2] mem_addr_reg;
    reg [22:0] instruction_type_reg;
    reg [4:0]  instruction_format_reg;

    wire [2:0] func3 = mem_rdata_I[14:12];
    wire [6:0] func7 = mem_rdata_I[31:25];

    parameter NONE_TYPE = 23'bx;
    parameter NONE_FORMAT = 5'bx;

    always @(*) begin
            mem_addr_reg = mem_addr_I + 1'b1;

            case (mem_rdata_I[6:0]) // opcode
                7'b1101111: begin // UJ type
                    instruction_format_reg = {5'b00001};
                    instruction_type_reg = {1'b1, 22'b0}; // JAL
                end

                7'b1100111: begin // I type
                    instruction_format_reg = {5'b01000};
                    instruction_type_reg = {1'b0, 1'b1, 21'b0}; // JALR
                end

                7'b1100011: begin // SB type
                    instruction_format_reg = {5'b00010};
                    case (func3)
                        3'b000:
                            instruction_type_reg = {2'b0, 1'b1, 20'b0}; // BEQ
                        3'b001:
                            instruction_type_reg = {3'b0, 1'b1, 19'b0}; // BNE
                        default:
                            instruction_type_reg = NONE_TYPE;
                    endcase
                end

                7'b0000011: begin // I type
                    instruction_format_reg = {5'b01000};
                    case (func3)
                        3'b011:
                            instruction_type_reg = {4'b0, 1'b1, 18'b0}; // LD
                        default:
                            instruction_type_reg = NONE_TYPE;
                    endcase
                end

                7'b0100011: begin // S type
                    instruction_format_reg = {5'b00100};
                    case (func3)
                        3'b011: 
                            instruction_type_reg = {5'b0, 1'b1, 17'b0}; // SD
                        default:
                            instruction_type_reg = NONE_TYPE;
                    endcase
                end

                7'b0010011: begin // I type
                    case (func3)
                        3'b000:
                        instruction_type_reg = {6'b0, 1'b1, 16'b0}; // ADDI
                        3'b010:
                        instruction_type_reg = {7'b0, 1'b1, 15'b0}; // SLTI
                        3'b100:
                        instruction_type_reg = {8'b0, 1'b1, 14'b0}; // XORI
                        3'b110:
                        instruction_type_reg = {9'b0, 1'b1, 13'b0}; // ORI
                        3'b111: 
                        instruction_type_reg = {10'b0, 1'b1, 12'b0}; // ANDI
                        3'b001:
                        case (func7)
                            7'b0: 
                                instruction_type_reg = {11'b0, 1'b1, 11'b0}; // SLLI
                            default:
                                instruction_type_reg = NONE_TYPE;
                        endcase

                        3'b101:
                        case (func7)
                            7'b0:
                                instruction_type_reg = {12'b0, 1'b1, 10'b0}; // SRLI
                            7'b0100000:
                                instruction_type_reg = {13'b0, 1'b1, 9'b0};  // SRAI
                            default:
                                instruction_type_reg = NONE_TYPE;
                        endcase

                        default: begin
                            instruction_format_reg = {5'bx};
                            instruction_type_reg = {23'bx};
                        end
                    endcase
                    instruction_format_reg = {5'b01000};
                end

                7'b0110011: begin // R type
                    case (func3)
                        3'b000:
                        case (func7)
                            7'b0:
                                instruction_type_reg = {14'b0, 1'b1, 8'b0}; // ADD
                            7'b0100000:
                                instruction_type_reg = {15'b0, 1'b1, 7'b0}; // SUB     
                            default:
                                instruction_type_reg = NONE_TYPE;
                        
                        endcase
                        3'b001:
                        instruction_type_reg = {16'b0, 1'b1, 6'b0}; // SLL
                        3'b010:
                        instruction_type_reg = {17'b0, 1'b1, 5'b0}; // SLT
                        3'b100:
                        instruction_type_reg = {18'b0, 1'b1, 4'b0}; // XOR
                        3'b101:
                        case (func7)
                            7'b0:
                                instruction_type_reg = {19'b0, 1'b1, 3'b0}; // SRL
                            7'b0100000:
                                instruction_type_reg = {20'b0, 1'b1, 2'b0}; // SRA
                            default:
                                instruction_type_reg = NONE_TYPE;
                        endcase
                        3'b110:
                        instruction_type_reg = {21'b0, 1'b1, 1'b0}; // OR 
                        3'b111:
                        instruction_type_reg = {22'b0, 1'b1}; // AND
                        default: begin                    
                            instruction_format_reg = {5'bx};
                            instruction_type_reg = {23'bx};
                        end
                    endcase
                    instruction_format_reg = {5'b10000};
                end
                
                default: begin
                    instruction_format_reg = {5'bx};
                    instruction_type_reg = {23'bx};
                end
            endcase
    end


    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            instruction_type <= 23'b0;
            instruction_format <= 5'b0;
            mem_addr_I <= 30'b0;
        end
        else begin  
            instruction_format <= instruction_format_reg;
            instruction_type <= instruction_type_reg;
            mem_addr_I <= mem_addr_reg;
        end
    end

endmodule
