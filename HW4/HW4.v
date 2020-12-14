module HW4(clk,
            rst_n,
            // for mem_I
            mem_addr_I,
            mem_rdata_I,
			// for result output
			ctrl_signal,
			immediate,
			);

    input         clk, rst_n     ;
    output reg [31:2] mem_addr_I ;
    input  [31:0] mem_rdata_I    ;
	output reg [11:0] ctrl_signal;
	output reg [31:0] immediate;

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

	// wire/reg 
	reg [11:0] ctrl_sig_next;
	reg [31:0] immediate_next;
	reg [31:2] mem_addr_next;

	wire [22:0] instruction_type;
	wire [ 4:0] instruction_format;
	
	HW3 decoder(
        clk,
		rst_n,
		// mem_addr_I,
		mem_rdata_I,
		instruction_type,
		instruction_format,
    );
	
	always @(*) begin
		mem_addr_next = mem_addr_I + 1'b1;
		case (instruction_format)
			// decoder.R_FORMAT: begin
			5'b10000: begin
				immediate_next = 32'b0;
				ctrl_sig_next[11:4] = 8'b00000010;
				case (instruction_type)
					// decoder.ADD:
					{14'b0, 1'b1, 8'b0}: ctrl_sig_next[3:0] = ADD_OP;
					// decoder.SUB:
					{15'b0, 1'b1, 7'b0}: ctrl_sig_next[3:0] = SUB_OP;
					// decoder.SLL:
					{16'b0, 1'b1, 6'b0}: ctrl_sig_next[3:0] = SLL_OP;
					// decoder.SLT:
					{17'b0, 1'b1, 5'b0}: ctrl_sig_next[3:0] = SLT_OP;
					// decoder.XOR:
					{18'b0, 1'b1, 4'b0}: ctrl_sig_next[3:0] = XOR_OP;
					// decoder.SRL:
					{19'b0, 1'b1, 3'b0}: ctrl_sig_next[3:0] = SRL_OP;
					// decoder.SRA:
					{20'b0, 1'b1, 2'b0}: ctrl_sig_next[3:0] = SRA_OP;
					// decoder.OR:
					{21'b0, 1'b1, 1'b0}: ctrl_sig_next[3:0] = OR_OP;
					// decoder.AND:
					{22'b0, 1'b1}: ctrl_sig_next[3:0] = AND_OP;
					default:
						ctrl_sig_next[3:0] = 4'bx;
				endcase
			end

			// decoder.I_FORMAT: begin
			5'b01000: begin
				immediate_next = {{20{mem_rdata_I[31]}}, mem_rdata_I[31:20]};
				ctrl_sig_next[11:4] = 8'b00000011;
				case (instruction_type)
					// decoder.LD:
                    {4'b0, 1'b1, 18'b0}:
						// ctrl_sig_next = 12'b00010111xxxx;
						ctrl_sig_next = 12'b000101110000;
					// decoder.JALR:
                    {1'b0, 1'b1, 21'b0}:
						// ctrl_sig_next = 12'b01000x1xxxxx;
						ctrl_sig_next = 12'b010000100000;
					// decoder.ADDI:
                    {6'b0, 1'b1, 16'b0}: ctrl_sig_next[3:0] = ADD_OP;
					// decoder.SLLI:
					{11'b0, 1'b1, 11'b0}: ctrl_sig_next[3:0] = SLL_OP;
					// decoder.SLTI:
					{7'b0, 1'b1, 15'b0}: ctrl_sig_next[3:0] = SLT_OP;
					// decoder.XORI:
					{8'b0, 1'b1, 14'b0}: ctrl_sig_next[3:0] = XOR_OP;
					// decoder.SRLI:
					{12'b0, 1'b1, 10'b0}: ctrl_sig_next[3:0] = SRL_OP;
					// decoder.SRAI:
					{13'b0, 1'b1, 9'b0}: ctrl_sig_next[3:0] = SRA_OP;
					// decoder.ORI:
					{9'b0, 1'b1, 13'b0}: ctrl_sig_next[3:0] = OR_OP;
					// decoder.ANDI:
					{10'b0, 1'b1, 12'b0}: ctrl_sig_next[3:0] = AND_OP;
					default:
						ctrl_sig_next[3:0] = 4'bx;
				endcase
			end

			// decoder.S_FORMAT: begin
			5'b00100: begin
				//                                       11:5                4:0
				immediate_next = {{12{mem_rdata_I[31]}}, mem_rdata_I[31:25], mem_rdata_I[11:7]};
				// ctrl_sig_next = 12'b00001x01xxxx;
				ctrl_sig_next = 12'b000010010000;
			end

			// decoder.B_FORMAT: begin
			5'b00010: begin
				//                 31:13                 12               11              10:5                4:1                0
				immediate_next = {{19{mem_rdata_I[31]}}, mem_rdata_I[31], mem_rdata_I[7], mem_rdata_I[30:25], mem_rdata_I[11:8], 1'b0};
				// ctrl_sig_next = 12'b00100x00xxxx;
				ctrl_sig_next = 12'b001000000000;
			end

			// decoder.J_FORMAT: begin // JAL
			5'b00001: begin // JAL
				//                31:21                   20               19:12               11               10:1                0
				immediate_next = {{11{mem_rdata_I[31]}} , mem_rdata_I[31], mem_rdata_I[19:12], mem_rdata_I[20], mem_rdata_I[30:21], 1'b0}; // JAL imm[20|10:1|11|19:12]
				// ctrl_sig_next = 12'b10000x1xxxxx;
				ctrl_sig_next = 12'b100000100000;
			end

			default: begin
				immediate_next = 32'bx;
				ctrl_sig_next = 12'bx;
			end
		endcase
	end

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			ctrl_signal <= 12'b0;
			immediate <= 32'b0;
			mem_addr_I <= 30'b0;
		end
		else begin
			ctrl_signal <= ctrl_sig_next;
		    immediate <= immediate_next;
			mem_addr_I <= mem_addr_next;
		end
	end

	// Connect to your HW3 module
endmodule