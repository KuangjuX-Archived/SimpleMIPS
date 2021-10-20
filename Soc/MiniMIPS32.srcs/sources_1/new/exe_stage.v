`include "defines.v"

module exe_starge (
    input  wire cpu_rst_n,
    // 从译码阶段获得的信息
    input  wire [`ALUTYPE_BUS	] 	exe_alutype_i,
    input  wire [`ALUOP_BUS	    ] 	exe_aluop_i,
    input  wire [`REG_BUS 		] 	exe_src1_i,
    input  wire [`REG_BUS 		] 	exe_src2_i,
    input  wire [`REG_ADDR_BUS 	] 	exe_wa_i,
    input  wire 					exe_wreg_i,
    input  wire                     exe_mreg_i,
    input  wire [`REG_BUS       ]   exe_din_i,
    input  wire                     exe_whilo_i,
    
    // 从HILO寄存器获取的数据
    input  wire [`REG_BUS       ]   hi_i,
    input  wire [`REG_BUS       ]   lo_i,

    // 送至执行阶段的信息
    output wire [`ALUOP_BUS	    ] 	exe_aluop_o,
    output wire [`REG_ADDR_BUS 	] 	exe_wa_o,
    output wire 					exe_wreg_o,
    output wire [`REG_BUS 		] 	exe_wd_o,
    output wire                     exe_mreg_o,
    output wire [`REG_BUS]          exe_din_o,
    output wire                     exe_whilo,
    output wire [`DOUBLE_REG_BUS]   exe_hilo_o
    );

    // 直接传到下一阶段
    assign exe_aluop_o = (cpu_rst_n == `RST_ENABLE)?8'b0:exe_aluop_i;
    assign exe_mreg_o = (cpu_rst_n == `RST_ENABLE)?1'b0:exe_mreg_i;
    assign exe_din_o = (cpu_rst_n == `RST_ENABLE)?32`b0:exe_din_i;
    assign exe_whilo_o = (cpu_rst_n == `RST_ENABLE)?1`b0:exe_whilo_i;
    
    wire [`REG_BUS       ]      logicres;       // 保存逻辑运算的结果
    wire [`REG_BUS       ]      shiftres;       // 保存移位运算结果
    
    
    // 根据内部操作码aluop进行逻辑运算
    assign logicres = (exe_aluop_i == `MINIMIPS32_AND )  ? (exe_src1_i & exe_src2_i) : `ZERO_WORD;

    assign exe_wa_o   = exe_wa_i;
    assign exe_wreg_o = exe_wreg_i;
    
    // 根据操作类型alutype确定执行阶段最终的运算结果（既可能是待写入目的寄存器的数据，也可能是访问数据存储器的地址）
    assign exe_wd_o = (exe_alutype_i == `LOGIC    ) ? logicres  : `ZERO_WORD;

endmodule