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
    output reg [31:2] mem_addr_I ;
    input  [31:0] mem_rdata_I    ;
    output mem_wen_D ;
    output reg [31:2] mem_addr_D;
    output reg [63:0] mem_wdata_D;
    input [63:0] mem_rdata_D;

    Controller ctrl(clk,
            rst_n,
            // mem_addr_I,
            mem_rdata_I,
			ctrl_signal,
			immediate,
			);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
        end
            mem_addr_I <= 30'b0;
            mem_addr_D <= 30'b0;
            mem_wen_D <= 1'b0;
            mem_wdata_D <= 64'b0;

        else begin
            mem_addr_I <= mem_addr_I + 1'b1;

        end
    end



endmodule
