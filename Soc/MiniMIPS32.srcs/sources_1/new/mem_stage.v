`include "defines.v"

module mem_stage (
    input wire                          cpu_rst_n,
    
    // 从执行阶段获得的信息
    input  wire [`ALUOP_BUS     ]       mem_aluop_i,
    input  wire [`REG_ADDR_BUS  ]       mem_wa_i,
    input  wire                         mem_wreg_i,
    input  wire [`REG_BUS       ]       mem_wd_i,
    input  wire                         mem_mreg_i,
    input  wire [`REG_BUS       ]       mem_din_i,
    input  wire                         mem_whilo_i,
    input  wire [`DOUBLE_REG_BUS]       mem_hilo_i,
    
    // 送至写回阶段的信息
    output wire [`REG_ADDR_BUS  ]       mem_wa_o,
    output wire                         mem_wreg_o,
    output wire [`REG_BUS       ]       mem_dreg_o,
    output wire                         mem_mreg_o,
    output wire [`BSEL_BUS      ]       dre,
    output wire                         mem_whilo_o,
    output wire [`DOUBLE_REG_BUS]       mem_hilo_o,
    
    // 送至数据存储器的信号
    output wire                         dce,
    output wire[`INST_ADDR_BUS  ]       daddr,
    output wire[`BSEL_BUS       ]       we,
    output wire[`REG_BUS        ]       din,

    // 用于定向前推
    // 送回译码阶段的信号量
    output wire                         mem2id_wreg_o,
    output wire [`REG_ADDR_BUS]         mem2id_wa_o,
    output wire [`REG_BUS]              mem2id_wd_o,

    // 送回执行阶段的信号量
    output wire                         mem2exe_whilo_o,
    output wire [`DOUBLE_REG_BUS]       mem2exe_hilo_o 
    );

    // 如果当前不是访存指令，则只需要把从执行阶段获得的信息直接输出
    assign mem_wa_o     = (cpu_rst_n == `RST_ENABLE) ? 5'b0 : mem_wa_i;
    assign mem_wreg_o   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : mem_wreg_i;
    assign mem_dreg_o   = (cpu_rst_n == `RST_ENABLE) ? 32'b0 : mem_wd_i;
    assign mem_whilo_o  = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : mem_whilo_i;
    assign mem_hilo_o   = (cpu_rst_n == `RST_ENABLE) ? 64'b0: mem_hilo_i;
    assign mem_mreg_o   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : mem_mreg_i;
    
    // 确定当前的访存指令 lb lh lw sb sh sw
    wire inst_lb = (mem_aluop_i == 8'h90);
    wire inst_lh = (mem_aluop_i == 8'h91);
    wire inst_lw = (mem_aluop_i == 8'h92);
    wire inst_sb = (mem_aluop_i == 8'h98);
    wire inst_sh = (mem_aluop_i == 8'h99);
    wire inst_sw = (mem_aluop_i == 8'h9A);
    
    // 获得数据存储器的访问地址
    assign daddr = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD : mem_wd_i;
    
    // 获得数据存储器读字节使能信号
    assign dre[3] = (cpu_rst_n == `RST_ENABLE) ? 1'b0:
                    ( (inst_lb & (daddr[1:0] == 2'b00) ) | inst_lw | (inst_lh & ( daddr[1:0] == 2'b00 | daddr[1:0] == 2'b11) ));
    assign dre[2] = (cpu_rst_n == `RST_ENABLE) ? 1'b0:
                    ( (inst_lb & (daddr[1:0] == 2'b01) ) | inst_lw | (inst_lh & ( daddr[1:0] == 2'b00 | daddr[1:0] == 2'b01) ));
    assign dre[1] = (cpu_rst_n == `RST_ENABLE) ? 1'b0:
                    ( (inst_lb & (daddr[1:0] == 2'b10) ) | inst_lw | (inst_lh & ( daddr[1:0] == 2'b01 | daddr[1:0] == 2'b10) ));
    assign dre[0] = (cpu_rst_n == `RST_ENABLE) ? 1'b0:
                    ( (inst_lb & (daddr[1:0] == 2'b11) ) | inst_lw | (inst_lh & ( daddr[1:0] == 2'b10 | daddr[1:0] == 2'b11) ));
                    
    // 获得数据存储器使能信号
    assign dce = (cpu_rst_n == `RST_ENABLE) ? 1'b0:
                 ( inst_lb | inst_lh | inst_lw | inst_sb | inst_sh | inst_sw );
                 
    // 获得数据存储器写字节使能信号
    assign we[3] = (cpu_rst_n == `RST_ENABLE) ? 1'b0:
                    ( (inst_sb & (daddr[1:0] == 2'b00) ) | inst_sw | (inst_sh & (daddr[1:0] == 2'b11 | daddr[1:0] == 2'b00 )));
    assign we[2] = (cpu_rst_n == `RST_ENABLE) ? 1'b0:
                    ( (inst_sb & (daddr[1:0] == 2'b01) ) | inst_sw | (inst_sh & (daddr[1:0] == 2'b00 | daddr[1:0] == 2'b01 )));
    assign we[1] = (cpu_rst_n == `RST_ENABLE) ? 1'b0:
                    ( (inst_sb & (daddr[1:0] == 2'b10) ) | inst_sw | (inst_sh & (daddr[1:0] == 2'b01 | daddr[1:0] == 2'b10 )));
    assign we[0] = (cpu_rst_n == `RST_ENABLE) ? 1'b0:
                    ( (inst_sb & (daddr[1:0] == 2'b11) ) | inst_sw | (inst_sh & (daddr[1:0] == 2'b10 | daddr[1:0] == 2'b11 )));
    
    // 确定待写入数据存储器的数据
    wire [`WORD_BUS] din_reverse = {mem_din_i[7:0], mem_din_i[15:8], mem_din_i[23:16], mem_din_i[31:24]};
    wire [`WORD_BUS] din_halfword = {mem_din_i[7:0], mem_din_i[15:8],mem_din_i[7:0], mem_din_i[15:8]};
    wire [`WORD_BUS] din_byte = {mem_din_i[7:0], mem_din_i[7:0], mem_din_i[7:0], mem_din_i[7:0]};
    assign din = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD :
                 (we == 4'b1111     ) ? din_reverse :
                 (we == 4'b1100     ) ? din_halfword:
                 (we == 4'b0110     ) ? din_halfword:
                 (we == 4'b0011     ) ? din_halfword:
                 (we == 4'b1001     ) ? din_halfword:
                 (we == 4'b1000     ) ? din_byte :
                 (we == 4'b0100     ) ? din_byte :
                 (we == 4'b0010     ) ? din_byte :
                 (we == 4'b0001     ) ? din_byte : `ZERO_WORD;

    // 定向前推
    // 定向前推至译码阶段的信号量
    assign mem2id_wreg_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD: mem_wreg_i;
    assign mem2id_wa_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD: mem_wa_i;
    assign mem2id_wd_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD: mem_wd_i;

    // 定向前推至执行阶段的信号量
    assign mem2exe_whilo_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD: mem_whilo_i;
    assign mem2exe_hilo_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD: mem_hilo_i;
                                 
endmodule