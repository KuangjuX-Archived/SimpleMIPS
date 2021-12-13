`include "defines.v"

module memwb_reg (
    input  wire                     cpu_clk_50M,
	input  wire                     cpu_rst_n,

	// 来自访存阶段的信息
	input  wire [`REG_ADDR_BUS  ]   mem_wa,
	input  wire                     mem_wreg,
	input  wire [`REG_BUS       ] 	mem_dreg,
	input  wire                     mem_whilo,
	input  wire [`DOUBLE_REG_BUS]   mem_hilo,
	input  wire                     mem_mreg,
	input  wire [`BSEL_BUS      ]   mem_dre,
	input  wire                     mem_whi,
	input  wire                     mem_wlo,
	input  wire                     mem_msext,
	input  wire                     mem_cp0_we,
    input  wire [`REG_ADDR_BUS  ]   mem_cp0_waddr,
    input  wire [`REG_BUS       ]   mem_cp0_wdata,
    input  wire					    flush,
    input  wire [`INST_ADDR_BUS ]   mem_pc,
    input  wire [`WORD_BUS      ]   mem_rdata, //从数据存储器取得的数据，需要和其他信号一起在这里阻塞
    input  wire                     mem_stop_wb,

	// 送至写回阶段的信息 
	output wire  [`REG_ADDR_BUS  ]   wb_wa,
	output wire                      wb_wreg,
	output wire  [`REG_BUS       ]   wb_dreg,
	output wire                      wb_whilo,
	output wire  [`DOUBLE_REG_BUS]   wb_hilo,
	output wire                      wb_mreg,
	output wire  [`BSEL_BUS      ]   wb_dre,
	output wire                      wb_whi,
	output wire                      wb_wlo,
	output wire                      wb_msext,
	output wire                      wb_cp0_we,
	output wire  [`REG_ADDR_BUS  ]   wb_cp0_waddr,
	output wire  [`REG_BUS       ]   wb_cp0_wdata,
	output wire  [`INST_ADDR_BUS ]   wb_pc,
	output reg  [`WORD_BUS      ]    wb_rdata
    );
    
    reg  [`REG_ADDR_BUS  ]   wb_wa_reg;
	reg                      wb_wreg_reg;
	reg  [`REG_BUS       ]   wb_dreg_reg;
	reg                      wb_whilo_reg;
	reg  [`DOUBLE_REG_BUS]   wb_hilo_reg;
	reg                      wb_mreg_reg;
	reg  [`BSEL_BUS      ]   wb_dre_reg;
	reg                      wb_whi_reg;
	reg                      wb_wlo_reg;
    reg                      wb_msext_reg;
	reg                      wb_cp0_we_reg;
	reg  [`REG_ADDR_BUS  ]   wb_cp0_waddr_reg;
	reg  [`REG_BUS       ]   wb_cp0_wdata_reg;
	reg  [`INST_ADDR_BUS ]   wb_pc_reg;
    
    always @(posedge cpu_clk_50M) begin
	if(cpu_rst_n == `RST_ENABLE || flush) begin
		wb_rdata <= 32'h0;
	end
	else begin
		wb_rdata <= mem_rdata;
	end
    end
    
    assign wb_wa = (mem_stop_wb )? 0 : wb_wa_reg;
    assign wb_wreg = (mem_stop_wb )? 0 : wb_wreg_reg;
    assign wb_dreg = (mem_stop_wb )? 0 : wb_dreg_reg;
    assign wb_whilo = (mem_stop_wb )? 0 : wb_whilo_reg;
    assign wb_hilo = (mem_stop_wb )? 0 : wb_hilo_reg;
    assign wb_mreg = (mem_stop_wb )? 0 : wb_mreg_reg;
    assign wb_dre = (mem_stop_wb )? 0 : wb_dre_reg;
    assign wb_whi = (mem_stop_wb )? 0 : wb_whi_reg;
    assign wb_wlo = (mem_stop_wb )? 0 : wb_wlo_reg;
    assign wb_msext = (mem_stop_wb )? 0 : wb_msext_reg;
    assign wb_cp0_we = (mem_stop_wb )? 0 : wb_cp0_we_reg;
    assign wb_cp0_waddr = (mem_stop_wb )? 0 : wb_cp0_waddr_reg;
    assign wb_cp0_wdata = (mem_stop_wb )? 0 : wb_cp0_wdata_reg;
    assign wb_pc = (mem_stop_wb )? 0 : wb_pc_reg;
    
    always @(posedge cpu_clk_50M) begin
		// 复位的时候将送至写回阶段的信息清0
		if (cpu_rst_n == `RST_ENABLE || flush) begin
			wb_wa_reg       <= `REG_NOP;
			wb_wreg_reg     <= `WRITE_DISABLE;
			wb_dreg_reg     <= `ZERO_WORD;
			wb_whilo_reg    <= `WRITE_DISABLE;
			wb_hilo_reg     <= `ZERO_DWORD;
			wb_dre_reg      <= 4'b0;
			wb_mreg_reg     <= `WRITE_DISABLE;
			wb_whi_reg      <= `FALSE_V;
			wb_wlo_reg      <= `FALSE_V;
			wb_msext_reg    <= `FALSE_V;
			wb_cp0_we_reg     <= `FALSE_V;
	    	wb_cp0_waddr_reg  <= `ZERO_WORD;
	    	wb_cp0_wdata_reg  <= `ZERO_WORD;
	    	wb_pc_reg         <= `PC_INIT;
		end
		// 将来自访存阶段的信息寄存并送至写回阶段
		else begin
		    if(~mem_stop_wb) begin
			wb_wa_reg 	    <= mem_wa;
			wb_wreg_reg     <= mem_wreg;
			wb_dreg_reg     <= mem_dreg;
			wb_whilo_reg    <= mem_whilo;
			wb_hilo_reg     <= mem_hilo;
			wb_dre_reg      <= mem_dre;
			wb_mreg_reg     <= mem_mreg;
			wb_whi_reg      <= mem_whi;
			wb_wlo_reg      <= mem_wlo;
			wb_msext_reg     <= mem_msext;
			wb_cp0_we_reg     <= mem_cp0_we;
	    	wb_cp0_waddr_reg  <= mem_cp0_waddr;
	    	wb_cp0_wdata_reg  <= mem_cp0_wdata;
	    	wb_pc_reg         <= mem_pc;  	
	    end
		end
	end

endmodule