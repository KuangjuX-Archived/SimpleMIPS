`include "defines.v"

module id_stage(
    input  wire                     cpu_rst_n,
    
    // ��ȡָ�׶λ�õ�PCֵ
    input  wire [`INST_ADDR_BUS]    id_pc_i,

    // ��ָ��洢��������ָ����
    input  wire [`INST_BUS     ]    id_inst_i,

    // ��ͨ�üĴ����Ѷ��������� 
    input  wire [`REG_BUS      ]    rd1,
    input  wire [`REG_BUS      ]    rd2,
    
    input wire                      exe2id_wreg,
    input wire [`REG_ADDR_BUS  ]    exe2id_wa,
    input wire [`REG_BUS       ]    exe2id_wd,
    input wire                      mem2id_wreg,
    input wire [`REG_ADDR_BUS  ]    mem2id_wa,
    input wire [`REG_BUS       ]    mem2id_wd,
    
    input wire                      exe2id_mreg,
    input wire                      mem2id_mreg,
      
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
    output wire [`REG_ADDR_BUS ]    ra2,
    
    output wire [ 1:0          ]    jtsel,
    output wire [`REG_BUS      ]    addr1,
    output wire [`REG_BUS      ]    addr2,
    output wire [`REG_BUS      ]    addr3,
    
    output wire                     stallreq_id,
    
    input  wire                     id_in_delay_i,
    input  wire                     flush_im,
    output wire [`REG_ADDR_BUS ]    cp0_addr,
    output wire [`INST_ADDR_BUS]    id_pc_o,
    output wire                     id_in_delay_o,
    output wire                     next_delay_o,
    output wire [`EXC_CODE_BUS ]    id_exccode_o
    );
    
    assign id_pc_o       = (cpu_rst_n == `RST_ENABLE) ? `PC_INIT : id_pc_i;
    assign id_in_delay_o = (cpu_rst_n == `RST_ENABLE) ? `FALSE_V : id_in_delay_i;
    
    // ����С��ģʽ��ָ֯����
    wire [`INST_BUS] id_inst = (flush_im == `FLUSH) ? `ZERO_WORD : {id_inst_i[7:0], id_inst_i[15:8], id_inst_i[23:16], id_inst_i[31:24]};

    // ��ȡָ�����и����ֶε���Ϣ
    wire [5 :0] op   = id_inst[31:26];
    wire [5 :0] func = id_inst[5 : 0];
    wire [4 :0] rd   = id_inst[15:11];
    wire [4 :0] rs   = id_inst[25:21];
    wire [4 :0] rt   = id_inst[20:16];
    wire [4 :0] sa   = id_inst[10: 6];
    wire [15:0] imm  = id_inst[15: 0]; 
    wire [25:0] instr_index = id_inst[25:0];

    /*-------------------- ��һ�������߼���ȷ����ǰ��Ҫ�����ָ�� --------------------*/
    wire inst_reg     = ~|op;
    wire inst_regimm  = ~op[5]&~op[4]&~op[3]&~op[2]&~op[1]& op[0];
    wire inst_add     = inst_reg& func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0];
    wire inst_subu    = inst_reg& func[5]&~func[4]&~func[3]&~func[2]& func[1]& func[0];
    wire inst_and     = inst_reg& func[5]&~func[4]&~func[3]& func[2]&~func[1]&~func[0];
    wire inst_slt     = inst_reg& func[5]&~func[4]& func[3]&~func[2]& func[1]&~func[0];
    wire inst_mult    = inst_reg&~func[5]& func[4]& func[3]&~func[2]&~func[1]&~func[0];
    wire inst_mfhi    = inst_reg&~func[5]& func[4]&~func[3]&~func[2]&~func[1]&~func[0];
    wire inst_mflo    = inst_reg&~func[5]& func[4]&~func[3]&~func[2]& func[1]&~func[0];
    wire inst_sll     = inst_reg&~func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0];
    wire inst_jr      = inst_reg&~func[5]&~func[4]& func[3]&~func[2]&~func[1]&~func[0];
    wire inst_div     = inst_reg&~func[5]& func[4]& func[3]&~func[2]& func[1]&~func[0];
    wire inst_break   = inst_reg&~func[5]&~func[4]& func[3]& func[2]&~func[1]& func[0];
    wire inst_syscall = inst_reg&~func[5]&~func[4]& func[3]& func[2]&~func[1]&~func[0];
    wire inst_addu    = inst_reg& func[5]&~func[4]&~func[3]&~func[2]&~func[1]& func[0];
    wire inst_sub     = inst_reg& func[5]&~func[4]&~func[3]&~func[2]& func[1]&~func[0];
    wire inst_sltu    = inst_reg& func[5]&~func[4]& func[3]&~func[2]& func[1]& func[0];
    wire inst_multu   = inst_reg&~func[5]& func[4]& func[3]&~func[2]&~func[1]& func[0];
    wire inst_or      = inst_reg& func[5]&~func[4]&~func[3]& func[2]&~func[1]& func[0];
    wire inst_xor     = inst_reg& func[5]&~func[4]&~func[3]& func[2]& func[1]&~func[0];
    wire inst_nor     = inst_reg& func[5]&~func[4]&~func[3]& func[2]& func[1]& func[0];
    wire inst_srl     = inst_reg&~func[5]&~func[4]&~func[3]&~func[2]& func[1]&~func[0];
    wire inst_sra     = inst_reg&~func[5]&~func[4]&~func[3]&~func[2]& func[1]& func[0];
    wire inst_sllv    = inst_reg&~func[5]&~func[4]&~func[3]& func[2]&~func[1]&~func[0];
    wire inst_srlv    = inst_reg&~func[5]&~func[4]&~func[3]& func[2]& func[1]&~func[0];
    wire inst_srav    = inst_reg&~func[5]&~func[4]&~func[3]& func[2]& func[1]& func[0];
    wire inst_mthi    = inst_reg&~func[5]& func[4]&~func[3]&~func[2]&~func[1]& func[0];
    wire inst_mtlo    = inst_reg&~func[5]& func[4]&~func[3]&~func[2]& func[1]& func[0];
    wire inst_jalr    = inst_reg&~func[5]&~func[4]& func[3]&~func[2]&~func[1]& func[0];
    wire inst_divu    = inst_reg&~func[5]& func[4]& func[3]&~func[2]& func[1]& func[0];
    wire inst_addiu   = ~op[5]&~op[4]& op[3]&~op[2]&~op[1]& op[0];
    wire inst_ori     = ~op[5]&~op[4]& op[3]& op[2]&~op[1]& op[0];
    wire inst_sltiu   = ~op[5]&~op[4]& op[3]&~op[2]& op[1]& op[0];
    wire inst_andi    = ~op[5]&~op[4]& op[3]& op[2]&~op[1]&~op[0];
    wire inst_xori    = ~op[5]&~op[4]& op[3]& op[2]& op[1]&~op[0];
    wire inst_lui     = ~op[5]&~op[4]& op[3]& op[2]& op[1]& op[0];
    wire inst_lb      =  op[5]&~op[4]&~op[3]&~op[2]&~op[1]&~op[0];
    wire inst_lh      =  op[5]&~op[4]&~op[3]&~op[2]&~op[1]& op[0];
    wire inst_lw      =  op[5]&~op[4]&~op[3]&~op[2]& op[1]& op[0];
    wire inst_lbu     =  op[5]&~op[4]&~op[3]& op[2]&~op[1]&~op[0];
    wire inst_lhu     =  op[5]&~op[4]&~op[3]& op[2]&~op[1]& op[0];
    wire inst_sb      =  op[5]&~op[4]& op[3]&~op[2]&~op[1]&~op[0];
    wire inst_sh      =  op[5]&~op[4]& op[3]&~op[2]&~op[1]& op[0];
    wire inst_sw      =  op[5]&~op[4]& op[3]&~op[2]& op[1]& op[0];
    wire inst_j       = ~op[5]&~op[4]&~op[3]&~op[2]& op[1]&~op[0];
    wire inst_jal     = ~op[5]&~op[4]&~op[3]&~op[2]& op[1]& op[0];
    wire inst_beq     = ~op[5]&~op[4]&~op[3]& op[2]&~op[1]&~op[0];
    wire inst_bne     = ~op[5]&~op[4]&~op[3]& op[2]&~op[1]& op[0];
    wire inst_addi    = ~op[5]&~op[4]& op[3]&~op[2]&~op[1]&~op[0];
    wire inst_slti    = ~op[5]&~op[4]& op[3]&~op[2]& op[1]&~op[0];
    wire inst_eret    = ~op[5]& op[4]&~op[3]&~op[2]&~op[1]&~op[0]&~func[5]& func[4]& func[3]&~func[2]&~func[1]&~func[0];
    wire inst_mfc0    = ~op[5]& op[4]&~op[3]&~op[2]&~op[1]&~op[0]&~id_inst[23];
    wire inst_mtc0    = ~op[5]& op[4]&~op[3]&~op[2]&~op[1]&~op[0]& id_inst[23];
    wire inst_bgtz    = ~op[5]&~op[4]&~op[3]& op[2]& op[1]& op[0];
    wire inst_blez    = ~op[5]&~op[4]&~op[3]& op[2]& op[1]&~op[0];
    wire inst_bltz    = inst_regimm&~rt[4]&~rt[3]&~rt[2]&~rt[1]&~rt[0];
    wire inst_bgez    = inst_regimm&~rt[4]&~rt[3]&~rt[2]&~rt[1]& rt[0];
    wire inst_bltzal  = inst_regimm& rt[4]&~rt[3]&~rt[2]&~rt[1]&~rt[0];
    wire inst_bgezal  = inst_regimm& rt[4]&~rt[3]&~rt[2]&~rt[1]& rt[0];
    /*------------------------------------------------------------------------------*/

    /*-------------------- �ڶ��������߼������ɾ�������ź� --------------------*/
    wire inst_alu_reg   = (inst_add | inst_subu | inst_and | inst_slt | inst_addu | inst_sub | inst_sltu | inst_or | inst_xor | inst_nor);
    wire inst_alu_imm   = (inst_addiu | inst_ori | inst_sltiu | inst_lui | inst_addi | inst_slti | inst_andi | inst_xori);
    wire inst_imm_sign  = (inst_addiu | inst_sltiu | inst_addi | inst_slti);
    wire inst_mf        = (inst_mfhi | inst_mflo);
    wire inst_mt        = (inst_mthi | inst_mtlo);
    wire inst_shift     = (inst_sll | inst_srl | inst_sra);
    wire inst_shiftv    = (inst_sllv | inst_srlv | inst_srav);
    wire inst_lmem      = (inst_lb | inst_lw | inst_lh | inst_lbu | inst_lhu);
    wire inst_smem      = (inst_sb | inst_sw | inst_sh);
    wire inst_alu_logic = (inst_and | inst_ori | inst_lui | inst_andi | inst_nor | inst_or | inst_xor | inst_xori);
    wire inst_alu_arith = (inst_add | inst_subu | inst_slt | inst_addiu | inst_sltiu | inst_addi | inst_addu | inst_sub | inst_slti | inst_sltu);
    wire inst_jump      = (inst_j | inst_jal | inst_jr | inst_jalr);
    wire inst_b         = (inst_beq | inst_bne | inst_bgez | inst_bgtz | inst_blez | inst_bltz | inst_bgezal | inst_bltzal);
    
    wire rtsel  = (inst_alu_imm | inst_lmem | inst_smem | inst_mfc0);
    wire immsel = (inst_alu_imm | inst_lmem | inst_smem);
    wire sext   = (inst_imm_sign | inst_lmem | inst_smem);
    wire upper  = (inst_lui);
    wire jal    = (inst_jal | inst_bgezal | inst_bltzal);
    
    wire [`REG_BUS] imm_ext = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD :
                               (upper) ? imm << 16 :
                               (sext) ? { { 16 {imm[15]} }, imm} : {`ZERO_HWORD, imm};
                              
    wire [`REG_BUS] pc_next = id_pc_i + 4;
                               
    wire [1:0] fwrd1;
    wire [1:0] fwrd2;
    wire equ;
    
    // ��������alutype
    assign id_alutype_o[2] = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_shift | inst_shiftv | inst_jump | inst_b | inst_syscall | inst_eret | inst_mtc0);
    assign id_alutype_o[1] = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_alu_logic | inst_mf | inst_syscall | inst_eret | inst_mfc0 | inst_mtc0 | inst_break);
    assign id_alutype_o[0] = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_alu_arith | inst_lmem | inst_smem | inst_mf | inst_jump | inst_b | inst_mfc0);

    // �ڲ�������aluop
    assign id_aluop_o[7]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (                                                                                                                                            inst_lb | inst_lw | inst_sb | inst_sw                                                                | inst_syscall | inst_eret | inst_mfc0 | inst_mtc0                                                                                                                                                                                                                                                                                               | inst_lh | inst_sh | inst_lbu | inst_lhu                        | inst_break); // 7
    assign id_aluop_o[6]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (                                                                                                                                                                                                                                                                                                      inst_addi | inst_addu | inst_sub                                                                                                                                        | inst_andi | inst_or | inst_xori                       | inst_sllv | inst_srlv | inst_srav                                                                                                      ); // 6                                                                                                                                                                                                                                                                                                                                     // 6
    assign id_aluop_o[5]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (                                  inst_slt                                                                        | inst_sltiu                                                    | inst_j | inst_jal | inst_jr | inst_beq | inst_bne                                                                                                  | inst_slti | inst_sltu              | inst_bgez | inst_bgtz | inst_blez | inst_bltz | inst_bgezal | inst_bltzal                                                                                                                                                                                     | inst_jalr                        ); // 5
    assign id_aluop_o[4]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_add | inst_subu | inst_and |            inst_mult |                         inst_sll | inst_addiu | inst_ori                         | inst_lb | inst_lw | inst_sb | inst_sw                               | inst_beq | inst_bne | inst_div                                                                                                               | inst_multu | inst_bgez | inst_bgtz | inst_blez | inst_bltz | inst_bgezal | inst_bltzal | inst_xor | inst_nor                                   | inst_srl | inst_sra                                                             | inst_lh | inst_sh | inst_lbu | inst_lhu             | inst_divu            ); // 4
    assign id_aluop_o[3]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_add | inst_subu | inst_and |                        inst_mfhi | inst_mflo |            inst_addiu | inst_ori                                             | inst_sb | inst_sw | inst_j | inst_jal | inst_jr                                                             | inst_mfc0 | inst_mtc0 | inst_addi | inst_addu | inst_sub | inst_slti | inst_sltu              | inst_bgez                                                                 | inst_xor | inst_nor | inst_andi | inst_or | inst_xori                                                           | inst_mthi | inst_mtlo           | inst_sh | inst_lbu | inst_lhu | inst_jalr                        ); // 3
    assign id_aluop_o[2]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (                       inst_and | inst_slt | inst_mult | inst_mfhi | inst_mflo |                         inst_ori | inst_sltiu | inst_lui                                         | inst_j | inst_jal | inst_jr                       | inst_div | inst_syscall | inst_eret | inst_mfc0 | inst_mtc0                                                            | inst_multu                                     | inst_bltz | inst_bgezal | inst_bltzal | inst_xor | inst_nor | inst_andi | inst_or | inst_xori                                                           | inst_mthi | inst_mtlo                                | inst_lhu | inst_jalr | inst_divu| inst_break); // 2
    assign id_aluop_o[1]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (           inst_subu |            inst_slt |                                                                        inst_sltiu                      | inst_lw           | inst_sw          | inst_jal                                 | inst_div | inst_syscall | inst_eret                                                 | inst_sub                                                  | inst_bgtz | inst_blez             | inst_bgezal | inst_bltzal | inst_xor | inst_nor                       | inst_xori | inst_srl | inst_sra             | inst_srlv | inst_srav | inst_mthi | inst_mtlo                     | inst_lbu            | inst_jalr | inst_divu            ); // 1
    assign id_aluop_o[0]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (           inst_subu |                                               inst_mflo | inst_sll | inst_addiu | inst_ori | inst_sltiu | inst_lui                                                             | inst_jr            | inst_bne                           | inst_eret             | inst_mtc0             | inst_addu | inst_sub             | inst_sltu | inst_multu | inst_bgez | inst_bgtz                         | inst_bgezal                          | inst_nor             | inst_or                        | inst_sra | inst_sllv             | inst_srav             | inst_mtlo | inst_lh | inst_sh | inst_lbu            | inst_jalr | inst_divu| inst_break); // 0

    // �Ƿ����ڴ�õ�������д�Ĵ���
    assign id_mreg_o       = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : inst_lmem;
    // дHILO�Ĵ���ʹ���ź�
    assign id_whilo_o      = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_mult | inst_multu | inst_div | inst_divu | inst_mt);
    // дͨ�üĴ���ʹ���ź�
    assign id_wreg_o       = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : jal ? `WRITE_ENABLE :
                             (inst_alu_reg | inst_alu_imm | inst_mf | inst_shift | inst_shiftv | inst_lmem | inst_mfc0 | inst_jalr);
    // ��ͨ�üĴ����Ѷ˿�1ʹ���ź�
    assign rreg1 = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_alu_reg | inst_alu_imm | inst_mult | inst_multu | inst_div | inst_divu | inst_shiftv | inst_mt | inst_lmem | inst_smem | inst_jr | inst_b | inst_jalr) & ~inst_lui;
    // ��ͨ�üĴ����Ѷ��˿�2ʹ���ź�
    assign rreg2 = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_alu_reg | inst_mult | inst_multu | inst_div | inst_divu | inst_shift | inst_shiftv | inst_smem | inst_beq | inst_bne | inst_mtc0);
    //����ǰ�ƿ����ź�
    assign fwrd1[0] = (exe2id_wreg == `WRITE_ENABLE) & (exe2id_wa == rs);
    assign fwrd1[1] = (mem2id_wreg == `WRITE_ENABLE) & (mem2id_wa == rs);
    assign fwrd2[0] = (exe2id_wreg == `WRITE_ENABLE) & (exe2id_wa == rt);
    assign fwrd2[1] = (mem2id_wreg == `WRITE_ENABLE) & (mem2id_wa == rt);
    /*------------------------------------------------------------------------------*/

    // ��ͨ�üĴ����Ѷ˿�1�ĵ�ַΪrs�ֶΣ����˿�2�ĵ�ַΪrt�ֶ�
    assign ra1   = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD : rs;
    assign ra2   = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD : rt;
                                            
    // ��ô�д��Ŀ�ļĴ����ĵ�ַ��rt��rd��
    assign id_wa_o      = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD :
                          (jal) ? 5'b11111 :
                          (rtsel) ? rt : rd;

    // ���Դ������1�����shift�ź���Ч����Դ������1Ϊ��λλ��������Ϊ�Ӷ�ͨ�üĴ����Ѷ˿�1��õ�����
    assign id_src1_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD :
                       (inst_shift) ? sa :
                       (rreg1 == `READ_DISABLE) ? `ZERO_WORD :
                       (fwrd1[0] == 1'b1) ? exe2id_wd :
                       (fwrd1[1] == 1'b1) ? mem2id_wd : rd1;

    // ���Դ������2�����immsel�ź���Ч����Դ������1Ϊ������������Ϊ�Ӷ�ͨ�üĴ����Ѷ˿�2��õ�����
    assign id_src2_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD :
                       (immsel) ? imm_ext :
                       (rreg2 == `READ_DISABLE) ? `ZERO_WORD :
                       (fwrd2[0] == 1'b1) ? exe2id_wd :
                       (fwrd2[1] == 1'b1) ? mem2id_wd : rd2;
    
    assign id_din_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD :
                      (inst_smem) ? 
                      ((rreg2 == `READ_DISABLE) ? `ZERO_WORD :
                      (fwrd2[0] == 1'b1) ? exe2id_wd :
                      (fwrd2[1] == 1'b1) ? mem2id_wd : rd2) : `ZERO_WORD;
                      
                      
    assign id_retaddr_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD : (id_pc_i + 8);
                      
    assign equ = inst_beq ? id_src1_o == id_src2_o :
                 inst_bne ? id_src1_o != id_src2_o :
                 inst_bgtz ? $signed(id_src1_o) > $signed(0) :
                 inst_blez ? $signed(id_src1_o) <= $signed(0) :
                 (inst_bgez | inst_bgezal) ? ~id_src1_o[31] :
                 (inst_bltz | inst_bltzal) ?  id_src1_o[31] : 1'b0;
    assign jtsel[0] = inst_jr | inst_jalr | (inst_b & equ);
    assign jtsel[1] = inst_j | inst_jal | (inst_b & equ);
    
    assign addr1 = {pc_next[31:28], instr_index, 2'b00};
    assign addr2 = pc_next + { { 14 {imm[15]} }, imm, 2'b00};
    assign addr3 = id_src1_o;
    
    assign stallreq_id = (cpu_rst_n == `RST_ENABLE) ? `NOSTOP :
                         (((exe2id_wreg == `WRITE_ENABLE && exe2id_wa == ra1 && rreg1 == `READ_ENABLE) ||
                         (exe2id_wreg == `WRITE_ENABLE && exe2id_wa == ra2 && rreg2 == `READ_ENABLE)) && (exe2id_mreg == `TRUE_V)) ? `STOP :
                         (((mem2id_wreg == `WRITE_ENABLE && mem2id_wa == ra1 && rreg1 == `READ_ENABLE) ||
                         (mem2id_wreg == `WRITE_ENABLE && mem2id_wa == ra2 && rreg2 == `READ_ENABLE)) && (mem2id_mreg == `TRUE_V)) ? `STOP : `NOSTOP;
                         
    assign next_delay_o = (cpu_rst_n == `RST_ENABLE) ? `FALSE_V : (inst_jump | inst_b);
    
    assign id_exccode_o = (cpu_rst_n == `RST_ENABLE) ? `EXC_NONE :
                          (id_aluop_o == 8'h00) ? `EXC_RI :
                          (inst_syscall == `TRUE_V ) ? `EXC_SYS :
                          (inst_break == `TRUE_V) ? `EXC_BREAK :
                          (inst_eret == `TRUE_V ) ? `EXC_ERET : `EXC_NONE;
                          
    assign cp0_addr = (cpu_rst_n == `RST_ENABLE) ? `REG_NOP : rd;

endmodule
