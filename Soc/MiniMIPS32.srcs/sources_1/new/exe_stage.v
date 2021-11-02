`include "defines.v"

module exe_stage (
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

    // 从访存阶段获得的 Hi, Lo 寄存器的值
    input wire                      mem2exe_whilo_i,
    input wire [`DOUBLE_REG_BUS]    mem2exe_hilo_i,
    
    // 从写回阶段获得的 Hi, Lo 寄存器的值
    input wire                      wb2exe_whilo_i,
    input wire [`DOUBLE_REG_BUS]    wb2exe_hilo_i,

    // 送至执行阶段的信息
    output wire [`ALUOP_BUS	    ] 	exe_aluop_o,
    output wire [`REG_ADDR_BUS 	] 	exe_wa_o,
    output wire 					exe_wreg_o,
    output wire [`REG_BUS 		] 	exe_wd_o,
    output wire                     exe_mreg_o,
    output wire [`REG_BUS]          exe_din_o,
    output wire                     exe_whilo_o,
    output wire [`DOUBLE_REG_BUS]   exe_hilo_o,

    // 用于定向前推
    output wire [`REG_BUS       ]   exe2id_wd_o,
    output wire [`REG_ADDR_BUS  ]   exe2id_wa_o,
    output wire                     exe2id_wreg_o
    );

    // 直接传到下一阶段
    assign exe_aluop_o = (cpu_rst_n == `RST_ENABLE)?8'b0:exe_aluop_i;
    assign exe_mreg_o = (cpu_rst_n == `RST_ENABLE)?1'b0:exe_mreg_i;
    assign exe_din_o = (cpu_rst_n == `RST_ENABLE)?32'b0:exe_din_i;
    assign exe_whilo_o = (cpu_rst_n == `RST_ENABLE)?1'b0:exe_whilo_i;
    
    wire [`REG_BUS       ]      logicres;       // 保存逻辑运算的结果
    wire [`REG_BUS       ]      shiftres;       // 保存移位运算结果
    wire [`REG_BUS       ]      moveres;        // 保存移动操作的结果
    wire [`REG_BUS       ]      hi_t;           // 保存Hi寄存器的最新值
    wire [`REG_BUS       ]      lo_t;           // 保存Lo寄存器的最新值
    wire [`REG_BUS       ]      arithres;       // 保存算术操作的结果
    wire [`REG_BUS       ]      memres;         // 保存访存操作地址
    wire [`DOUBLE_REG_BUS]      mulres;         // 保存乘法指令的结果 

    
    // 根据内部操作码aluop进行逻辑运算
    assign logicres = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD:
                      (exe_aluop_i == `MINIMIPS32_AND) ? (exe_src1_i & exe_src2_i):
                      (exe_aluop_i == `MINIMIPS32_ORI) ? (exe_src1_i | exe_src2_i):
                      (exe_aluop_i == `MINIMIPS32_LUI) ? exe_src2_i : `ZERO_WORD;

    // 根据内部操作码aluop进行移位操作
    assign shiftres = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD:
                      (exe_aluop_i == `MINIMIPS32_SLL) ? (exe_src2_i << exe_src1_i) : `ZERO_WORD;
    
    // 根据内部操作数aluop进行数据移动，得到最新的HI、LO寄存器的值
    assign hi_t = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD: 
                  (mem2exe_whilo_i == `WRITE_ENABLE) ? mem2exe_hilo_i[63: 32] :
                  (wb2exe_whilo_i == `WRITE_ENABLE) ? wb2exe_hilo_i[63: 32] : hi_i; 

    assign lo_t = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD: 
                (mem2exe_whilo_i == `WRITE_ENABLE) ? mem2exe_hilo_i[31: 0] :
                (wb2exe_whilo_i == `WRITE_ENABLE) ? wb2exe_hilo_i[31: 0] : lo_i;

    assign moveres = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD:
                     (exe_aluop_i == `MINIMIPS32_MFHI) ? hi_t:
                     (exe_aluop_i == `MINIMIPS32_MFLO) ? lo_t: 
                     (exe_aluop_i == `MINIMIPS32_MTHI) ? exe_src1_i:
                     (exe_aluop_i == `MINIMIPS32_MTLO) ? exe_src1_i:
                     `ZERO_WORD;

    // 根据内部操作码aluop进行算术运算
    assign arithres = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD:
                      (exe_aluop_i == `MINIMIPS32_ADD) ? (exe_src1_i + exe_src2_i):
                      (exe_aluop_i == `MINIMIPS32_LB) ? (exe_src1_i + exe_src2_i):
                      (exe_aluop_i == `MINIMIPS32_LW) ? (exe_src1_i + exe_src2_i):
                      (exe_aluop_i == `MINIMIPS32_SB) ? (exe_src1_i + exe_src2_i):
                      (exe_aluop_i == `MINIMIPS32_SW) ? (exe_src1_i + exe_src2_i):
                      (exe_aluop_i == `MINIMIPS32_ADDIU) ? (exe_src1_i + exe_src2_i):
                      (exe_aluop_i == `MINIMIPS32_SUBU) ? (exe_src1_i + (~exe_src2_i) + 1):
                      (exe_aluop_i == `MINIMIPS32_SLT) ? (($signed(exe_src1_i) < $signed(exe_src2_i)) ? 32'b1: 32'b0):
                      (exe_aluop_i == `MINIMIPS32_SLTIU) ? ((exe_src1_i < exe_src2_i) ? 32'b1: 32'b0) : 
                      `ZERO_WORD;

    // 根据内部操作码aluop进行乘法操作，并保存送至下一阶段
    assign mulres = ($signed(exe_src1_i) * $signed(exe_src2_i));
    assign exe_hilo_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD:
                        (exe_aluop_i == `MINIMIPS32_MULT) ? mulres: 
                        (exe_aluop_i == `MINIMIPS32_MTHI) ? { moveres, {32{1'b0}} }:
                        (exe_aluop_i == `MINIMIPS32_MTLO) ? { {32{1'b0}}, moveres }:
                        `ZERO_WORD;

    assign exe_wa_o   = (cpu_rst_n == `RST_ENABLE) ? 5'b0: exe_wa_i;
    assign exe_wreg_o = (cpu_rst_n == `RST_ENABLE) ? 1'b0: exe_wreg_i;
    
    // 根据操作类型alutype确定执行阶段最终的运算结果（既可能是待写入目的寄存器的数据，也可能是访问数据存储器的地址）
    assign exe_wd_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD:
                      (exe_alutype_i == `LOGIC ) ? logicres:
                      (exe_alutype_i == `SHIFT ) ? shiftres:
                      (exe_alutype_i == `MOVE ) ? moveres:
                      (exe_alutype_i == `ARITH ) ? arithres: `ZERO_WORD;

    // 定向前推操作
    // 这里直接将执行阶段的结果赋值
    assign exe2id_wreg_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD: exe_wreg_o;
    assign exe2id_wa_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD: exe_wa_o;
    assign exe2id_wd_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD: exe_wd_o;

endmodule