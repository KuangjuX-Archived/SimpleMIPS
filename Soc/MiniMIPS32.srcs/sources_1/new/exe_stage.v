`include "defines.v"

module exe_stage (
    input  wire cpu_rst_n,
    // ������׶λ�õ���Ϣ
    input  wire [`ALUTYPE_BUS	] 	exe_alutype_i,
    input  wire [`ALUOP_BUS	    ] 	exe_aluop_i,
    input  wire [`REG_BUS 		] 	exe_src1_i,
    input  wire [`REG_BUS 		] 	exe_src2_i,
    input  wire [`REG_ADDR_BUS 	] 	exe_wa_i,
    input  wire 					exe_wreg_i,
    input  wire                     exe_mreg_i,
    input  wire [`REG_BUS       ]   exe_din_i,
    input  wire                     exe_whilo_i,
    
    // ��HILO�Ĵ�����ȡ������
    input  wire [`REG_BUS       ]   hi_i,
    input  wire [`REG_BUS       ]   lo_i,

    // �ӷô�׶λ�õ� Hi, Lo �Ĵ�����ֵ
    input wire                      mem2exe_whilo_i,
    input wire [`DOUBLE_REG_BUS]    mem2exe_hilo_i,
    
    // ��д�ؽ׶λ�õ� Hi, Lo �Ĵ�����ֵ
    input wire                      wb2exe_whilo_i,
    input wire [`DOUBLE_REG_BUS]    wb2exe_hilo_i,

    // ����ִ�н׶ε���Ϣ
    output wire [`ALUOP_BUS	    ] 	exe_aluop_o,
    output wire [`REG_ADDR_BUS 	] 	exe_wa_o,
    output wire 					exe_wreg_o,
    output wire [`REG_BUS 		] 	exe_wd_o,
    output wire                     exe_mreg_o,
    output wire [`REG_BUS]          exe_din_o,
    output wire                     exe_whilo_o,
    output wire [`DOUBLE_REG_BUS]   exe_hilo_o,

    // ���ڶ���ǰ��
    output wire [`REG_BUS       ]   exe2id_wd_o,
    output wire [`REG_ADDR_BUS  ]   exe2id_wa_o,
    output wire                     exe2id_wreg_o
    );

    // ֱ�Ӵ�����һ�׶�
    assign exe_aluop_o = (cpu_rst_n == `RST_ENABLE)?8'b0:exe_aluop_i;
    assign exe_mreg_o = (cpu_rst_n == `RST_ENABLE)?1'b0:exe_mreg_i;
    assign exe_din_o = (cpu_rst_n == `RST_ENABLE)?32'b0:exe_din_i;
    assign exe_whilo_o = (cpu_rst_n == `RST_ENABLE)?1'b0:exe_whilo_i;
    
    wire [`REG_BUS       ]      logicres;       // �����߼�����Ľ��
    wire [`REG_BUS       ]      shiftres;       // ������λ������
    wire [`REG_BUS       ]      moveres;        // �����ƶ������Ľ��
    wire [`REG_BUS       ]      hi_t;           // ����Hi�Ĵ���������ֵ
    wire [`REG_BUS       ]      lo_t;           // ����Lo�Ĵ���������ֵ
    wire [`REG_BUS       ]      arithres;       // �������������Ľ��
    wire [`REG_BUS       ]      memres;         // ����ô������ַ
    wire [`DOUBLE_REG_BUS]      mulres;         // ����˷�ָ��Ľ�� 

    
    // �����ڲ�������aluop�����߼�����
    assign logicres = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD:
                      (exe_aluop_i == `MINIMIPS32_AND) ? (exe_src1_i & exe_src2_i):
                      (exe_aluop_i == `MINIMIPS32_ORI) ? (exe_src1_i | exe_src2_i):
                      (exe_aluop_i == `MINIMIPS32_LUI) ? exe_src2_i : `ZERO_WORD;

    // �����ڲ�������aluop������λ����
    assign shiftres = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD:
                      (exe_aluop_i == `MINIMIPS32_SLL) ? (exe_src2_i << exe_src1_i) : `ZERO_WORD;
    
    // �����ڲ�������aluop���������ƶ����õ����µ�HI��LO�Ĵ�����ֵ
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

    // �����ڲ�������aluop������������
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

    // �����ڲ�������aluop���г˷�������������������һ�׶�
    assign mulres = ($signed(exe_src1_i) * $signed(exe_src2_i));
    assign exe_hilo_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD:
                        (exe_aluop_i == `MINIMIPS32_MULT) ? mulres: 
                        (exe_aluop_i == `MINIMIPS32_MTHI) ? { moveres, {32{1'b0}} }:
                        (exe_aluop_i == `MINIMIPS32_MTLO) ? { {32{1'b0}}, moveres }:
                        `ZERO_WORD;

    assign exe_wa_o   = (cpu_rst_n == `RST_ENABLE) ? 5'b0: exe_wa_i;
    assign exe_wreg_o = (cpu_rst_n == `RST_ENABLE) ? 1'b0: exe_wreg_i;
    
    // ���ݲ�������alutypeȷ��ִ�н׶����յ����������ȿ����Ǵ�д��Ŀ�ļĴ��������ݣ�Ҳ�����Ƿ������ݴ洢���ĵ�ַ��
    assign exe_wd_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD:
                      (exe_alutype_i == `LOGIC ) ? logicres:
                      (exe_alutype_i == `SHIFT ) ? shiftres:
                      (exe_alutype_i == `MOVE ) ? moveres:
                      (exe_alutype_i == `ARITH ) ? arithres: `ZERO_WORD;

    // ����ǰ�Ʋ���
    // ����ֱ�ӽ�ִ�н׶εĽ����ֵ
    assign exe2id_wreg_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD: exe_wreg_o;
    assign exe2id_wa_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD: exe_wa_o;
    assign exe2id_wd_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD: exe_wd_o;

endmodule