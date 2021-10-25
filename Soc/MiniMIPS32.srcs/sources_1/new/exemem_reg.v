`include "defines.v"

module exemem_reg (
    input  wire 				cpu_clk_50M,
    input  wire 				cpu_rst_n,

    // 来自执行阶段的信息
    input  wire [`ALUOP_BUS   ]   exe_aluop,
    input  wire [`REG_ADDR_BUS]   exe_wa,
    input  wire                   exe_wreg,
    input  wire [`REG_BUS 	  ]   exe_wd,
    input  wire                   exe_mreg,
    input  wire [`REG_BUS     ]   exe_din,
    input  wire                   exe_whilo,
    input  wire [`DOUBLE_REG_BUS] exe_hilo,
    
    // 送到访存阶段的信息 
    output reg  [`ALUOP_BUS   ]   mem_aluop,
    output reg  [`REG_ADDR_BUS]   mem_wa,
    output reg                    mem_wreg,
    output reg  [`REG_BUS 	  ]   mem_wd
    output reg                    mem_mreg,
    output reg  [`REG_BUS     ]   mem_din,
    output reg                    mem_whilo,
    output reg  [`DOUBLE_REG_BUS] mem_hilo
    );

    always @(posedge cpu_clk_50M) begin
        if (cpu_rst_n == `RST_ENABLE) begin
            mem_aluop              <= `MINIMIPS32_SLL;
            mem_wa 				   <= `REG_NOP;
            mem_wreg   			   <= `WRITE_DISABLE;
            mem_wd   			   <= `ZERO_WORD;
            mem_mreg               <= `WRITE_DISABLE;
            mem_din                <= `ZERO_WORD;
            mem_whilo              <= `WRITE_DISABLE;
            mem_hilo               <= `ZERO_DWORD;
        end
        else begin
            mem_aluop              <= exe_aluop;
            mem_wa 				   <= exe_wa;
            mem_wreg 			   <= exe_wreg;
            mem_wd 		    	   <= exe_wd;
            mem_mreg               <= exe_mreg;
            mem_din                <= exe_din;
            mem_whilo              <= exe_whilo;
            mem_hilo               <= exe_hilo;
        end
  end

endmodule