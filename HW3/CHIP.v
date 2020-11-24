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
    output [31:2] mem_addr_I        ;
    input  [31:0] mem_rdata_I       ;
	output [22:0] instruction_type  ;
	output [ 4:0] instruction_format;
    reg
    
    always @(posedge clk or posedge rst_n) begin
        if (rst_n) begin
            mem_addr_I <= 32'b0;
            instruction_type <= 23'b0;
            instruction_format <= 5'b0;
        end
        else begin
            
        end
        
    end

endmodule
