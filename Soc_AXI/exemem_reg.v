`include "defines.v"

module exemem_reg (
    input  wire 				cpu_clk_50M,
    input  wire 				cpu_rst_n,

    // 来自执行阶段的信息
    input  wire [`ALUOP_BUS     ]   exe_aluop,
    input  wire [`REG_ADDR_BUS  ]   exe_wa,
    input  wire                     exe_wreg,
    input  wire [`REG_BUS 	    ]   exe_wd,
    input  wire                     exe_whilo,
    input  wire [`DOUBLE_REG_BUS]   exe_hilo, 
    input  wire                     exe_mreg,
    input  wire [`REG_BUS       ]   exe_din,
    input  wire                     exe_whi,
    input  wire                     exe_wlo,
    input  wire [`STALL_BUS     ]   stall,
    input  wire                     exe_cp0_we,
    input  wire [`REG_ADDR_BUS  ]   exe_cp0_waddr,
    input  wire [`REG_BUS       ]   exe_cp0_wdata,
    input  wire                     flush,
    input  wire [`INST_ADDR_BUS ]   exe_pc,
    input  wire                     exe_in_delay,
    input  wire [`EXC_CODE_BUS  ]   exe_exccode,
    input  wire                     exe_inst_data_ok,
    
    // 送到访存阶段的信息 
    output reg  [`ALUOP_BUS     ]   mem_aluop,
    output reg  [`REG_ADDR_BUS  ]   mem_wa,
    output reg                      mem_wreg,
    output reg  [`REG_BUS 	    ]   mem_wd,
    output reg                      mem_whilo,
    output reg  [`DOUBLE_REG_BUS]   mem_hilo,
    output reg                      mem_mreg,
    output reg  [`REG_BUS       ]   mem_din,
    output reg                      mem_whi,
    output reg                      mem_wlo,
    output reg                      mem_cp0_we,
	output reg  [`REG_ADDR_BUS  ]   mem_cp0_waddr,
	output reg  [`REG_BUS       ]   mem_cp0_wdata,
	output reg  [`INST_ADDR_BUS ]   mem_pc,
	output reg                      mem_in_delay,
	output reg  [`EXC_CODE_BUS  ]   mem_exccode,
	output reg                      mem_inst_data_ok

    );

    always @(posedge cpu_clk_50M) begin
    if (cpu_rst_n == `RST_ENABLE || flush) begin
        mem_aluop              <= `MINIMIPS32_SLL;
        mem_wa 				   <= `REG_NOP;
        mem_wreg   			   <= `WRITE_DISABLE;
        mem_wd   			   <= `ZERO_WORD;
        mem_whilo              <= `WRITE_DISABLE;
        mem_hilo               <= `ZERO_DWORD;
        mem_mreg               <= `FALSE_V;
        mem_din                <= `ZERO_WORD;
        mem_whi                <= `FALSE_V;
        mem_wlo                <= `FALSE_V;
        mem_pc                 <= `PC_INIT;
        mem_in_delay           <= `FALSE_V;
        mem_exccode            <= `EXC_NONE;
        mem_cp0_we             <= `FALSE_V;
	    mem_cp0_waddr          <= `ZERO_WORD;
	    mem_cp0_wdata          <= `ZERO_WORD;
	    mem_inst_data_ok       <= 1'b0;
    end
    else if(stall[3] == `STOP) begin
        mem_aluop              <= `MINIMIPS32_SLL;
        mem_wa 				   <= `REG_NOP;
        mem_wreg   			   <= `WRITE_DISABLE;
        mem_wd   			   <= `ZERO_WORD;
        mem_whilo              <= `WRITE_DISABLE;
        mem_hilo               <= `ZERO_DWORD;
        mem_mreg               <= `FALSE_V;
        mem_din                <= `ZERO_WORD;
        mem_whi                <= `FALSE_V;
        mem_wlo                <= `FALSE_V;
        mem_pc                 <= `PC_INIT;
        mem_in_delay           <= `FALSE_V;
        mem_exccode            <= `EXC_NONE;
        mem_cp0_we             <= `FALSE_V;
	    mem_cp0_waddr          <= `ZERO_WORD;
	    mem_cp0_wdata          <= `ZERO_WORD;
	    mem_inst_data_ok       <= 1'b0;
    end
    else if(stall[3] == `NOSTOP) begin
        mem_aluop              <= exe_aluop;
        mem_wa 				   <= exe_wa;
        mem_wreg 			   <= exe_wreg;
        mem_wd 		    	   <= exe_wd;
        mem_whilo              <= exe_whilo;
        mem_hilo               <= exe_hilo;
        mem_mreg               <= exe_mreg;
        mem_din                <= exe_din;
        mem_whi                <= exe_whi;
        mem_wlo                <= exe_wlo;
        mem_pc                 <= exe_pc;
        mem_in_delay           <= exe_in_delay;
        mem_exccode            <= exe_exccode;
        mem_cp0_we             <= exe_cp0_we;
	    mem_cp0_waddr          <= exe_cp0_waddr;
	    mem_cp0_wdata          <= exe_cp0_wdata;
	    mem_inst_data_ok       <= exe_inst_data_ok;
    end
  end

endmodule