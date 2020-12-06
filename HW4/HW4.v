module HW4(clk,
            rst_n,
            // for mem_I
            mem_addr_I,
            mem_rdata_I,
			// for result output
			ctrl_signal,
			immediate,
			);

    input         clk, rst_n        ;
    output [31:2] mem_addr_I        ;
    input  [31:0] mem_rdata_I       ;
	output reg [11:0] ctrl_signal  ;
	output reg [31:0] immediate;

	// definition of operations
	parameter ADD_OP = 4'b0;
	parameter SLL_OP = 4'b0001;
	parameter SLT_OP = 4'b0010;
	parameter XOR_OP = 4'b0100;
	parameter SRL_OP = 4'b0101;
	parameter OR_OP  = 4'b0110;
	parameter AND_OP = 4'b0111;
	parameter SUB_OP = 4'b1000;
	parameter SRA_OP = 4'b1101;

	// wire/reg 
	reg [11:0] ctrl_sig_next;
	reg [31:0] immediate_next;

	wire [22:0] instruction_type;
	wire [ 4:0] instruction_format;
	
	HW3 decoder(
        clk,
		rst_n,
		mem_addr_I,
		mem_rdata_I,
		instruction_type,
		instruction_format,
    );

	/*
	always @(*) begin
		case (instruction_format)
			decoder.R_FORMAT: begin
				case (instruction_type)
					decoder.ADD:
						ctrl_sig_next[3:0] = ADD_OP;
					decoder.SUB:
						ctrl_sig_next[3:0] = SUB_OP;
					decoder.SLL:
						ctrl_sig_next[3:0] = SLL_OP;
					decoder.SLT:
						ctrl_sig_next[3:0] = SLT_OP;
					decoder.XOR:
						ctrl_sig_next[3:0] = XOR_OP;
					decoder.SRL:
						ctrl_sig_next[3:0] = SLL_OP;
					decoder.SRA:
						ctrl_sig_next[3:0] = SRA_OP;
					decoder.OR:
						ctrl_sig_next[3:0] = OR_OP;
					decoder.AND:
						ctrl_sig_next[3:0] = AND_OP;
					default:
						ctrl_sig_next[3:0] = 4'bx;
				endcase
			end

			decoder.I_FORMAT: begin
				immediate_next[11:0] = mem_rdata_I[31:20];
				ctrl_sig_next[11:4] = 8'b00000011;
	
				case (instruction_type)
					decoder.JAL:
						ctrl_sig_next = 12'b10000x1xxxxx;
					decoder.ADDI:
						ctrl_sig_next[3:0] = ADD_OP;
					decoder.SLLI:
						ctrl_sig_next[3:0] = SLL_OP;
					decoder.SLTI:
						ctrl_sig_next[3:0] = SLT_OP;
					decoder.XORI:
						ctrl_sig_next[3:0] = XOR_OP;
					decoder.SRLI:
						ctrl_sig_next[3:0] = SLL_OP;
					decoder.SRAI:
						ctrl_sig_next[3:0] = SRA_OP;
					decoder.ORI:
						ctrl_sig_next[3:0] = OR_OP;
					decoder.ANDI:
						ctrl_sig_next[3:0] = AND_OP;
					default:
						ctrl_sig_next[3:0] = 4'bx;
				endcase
			end

			decoder.S_FORMAT: begin
				//                     11:5                4:0
				immediate_next[11:0] = {mem_rdata_I[31:25], mem_rdata_I[11:7]};
				ctrl_sig_next = 12'b00001x01xxxx;
			end

			decoder.B_FORMAT: begin
				//                     12               11              10:5                4:1
				immediate_next[12:1] = {mem_rdata_I[31], mem_rdata_I[7], mem_rdata_I[31:25], mem_rdata_I[11:7]};
				ctrl_sig_next = 12'b00100x00xxxx;
			end

			decoder.J_FORMAT: begin // JALR
				//                     20               19:12               11               10:1
				immediate_next[20:1] = {mem_rdata_I[31], mem_rdata_I[19:12], mem_rdata_I[20], mem_rdata_I[30:21]}; // JAL imm[20|10:1|11|19:12]
				ctrl_sig_next = 12'b10000x1xxxxx;
			end


			default: begin
				ctrl_sig_next = 12'bx;
				immediate_next = 32'bx;
			end
		endcase
	end
	*/
	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			ctrl_signal <= 12'b0;
			immediate <= 32'b0;
			// assign ctrl_signal = 12'b0;
			// assign immediate = 32'b0;
		end
		else begin
			// ctrl_signal <= ctrl_sig_next;
		    // immediate <= immediate_next;
			case (instruction_format)
			decoder.R_FORMAT: begin
				case (instruction_type)
					decoder.ADD:
						ctrl_signal[3:0] <= ADD_OP;
					decoder.SUB:
						ctrl_signal[3:0] <= SUB_OP;
					decoder.SLL:
						ctrl_signal[3:0] <= SLL_OP;
					decoder.SLT:
						ctrl_signal[3:0] <= SLT_OP;
					decoder.XOR:
						ctrl_signal[3:0] <= XOR_OP;
					decoder.SRL:
						ctrl_signal[3:0] <= SLL_OP;
					decoder.SRA:
						ctrl_signal[3:0] <= SRA_OP;
					decoder.OR:
						ctrl_signal[3:0] <= OR_OP;
					decoder.AND:
						ctrl_signal[3:0] <= AND_OP;
					default:
						ctrl_signal[3:0] <= 4'bx;
				endcase
			end

			decoder.I_FORMAT: begin
				immediate[11:0] <= mem_rdata_I[31:20];
				ctrl_signal[11:4] <= 8'b00000011;
	
				case (instruction_type)
					decoder.JAL:
						ctrl_signal <= 12'b10000x1xxxxx;
					decoder.ADDI:
						ctrl_signal[3:0] <= ADD_OP;
					decoder.SLLI:
						ctrl_signal[3:0] <= SLL_OP;
					decoder.SLTI:
						ctrl_signal[3:0] <= SLT_OP;
					decoder.XORI:
						ctrl_signal[3:0] <= XOR_OP;
					decoder.SRLI:
						ctrl_signal[3:0] <= SLL_OP;
					decoder.SRAI:
						ctrl_signal[3:0] <= SRA_OP;
					decoder.ORI:
						ctrl_signal[3:0] <= OR_OP;
					decoder.ANDI:
						ctrl_signal[3:0] <= AND_OP;
					default:
						ctrl_signal[3:0] <= 4'bx;
				endcase
			end

			decoder.S_FORMAT: begin
				//                     11:5                4:0
				immediate[11:0] <= {mem_rdata_I[31:25], mem_rdata_I[11:7]};
				ctrl_signal <= 12'b00001x01xxxx;
			end

			decoder.B_FORMAT: begin
				//                     12               11              10:5                4:1
				immediate[12:1] <= {mem_rdata_I[31], mem_rdata_I[7], mem_rdata_I[31:25], mem_rdata_I[11:7]};
				ctrl_signal <= 12'b00100x00xxxx;
			end

			decoder.J_FORMAT: begin // JALR
				//                     20               19:12               11               10:1
				immediate[20:1] <= {mem_rdata_I[31], mem_rdata_I[19:12], mem_rdata_I[20], mem_rdata_I[30:21]}; // JAL imm[20|10:1|11|19:12]
				ctrl_signal <= 12'b10000x1xxxxx;
			end

			default: begin
				ctrl_signal <= 12'bx;
				immediate <= 32'bx;
			end
		endcase
		end
	end

	// Connect to your HW3 module
endmodule