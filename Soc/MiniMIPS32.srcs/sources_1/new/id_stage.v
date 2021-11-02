`include "defines.v"

module id_stage(
    input  wire                    cpu_rst_n,
    // ��ȡָ�׶λ�õ�PCֵ
    input  wire [`INST_ADDR_BUS]    id_pc_i,

    // ��ָ��洢��������ָ����
    input  wire [`INST_BUS     ]    id_inst_i,

    // ��ͨ�üĴ����Ѷ��������� 
    input  wire [`REG_BUS      ]    rd1,
    input  wire [`REG_BUS      ]    rd2,

    // ��ִ�н׶λ�õ�д���źţ�����������ǰ��
    input wire                 exe2id_wreg_i,
    input wire [`REG_ADDR_BUS] exe2id_wa_i,
    input wire [`INST_BUS]     exe2id_wd_i,

    // �ӷô�׶λ�õ�д���źţ�����������ǰ��
    input wire                 mem2id_wreg_i,
    input wire [`REG_ADDR_BUS] mem2id_wa_i,
    input wire [`INST_BUS]     mem2id_wd_i,
      
    // ����ִ�н׶ε�������Ϣ
    output wire [`ALUTYPE_BUS  ]    id_alutype_o,
    output wire [`ALUOP_BUS    ]    id_aluop_o,
    output wire [`REG_ADDR_BUS ]    id_wa_o,
    output wire                     id_wreg_o,
    output wire                     id_whilo_o,
    output wire                     id_mreg_o,

    // ����ִ�н׶ε�Դ������1��Դ������2
    output wire [`REG_BUS      ]    id_src1_o,
    output wire [`REG_BUS      ]    id_src2_o,
    output wire [`DATA_BUS     ]    id_din_o,
    //output wire [`REG_BUS      ]    id_retaddr_o,
      
    // ������ͨ�üĴ����Ѷ˿ڵ�ʹ�ܺ͵�ַ
    output wire                     rreg1,
    output wire [`REG_ADDR_BUS ]    ra1,
    output wire                     rreg2,
    output wire [`REG_ADDR_BUS ]    ra2
    );

    // ����Դ������ѡ���źţ�Դ��������������ִ����ô�׶Σ�����ǰ�ƣ� 
    wire [1: 0] fwrd1 = (cpu_rst_n == `RST_ENABLE) ? 2'b00:
                        (exe2id_wreg_i == `WRITE_ENABLE && exe2id_wa_i == ra1 && rreg1 == `READ_ENABLE) ? 2'b01:
                        (mem2id_wreg_i == `WRITE_ENABLE && mem2id_wa_i == ra1 && rreg1 == `READ_ENABLE) ? 2'b10:
                        (rreg1 == `READ_ENABLE) ? 2'b11: 2'b00;

    wire [1: 0] fwrd2 = (cpu_rst_n == `RST_ENABLE) ? 2'b00:
                        (exe2id_wreg_i == `WRITE_ENABLE && exe2id_wa_i == ra2 && rreg2 == `READ_ENABLE) ? 2'b01:
                        (mem2id_wreg_i == `WRITE_ENABLE && mem2id_wa_i == ra2 && rreg2 == `READ_ENABLE) ? 2'b10:
                        (rreg1 == `READ_ENABLE) ? 2'b11: 2'b00;

    
    // ����С��ģʽ��ָ֯����
    wire [`INST_BUS] id_inst = {id_inst_i[7:0], id_inst_i[15:8], id_inst_i[23:16], id_inst_i[31:24]};

    // ��ȡָ�����и����ֶε���Ϣ
    wire [5 :0] op   = id_inst[31:26];
    wire [5 :0] func = id_inst[5 : 0];
    wire [4 :0] rd   = id_inst[15:11];
    wire [4 :0] rs   = id_inst[25:21];
    wire [4 :0] rt   = id_inst[20:16];
    wire [4 :0] sa   = id_inst[10: 6];
    wire [15:0] imm  = id_inst[15: 0]; 


    /*-------------------- ��һ�������߼���ȷ����ǰ��Ҫ�����ָ�� --------------------*/
    wire inst_reg   = ~|op;
     // �ݲ�����J��ָ�� 
    wire inst_imm   = ~inst_reg;

    // R-type ָ��
    wire inst_add   = inst_reg& func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0];
    wire inst_subu  = inst_reg& func[5]&~func[4]&~func[3]&~func[2]& func[1]& func[0];
    wire inst_and   = inst_reg& func[5]&~func[4]&~func[3]& func[2]&~func[1]&~func[0];
    wire inst_slt   = inst_reg& func[5]&~func[4]& func[3]&~func[2]& func[1]&~func[0];
    wire inst_mult  = inst_reg&~func[5]& func[4]& func[3]&~func[2]&~func[1]&~func[0];
    wire inst_mfhi  = inst_reg&~func[5]& func[4]&~func[3]&~func[2]&~func[1]&~func[0];
    wire inst_mflo  = inst_reg&~func[5]& func[4]&~func[3]&~func[2]& func[1]&~func[0];
    wire inst_mthi  = inst_reg&~func[5]& func[4]&~func[3]&~func[2]&~func[1]& func[0];
    wire inst_mtlo  = inst_reg&~func[5]& func[4]&~func[3]&~func[2]& func[1]& func[0];
    wire inst_sll   = inst_reg&~func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0];
    wire inst_or    = inst_reg& func[5]&~func[4]&~func[3]& func[2]&~func[1]& func[0];
    wire inst_nor   = inst_reg& func[5]&~func[4]&~func[3]& func[2]& func[1]& func[0];
    wire inst_xor   = inst_reg& func[5]&~func[4]&~func[3]& func[2]& func[1]&~func[0];
    wire inst_sllv  = inst_reg&~func[5]&~func[4]&~func[3]& func[2]&~func[1]&~func[0];

    // I-type ָ��
    wire inst_andi  = inst_imm&~op[5]&~op[4]& op[3]& op[2]&~op[1]&~op[0];
    wire inst_addiu = inst_imm&~op[5]&~op[4]& op[3]&~op[2]&~op[1]& op[0];
    wire inst_ori   = inst_imm&~op[5]&~op[4]& op[3]& op[2]&~op[1]& op[0];
    wire inst_sltiu = inst_imm&~op[5]&~op[4]& op[3]&~op[2]& op[1]& op[0];
    wire inst_lui   = inst_imm&~op[5]&~op[4]& op[3]& op[2]& op[1]& op[0];
    wire inst_lb    = inst_imm& op[5]&~op[4]&~op[3]&~op[2]&~op[1]&~op[0];
    wire inst_lw    = inst_imm& op[5]&~op[4]&~op[3]&~op[2]& op[1]& op[0];
    wire inst_sb    = inst_imm& op[5]&~op[4]& op[3]&~op[2]&~op[1]&~op[0];
    wire inst_sw    = inst_imm& op[5]&~op[4]& op[3]&~op[2]& op[1]& op[0];
    wire inst_xori  = inst_imm&~op[5]&~op[4]& op[3]& op[2]& op[1]&~op[0];
    wire inst_lbu   = inst_imm& op[5]&~op[4]&~op[3]& op[2]&~op[1]&~op[0];
   
    /*------------------------------------------------------------------------------*/

    /*-------------------- �ڶ��������߼������ɾ�������ź� --------------------*/
    // ALU R-type ָ��
    wire inst_alu_reg   = (
        inst_add | inst_subu | inst_and | inst_slt |
        inst_or | inst_nor | inst_xor | inst_sllv
    );
    // ALU I-type ָ��
    wire inst_alu_imm   = (
        inst_addiu | inst_ori | inst_sltiu | inst_lui |
        inst_andi | inst_xori
    );
    // ������������չָ��
    wire inst_imm_sign = 1'b0;

    wire inst_mf        = (inst_mfhi | inst_mflo);
    // ��λʹ���ź�
    wire inst_shift     = (inst_sll | inst_sllv);
    // // ����ָ��(������չ)
    // wire inst_lmem_s    = (inst_lb | inst_lw);
    // // ����ָ��(�Ƿ�����չ)
    // wire inst_lmem_u    = (inst_lbu);
    // // �洢ָ��(������չ)
    // wire inst_smem_s    = (inst_sb | inst_sw);
    // // �洢ָ��(�Ƿ�����չ)
    // wire inst_smem_u    = (1'b0);
    // �߼�����ָ��
    wire inst_alu_logic = (
        inst_andi | inst_and | inst_ori | inst_or |
        inst_lui | inst_nor | inst_xor | inst_xori
    );
    // ��ֵ����ָ��
    wire inst_alu_arith = (
        inst_add | inst_subu | inst_slt | inst_addiu | 
        inst_sltiu | inst_lw | inst_lb  | inst_lbu |
        inst_sb | inst_sw
    );

    // Ŀ�ļĴ���ѡ���ź�
    wire rtsel  = (
        inst_alu_imm | 
        inst_lb | inst_lbu | inst_lw | inst_sb |
        inst_sw
    );
    // ������ʹ���ź�
    wire immsel = (
        inst_alu_imm |
        inst_lb | inst_lbu | inst_lw | inst_sb |
        inst_sw
    );

    // �Ƿ���з�����չ�ź�
    wire sext   = (
        inst_imm_sign |
        inst_lb | inst_lw | inst_sb | inst_sw
    );
    // ���ظ߰���ʹ���ź�
    wire upper  = (inst_lui);

    wire [`REG_BUS] imm_ext = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD :
                               (upper == `UPPER_ENABLE) ? (imm << 16) :
                               (sext == `SIGNED_EXT) ? { { 16{imm[15]} }, imm} : {{16{1'b0}}, imm};
                              
    // ��������alutype
    assign id_alutype_o[2] = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : inst_shift;
    assign id_alutype_o[1] = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_alu_logic | inst_mf);
    assign id_alutype_o[0] = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_alu_arith | inst_mf);


    // �ڲ�������aluop
    assign id_aluop_o[7]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (
        inst_lb | inst_lw | inst_sb | inst_sw |
        inst_lbu
    );
    assign id_aluop_o[6]   = 1'b0;
    assign id_aluop_o[5]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_slt | inst_sltiu | inst_sllv);
    assign id_aluop_o[4]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (
        inst_add | inst_subu | inst_and | inst_mult |
        inst_sll | inst_addiu | inst_ori | inst_lb |
        inst_lw | inst_sb | inst_sw | inst_sllv |
        inst_lbu
    );
    assign id_aluop_o[3]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (
        inst_add | inst_subu | inst_and | inst_mfhi | 
        inst_mflo | inst_mthi | inst_mtlo | inst_addiu |
        inst_ori | inst_sb | inst_sw 
    );
    assign id_aluop_o[2]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (
        inst_and | inst_slt | inst_mult | inst_mfhi |
        inst_mflo | inst_mthi | inst_mtlo | inst_ori |
        inst_sltiu | inst_lui | inst_xor | inst_xori
    );
    assign id_aluop_o[1]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (
        inst_subu | inst_slt | inst_mthi | inst_mtlo |
        inst_sltiu | inst_lw | inst_sw | inst_or | inst_nor |
        inst_xor | inst_xori
    );
    assign id_aluop_o[0]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (
        inst_subu | inst_mflo  | inst_mtlo | inst_sll | 
        inst_addiu | inst_ori | inst_sltiu | inst_lui |
        inst_andi | inst_nor | inst_xori
    );

    // �洢�����Ĵ���ʹ���ź�
    assign id_mreg_o       = (cpu_rst_n == `RST_ENABLE) ? 1'b0:
                             (inst_lb | inst_lbu | inst_lw); 

    // дHILO�Ĵ���ʹ���ź�
    assign id_whilo_o      = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (
        inst_mult | inst_mthi | inst_mtlo
    );

    // дͨ�üĴ���ʹ���ź�
    assign id_wreg_o       = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (
        inst_alu_reg | inst_alu_imm | inst_mf | inst_shift |
        inst_lb | inst_lbu | inst_sw
    );

    // ��ͨ�üĴ����Ѷ˿�1ʹ���ź�
    assign rreg1 = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (
        inst_alu_reg | inst_alu_imm | inst_mult | inst_mthi | 
        inst_mtlo | inst_lb | inst_lbu | inst_lw |
        inst_sb | inst_sw
    ) & ~inst_lui;

    // ��ͨ�üĴ����Ѷ��˿�2ʹ���ź�
    assign rreg2 = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (
        inst_alu_reg | inst_mult | inst_shift | inst_sb |
        inst_sw
    );
    /*------------------------------------------------------------------------------*/

    // ��ͨ�üĴ����Ѷ˿�1�ĵ�ַΪrs�ֶΣ����˿�2�ĵ�ַΪrt�ֶ�
    assign ra1   = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD : rs;
    assign ra2   = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD : rt;

    // ��ô�д��Ŀ�ļĴ����ĵ�ַ��rt��rd��
    assign id_wa_o      = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD :
                          (rtsel == `RT_ENABLE) ? rt : rd;

    // ���Դ������1�����shift�ź���Ч����Դ������1Ϊ��λλ��������Ϊ�Ӷ�ͨ�üĴ����Ѷ˿�1��õ�����
    // Դ������1Ҳ��������ִ�н׶�ǰ�Ƶ����ݻ��߷ô�׶�ǰ�Ƶ�����
    assign id_src1_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD :
                       (inst_shift) ? {27'b0, sa} :
                       (fwrd1 == 2'b01) ? exe2id_wd_i :
                       (fwrd1 == 2'b10) ? mem2id_wd_i :
                       (fwrd1 == 2'b11) ? rd1: `ZERO_WORD;

    // ���Դ������2�����immsel�ź���Ч����Դ������1Ϊ������������Ϊ�Ӷ�ͨ�üĴ����Ѷ˿�2��õ�����
    // Դ������2Ҳ����������ִ�н׶�ǰ�Ƶ����ݻ��߷ô�׶�ǰ�Ƶ�����
    assign id_src2_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD :
                       (immsel == `IMM_ENABLE) ? imm_ext :
                       (fwrd2 == 2'b01) ? exe2id_wd_i :
                       (fwrd2 == 2'b10) ? mem2id_wd_i :
                       (fwrd2 == 2'b11) ? rd2 : `ZERO_WORD;

    // ��÷ô�׶�Ҫ�������ݴ洢�������ݣ���������ִ�н׶�ǰ�Ƶ����ݣ�Ҳ�������Էô�׶�ǰ�Ƶ����ݣ�
    // Ҳ��������ͨ�üĴ����Ķ��˿�2
    assign id_din_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD :
                      (fwrd2 == 2'b01) ? exe2id_wd_i :
                      (fwrd2 == 2'b10) ? mem2id_wd_i :
                      (fwrd2 == 2'b11) ? rd2 : `ZERO_WORD;
                      
    
endmodule
