`include "defines.v"

module if_stage (
    input 	wire 					cpu_clk_50M,
    input 	wire 					cpu_rst_n,
    input   wire [`INST_ADDR_BUS]   jump_addr_1_i,
    input   wire [`INST_ADDR_BUS]   jump_addr_2_i,
    input   wire [`INST_ADDR_BUS]   jump_addr_3_i,
    input   wire [`JTSEL_BUS]       jtsel_i,
    
    output  reg                     ice,
    output 	reg  [`INST_ADDR_BUS] 	pc,
    output 	wire [`INST_ADDR_BUS]	iaddr,
    output  wire [`INST_ADDR_BUS]   pc_plus_4_o
    );

    // 获得 PC+4, 提供给译码阶段，用于产生转移地址
    assign  pc_plus_4_o = (cpu_rst_n == `RST_ENABLE) ? `PC_INIT: pc + 4;
    
    wire [`INST_ADDR_BUS] pc_next; 

    // 计算下一条指令的地址
    assign pc_next = (jtsel_i == 2'b00) ? pc_plus_4_o:
                     (jtsel_i == 2'b01) ? jump_addr_1_i:    // J, JAR 转移地址
                     (jtsel_i == 2'b10) ? jump_addr_2_i:    // JR 转移地址
                     (jtsel_i == 2'b11) ? jump_addr_3_i:    // BEQ, BNE 转移地址
                     `PC_INIT;

    
    always @(posedge cpu_clk_50M) begin
		if (cpu_rst_n == `RST_ENABLE) begin
			ice <= `CHIP_DISABLE;		      // 复位的时候指令存储器禁用  
		end else begin
			ice <= `CHIP_ENABLE; 		      // 复位结束后，指令存储器使能
		end
	end

    always @(posedge cpu_clk_50M) begin
        if (ice == `CHIP_DISABLE)
            pc <= `PC_INIT;                   // 指令存储器禁用的时候，PC保持初始值（MiniMIPS32中设置为0x00000000）
        else begin
            pc <= pc_next;                    // 指令存储器使能后，PC值每时钟周期加4 	
        end
    end
    
    // TODO：指令存储器的访问地址没有根据其所处范围进行进行固定地址映射，需要修改!!!
    assign iaddr = (ice == `CHIP_DISABLE) ? `PC_INIT : pc;    // 获得访问指令存储器的地址
    
endmodule