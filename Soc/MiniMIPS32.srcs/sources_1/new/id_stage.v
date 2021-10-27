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
    output wire [`REG_BUS      ]    id_retaddr_o,
      
    // ������ͨ�üĴ����Ѷ˿ڵ�ʹ�ܺ͵�ַ
    output wire                     rreg1,
    output wire [`REG_ADDR_BUS ]    ra1,
    output wire                     rreg2,
    output wire [`REG_ADDR_BUS ]    ra2
    );
    
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
    wire inst_add   = inst_reg& func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0];
    wire inst_subu  = inst_reg& func[5]&~func[4]&~func[3]&~func[2]& func[1]& func[0];
    wire inst_and   = inst_reg& func[5]&~func[4]&~func[3]& func[2]&~func[1]&~func[0];
    wire inst_slt   = inst_reg& func[5]&~func[4]& func[3]&~func[2]& func[1]&~func[0];
    wire inst_mult  = inst_reg&~func[5]& func[4]& func[3]&~func[2]&~func[1]&~func[0];
    wire inst_mfhi  = inst_reg&~func[5]& func[4]&~func[3]&~func[2]&~func[1]&~func[0];
    wire inst_mflo  = inst_reg&~func[5]& func[4]&~func[3]&~func[2]& func[1]&~func[0];
    wire inst_sll   = inst_reg&~func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0];
    wire inst_addiu = inst_imm&~op[5]&~op[4]& op[3]&~op[2]&~op[1]& op[0];
    wire inst_ori   = inst_imm&~op[5]&~op[4]& op[3]& op[2]&~op[1]& op[0];
    wire inst_sltiu = inst_imm&~op[5]&~op[4]& op[3]&~op[2]& op[1]& op[0];
    wire inst_lui   = inst_imm&~op[5]&~op[4]& op[3]& op[2]& op[1]& op[0];
    wire inst_lb    = inst_imm& op[5]&~op[4]&~op[3]&~op[2]&~op[1]&~op[0];
    wire inst_lw    = inst_imm& op[5]&~op[4]&~op[3]&~op[2]& op[1]& op[0];
    wire inst_sb    = inst_imm& op[5]&~op[4]& op[3]&~op[2]&~op[1]&~op[0];
    wire inst_sw    = inst_imm& op[5]&~op[4]& op[3]&~op[2]& op[1]& op[0];
   
    /*------------------------------------------------------------------------------*/

    /*-------------------- �ڶ��������߼������ɾ�������ź� --------------------*/
    wire inst_alu_reg   = (inst_add | inst_subu | inst_and | inst_slt);
    wire inst_alu_imm   = (inst_addiu | inst_ori | inst_sltiu | inst_lui);
    wire inst_imm_sign  = (inst_ori);
    wire inst_mf        = (inst_mfhi | inst_mflo);
    wire inst_shift     = (inst_sll);
    wire inst_lmem      = (inst_lb | inst_lw);
    wire inst_smem      = (inst_sb | inst_sw);
    wire inst_alu_logic = (inst_and | inst_ori | inst_lui);
    wire inst_alu_arith = (inst_add | inst_subu | inst_slt | inst_addiu | inst_sltiu | inst_lmem | inst_smem);

    wire rtsel  = (inst_alu_imm | inst_lmem | inst_smem);
    wire immsel = (inst_alu_imm | inst_lmem | inst_smem);
    wire sext   = (inst_imm_sign | inst_lmem | inst_smem);
    wire upper  = (inst_lui);

    wire [`REG_BUS] imm_ext = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD :
                               (upper) ? imm << 16 :
                               (sext) ? { { 16 {imm[15]} }, imm} : {`ZERO_HWORD, imm};
                              
    // ��������alutype
    assign id_alutype_o[2] = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : inst_shift;
    assign id_alutype_o[1] = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_alu_logic | inst_mf);
    assign id_alutype_o[0] = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_alu_arith | inst_mf);

    // �ڲ�������aluop
    assign id_aluop_o[7]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (                                                                                                                                          | inst_lb | inst_lw | inst_sb | inst_sw);
    assign id_aluop_o[6]   = 1'b0;
    assign id_aluop_o[5]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (                                  inst_slt |                                                                        inst_sltiu);
    assign id_aluop_o[4]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_add | inst_subu | inst_and |            inst_mult |                         inst_sll | inst_addiu | inst_ori                         | inst_lb | inst_lw | inst_sb | inst_sw);
    assign id_aluop_o[3]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_add | inst_subu | inst_and |                        inst_mfhi | inst_mflo |            inst_addiu | inst_ori                                             | inst_sb | inst_sw);
    assign id_aluop_o[2]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (                       inst_and | inst_slt | inst_mult | inst_mfhi | inst_mflo |                         inst_ori | inst_sltiu | inst_lui);
    assign id_aluop_o[1]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (           inst_subu |            inst_slt |                                                                        inst_sltiu                      | inst_lw           | inst_sw);
    assign id_aluop_o[0]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (           inst_subu |                                               inst_mflo | inst_sll | inst_addiu | inst_ori | inst_sltiu | inst_lui);

    // �Ƿ����ڴ�õ�������д�Ĵ���
    assign id_mreg_o       = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : inst_lmem;
    // дHILO�Ĵ���ʹ���ź�
    assign id_whilo_o      = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : inst_mult;
    // дͨ�üĴ���ʹ���ź�
    assign id_wreg_o       = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_alu_reg | inst_alu_imm | inst_mf | inst_shift | inst_lmem);
    // ��ͨ�üĴ����Ѷ˿�1ʹ���ź�
    assign rreg1 = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_alu_reg | inst_alu_imm | inst_mult | inst_lmem | inst_smem) & ~inst_lui;
    // ��ͨ�üĴ����Ѷ��˿�2ʹ���ź�
    assign rreg2 = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_alu_reg | inst_mult | inst_shift | inst_smem);
    /*------------------------------------------------------------------------------*/

    // ��ͨ�üĴ����Ѷ˿�1�ĵ�ַΪrs�ֶΣ����˿�2�ĵ�ַΪrt�ֶ�
    assign ra1   = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD : rs;
    assign ra2   = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD : rt;

    // ��ô�д��Ŀ�ļĴ����ĵ�ַ��rt��rd��
    assign id_wa_o      = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD :
                          (rtsel) ? rt : rd;

    // ���Դ������1�����shift�ź���Ч����Դ������1Ϊ��λλ��������Ϊ�Ӷ�ͨ�üĴ����Ѷ˿�1��õ�����
    assign id_src1_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD :
                       (inst_shift) ? sa :
                       (rreg1 == `READ_ENABLE   ) ? rd1 : `ZERO_WORD;

    // ���Դ������2�����immsel�ź���Ч����Դ������1Ϊ������������Ϊ�Ӷ�ͨ�üĴ����Ѷ˿�2��õ�����
    assign id_src2_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD :
                       (immsel) ? imm_ext :
                       (rreg2 == `READ_ENABLE   ) ? rd2 : `ZERO_WORD;

    assign id_din_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD :
                      (inst_smem) ? rd2 : `ZERO_WORD;
                      
    
endmodule
