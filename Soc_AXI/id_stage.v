`include "defines.v"

module id_stage(
    input  wire                     cpu_rst_n,
    // 从取指阶段获得的PC值
    input  wire [`INST_ADDR_BUS]    id_pc_i,

    // 从指令存储器读出的指令字
    input  wire [`INST_BUS     ]    id_inst_i,

    // 从通用寄存器堆读出的数据 
    input  wire [`REG_BUS      ]    rd1,
    input  wire [`REG_BUS      ]    rd2,
    
    //从执行阶段获得的写回信号
    input  wire                     exe2id_wreg,
    input  wire [`REG_ADDR_BUS ]    exe2id_wa, 
    input  wire [`INST_BUS     ]    exe2id_wd,
    
    //从访存阶段获得的写回信息
    input  wire                     mem2id_wreg,
    input  wire [`REG_ADDR_BUS ]    mem2id_wa, 
    input  wire [`INST_BUS     ]    mem2id_wd,
    
    //从执行阶段和访存阶段回传的存储器到寄存器的使能信号
    input  wire                     exe2id_mreg,
    input  wire                     mem2id_mreg,
    
    input  wire [`INST_ADDR_BUS]    pc_plus_4,
    
    input  wire                     id_in_delay_i,  //处于译码阶段的指令是延迟槽指令
    input  wire                     flush_im,       //清空从指令存储器读出的指令
    input  wire                     mem_mem_flag,
    input  wire [`EXC_CODE_BUS ]    id_exccode_i,
      
    // 送至执行阶段的译码信息
    output wire [`ALUTYPE_BUS  ]    id_alutype_o,
    output wire [`ALUOP_BUS    ]    id_aluop_o,
    output wire [`REG_ADDR_BUS ]    id_wa_o,
    output wire                     id_wreg_o,
    output wire                     id_whilo_o, //写hilo寄存器使能
    output wire                     id_mreg_o, //决定写回寄存器的是ALU运算的结果还是访存结果
    output wire [`REG_BUS]          id_din_o, //待写入数据存储器的数据
    output wire                     id_whi_o, //写hi寄存器（mthi）
    output wire                     id_wlo_o, //写lo寄存器（mtlo）
   
    // 送至执行阶段的源操作数1、源操作数2
    output wire [`REG_BUS      ]    id_src1_o,
    output wire [`REG_BUS      ]    id_src2_o,
      
    // 送至读通用寄存器堆端口的使能和地址
    output wire                     rreg1,
    output wire [`REG_ADDR_BUS ]    ra1,
    output wire                     rreg2,
    output wire [`REG_ADDR_BUS ]    ra2,
    
    output wire [`INST_ADDR_BUS]    jump_addr_1,
    output wire [`INST_ADDR_BUS]    jump_addr_2,
    output wire [`INST_ADDR_BUS]    jump_addr_3,
    output wire [`JTSEL_BUS    ]    jtsel,
    output wire [`INST_ADDR_BUS]    ret_addr,    //保存值31号寄存器的pc+8
    
    output wire                     stallreq_id,     //译码阶段发出的暂停请求信号
    
    output wire [`REG_ADDR_BUS ]    cp0_addr,        //cp0寄存器的地址
    output wire [`INST_ADDR_BUS]    id_pc_o,        //处于译码阶段的指令的pc值
    output wire                     id_in_delay_o,  //处于译码阶段的指令是延迟槽指令
    output wire                     next_delay_o,   //下一条进入译码阶段的指令是延迟槽指令
    output wire [`EXC_CODE_BUS ]    id_exccode_o    //处于译码阶段的指令的异常类型
        );
    //译码模块
    // 根据小端模式组织指令字
    //如果清空信号flush_im == 1或上一条指令执行到mem阶段访存，则取出的指令为空指令
    // wire [`INST_BUS] id_inst = (flush_im == `FLUSH || mem_mem_flag == 1'b1) ? `ZERO_WORD : {id_inst_i[7:0], id_inst_i[15:8], id_inst_i[23:16], id_inst_i[31:24]};
    wire [`INST_BUS] id_inst = (flush_im == `FLUSH || mem_mem_flag == 1'b1) ? `ZERO_WORD : id_inst_i;
    // 提取指令字中各个字段的信息
    wire [5 :0] op   = id_inst[31:26];
    wire [5 :0] func = id_inst[5 : 0];
    wire [4 :0] rd   = id_inst[15:11];
    wire [4 :0] rs   = id_inst[25:21];
    wire [4 :0] rt   = id_inst[20:16];
    wire [4 :0] sa   = id_inst[10: 6];
    wire [15:0] imm  = id_inst[15: 0]; 

    /*-------------------- 第一级译码逻辑：确定当前需要译码的指令 --------------------*/
    wire inst_reg   = ~|op;
    wire inst_add   = inst_reg& func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0];
    wire inst_subu  = inst_reg& func[5]&~func[4]&~func[3]&~func[2]& func[1]& func[0];
    wire inst_slt   = inst_reg& func[5]&~func[4]& func[3]&~func[2]& func[1]&~func[0];
    wire inst_and   = inst_reg& func[5]&~func[4]&~func[3]& func[2]&~func[1]&~func[0];
    wire inst_mult  = inst_reg&~func[5]& func[4]& func[3]&~func[2]&~func[1]&~func[0];
    wire inst_mfhi  = inst_reg&~func[5]& func[4]&~func[3]&~func[2]&~func[1]&~func[0];
    wire inst_mflo  = inst_reg&~func[5]& func[4]&~func[3]&~func[2]& func[1]&~func[0];
    wire inst_sll   = inst_reg&~func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0];
    wire inst_addu  = inst_reg& func[5]&~func[4]&~func[3]&~func[2]&~func[1]& func[0];
    wire inst_sub   = inst_reg& func[5]&~func[4]&~func[3]&~func[2]& func[1]&~func[0];
    wire inst_sltu  = inst_reg& func[5]&~func[4]& func[3]&~func[2]& func[1]& func[0];
    wire inst_multu = inst_reg&~func[5]& func[4]& func[3]&~func[2]&~func[1]& func[0];
    wire inst_nor   = inst_reg& func[5]&~func[4]&~func[3]& func[2]& func[1]& func[0];
    wire inst_or    = inst_reg& func[5]&~func[4]&~func[3]& func[2]&~func[1]& func[0];
    wire inst_xor   = inst_reg& func[5]&~func[4]&~func[3]& func[2]& func[1]&~func[0];
    wire inst_sllv  = inst_reg&~func[5]&~func[4]&~func[3]& func[2]&~func[1]&~func[0];
    wire inst_sra   = inst_reg&~func[5]&~func[4]&~func[3]&~func[2]& func[1]& func[0];
    wire inst_srl   = inst_reg&~func[5]&~func[4]&~func[3]&~func[2]& func[1]&~func[0];
    wire inst_srav  = inst_reg&~func[5]&~func[4]&~func[3]& func[2]& func[1]& func[0];
    wire inst_srlv  = inst_reg&~func[5]&~func[4]&~func[3]& func[2]& func[1]&~func[0]; 
    wire inst_mthi  = inst_reg&~func[5]& func[4]&~func[3]&~func[2]&~func[1]& func[0];
    wire inst_mtlo  = inst_reg&~func[5]& func[4]&~func[3]&~func[2]& func[1]& func[0]; 
    wire inst_jr    = inst_reg&~func[5]&~func[4]& func[3]&~func[2]&~func[1]&~func[0];
    wire inst_jalr  = inst_reg&~func[5]&~func[4]& func[3]&~func[2]&~func[1]& func[0];
    wire inst_div   = inst_reg&~func[5]& func[4]& func[3]&~func[2]& func[1]&~func[0];
    wire inst_divu  = inst_reg&~func[5]& func[4]& func[3]&~func[2]& func[1]& func[0];
    wire inst_break = inst_reg&~func[5]&~func[4]& func[3]& func[2]&~func[1]& func[0];
    wire inst_syscall = inst_reg&~func[5]&~func[4]& func[3]& func[2]&~func[1]&~func[0];
    wire inst_ori   = ~op[5]&~op[4]& op[3]& op[2]&~op[1]& op[0];
    wire inst_lui   = ~op[5]&~op[4]& op[3]& op[2]& op[1]& op[0];
    wire inst_addiu = ~op[5]&~op[4]& op[3]&~op[2]&~op[1]& op[0]; 
    wire inst_sltiu = ~op[5]&~op[4]& op[3]&~op[2]& op[1]& op[0];
    wire inst_lb    =  op[5]&~op[4]&~op[3]&~op[2]&~op[1]&~op[0];
    wire inst_lw    =  op[5]&~op[4]&~op[3]&~op[2]& op[1]& op[0];
    wire inst_sb    =  op[5]&~op[4]& op[3]&~op[2]&~op[1]&~op[0];
    wire inst_sw    =  op[5]&~op[4]& op[3]&~op[2]& op[1]& op[0];
    wire inst_addi  = ~op[5]&~op[4]& op[3]&~op[2]&~op[1]&~op[0];
    wire inst_slti  = ~op[5]&~op[4]& op[3]&~op[2]& op[1]&~op[0]; 
    wire inst_andi  = ~op[5]&~op[4]& op[3]& op[2]&~op[1]&~op[0]; 
    wire inst_xori  = ~op[5]&~op[4]& op[3]& op[2]& op[1]&~op[0]; 
    wire inst_lbu   =  op[5]&~op[4]&~op[3]& op[2]&~op[1]&~op[0];
    wire inst_lh    =  op[5]&~op[4]&~op[3]&~op[2]&~op[1]& op[0];
    wire inst_lhu   =  op[5]&~op[4]&~op[3]& op[2]&~op[1]& op[0];
    wire inst_sh    =  op[5]&~op[4]& op[3]&~op[2]&~op[1]& op[0];
    wire inst_j     = ~op[5]&~op[4]&~op[3]&~op[2]& op[1]&~op[0];
    wire inst_jal   = ~op[5]&~op[4]&~op[3]&~op[2]& op[1]& op[0];
    wire inst_beq   = ~op[5]&~op[4]&~op[3]& op[2]&~op[1]&~op[0];
    wire inst_bne   = ~op[5]&~op[4]&~op[3]& op[2]&~op[1]& op[0];
    wire inst_bgez  = ~op[5]&~op[4]&~op[3]&~op[2]&~op[1]& op[0]&~rt[4]&~rt[3]&~rt[2]&~rt[1]& rt[0];
    wire inst_bgtz  = ~op[5]&~op[4]&~op[3]& op[2]& op[1]& op[0]&~rt[4]&~rt[3]&~rt[2]&~rt[1]&~rt[0];
    wire inst_blez  = ~op[5]&~op[4]&~op[3]& op[2]& op[1]&~op[0]&~rt[4]&~rt[3]&~rt[2]&~rt[1]&~rt[0];
    wire inst_bltz  = ~op[5]&~op[4]&~op[3]&~op[2]&~op[1]& op[0]&~rt[4]&~rt[3]&~rt[2]&~rt[1]&~rt[0];
    wire inst_bgezal= ~op[5]&~op[4]&~op[3]&~op[2]&~op[1]& op[0]& rt[4]&~rt[3]&~rt[2]&~rt[1]& rt[0];
    wire inst_bltzal= ~op[5]&~op[4]&~op[3]&~op[2]&~op[1]& op[0]& rt[4]&~rt[3]&~rt[2]&~rt[1]&~rt[0];
    wire inst_eret  = ~op[5]& op[4]&~op[3]&~op[2]&~op[1]&~op[0]&~func[5]& func[4]& func[3]&~func[2]&~func[1]&~func[0];
    wire inst_mfc0  = ~op[5]& op[4]&~op[3]&~op[2]&~op[1]&~op[0]&~id_inst[23];
    wire inst_mtc0  = ~op[5]& op[4]&~op[3]&~op[2]&~op[1]&~op[0]& id_inst[23];
    /*------------------------------------------------------------------------------*/

    /*-------------------- 第二级译码逻辑：生成具体控制信号 --------------------*/
    // 操作类型alutype
    assign id_alutype_o[2] = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_sll | inst_sllv | inst_sra | inst_srl |
                                                                  inst_srav | inst_srlv | inst_j | inst_jal | 
                                                                  inst_jr | inst_beq | inst_bne | inst_bgez |
                                                                  inst_bgtz | inst_blez | inst_bltz | inst_bgezal |
                                                                  inst_bltzal | inst_jalr | inst_syscall | inst_break |
                                                                  inst_eret | inst_mtc0);
    assign id_alutype_o[1] = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : 
                             (inst_and | inst_mfhi | inst_mflo | inst_ori | inst_lui | inst_andi |
                             inst_nor | inst_or | inst_xor | inst_xori | inst_syscall | inst_break |
                             inst_eret | inst_mtc0 | inst_mfc0);
    assign id_alutype_o[0] = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : 
                             (inst_add | inst_subu | inst_slt | inst_mfhi | inst_mflo |
                              inst_addiu | inst_sltiu | inst_lb | inst_lw | inst_sb | inst_sw |
                              inst_addi | inst_addu | inst_sub | inst_slti | inst_sltu | inst_lbu |
                              inst_lh | inst_lhu | inst_sh | inst_j | inst_jal | inst_jr | inst_beq | 
                              inst_bne | inst_bgez | inst_bgtz | inst_blez | inst_bltz | inst_bgezal |
                              inst_bltzal | inst_jalr | inst_mfc0);

    // 内部操作码aluop
    assign id_aluop_o[7]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_lb | inst_lw | inst_sb | inst_sw | inst_lbu | inst_lh | inst_lhu | inst_sh |
                                                                  inst_syscall | inst_eret | inst_break | inst_mfc0 | inst_mtc0);
    assign id_aluop_o[6]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_bgez | inst_bgtz | inst_blez | inst_bltz | inst_bltzal | inst_bgezal | inst_jalr |
                                                                  inst_div | inst_divu);
    assign id_aluop_o[5]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_slt | inst_sltiu | inst_slti | inst_sltu | inst_or |
                                                                  inst_xor | inst_xori | inst_sra | inst_srl | inst_srav | inst_srlv | inst_j |
                                                                  inst_jr | inst_jal | inst_beq | inst_bne);
    assign id_aluop_o[4]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_and | inst_add | inst_subu | inst_mult | inst_sll |
                                                                  inst_addiu | inst_ori | inst_lb | inst_lw | inst_sb | inst_sw |
                                                                  inst_addi | inst_addu | inst_sub | inst_multu | inst_andi |
                                                                  inst_nor | inst_sllv | inst_lbu | inst_lh | inst_lhu | inst_sh |
                                                                  inst_j | inst_jr | inst_jal | inst_beq | inst_bne | inst_div | inst_divu);
    assign id_aluop_o[3]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_and | inst_add | inst_subu | inst_mfhi | inst_mflo |
                                                                  inst_addiu | inst_ori | inst_sb | inst_sw | inst_addi | inst_slti |
                                                                  inst_sltu | inst_andi | inst_nor | inst_sra | inst_srl | inst_srav | inst_srlv |
                                                                  inst_mthi | inst_mtlo | inst_sh | inst_bne | inst_bltzal | inst_bgezal | inst_jalr |
                                                                  inst_break | inst_mfc0 | inst_mtc0);
    assign id_aluop_o[2]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_and | inst_slt | inst_mult | inst_mfhi | inst_mflo |
                                                                  inst_sltiu | inst_ori | inst_lui | inst_addu | inst_sub | inst_multu |
                                                                  inst_andi | inst_nor | inst_srl | inst_srlv | inst_mthi | inst_mtlo |
                                                                  inst_lh | inst_lhu | inst_beq | inst_bltz | inst_syscall | inst_eret |
                                                                  inst_mfc0 | inst_mtc0);
    assign id_aluop_o[1]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_subu | inst_slt | inst_sltiu | inst_lw | inst_sw | inst_addi |
                                                                  inst_addu | inst_sub | inst_andi | inst_nor | inst_xori | inst_sllv |
                                                                  inst_sra | inst_srav | inst_mthi | inst_mtlo | inst_lhu | inst_jal |
                                                                  inst_blez | inst_jalr | inst_syscall | inst_eret);
    assign id_aluop_o[0]   = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_subu | inst_mflo | inst_sll | inst_addiu | inst_sltiu |
                                                                  inst_ori | inst_lui | inst_addu | inst_sltu | inst_multu |
                                                                  inst_nor | inst_xor | inst_srav | inst_srlv | inst_mtlo | inst_lbu | inst_sh |
                                                                  inst_jr | inst_bgtz | inst_bgezal | inst_divu | inst_eret | inst_mtc0);

    // 写通用寄存器使能信号
    assign id_wreg_o       = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : 
                             (inst_add | inst_subu | inst_slt | inst_and | inst_mfhi | inst_mflo | inst_sll |
                              inst_ori | inst_addiu | inst_lui | inst_sltiu | inst_lb | inst_lw | inst_addi |
                              inst_addu | inst_sub | inst_slti | inst_sltu | inst_andi | inst_nor | inst_or |
                              inst_xor | inst_xori | inst_sllv | inst_sra | inst_srl | inst_srav | inst_srlv |
                              inst_lbu | inst_lh | inst_lhu | inst_jal | inst_jalr | inst_bgezal | inst_bltzal |
                              inst_mfc0);
    
    //写HILO寄存器使能信号                  
    assign id_whilo_o      = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_mult | inst_multu | inst_div | inst_divu);
    
    //分支条件判断使能
    wire bsel = (cpu_rst_n == `RST_ENABLE) ? 1'b0 :
                (inst_beq) ? (id_src1_o == id_src2_o) :
                (inst_bne) ? (id_src1_o != id_src2_o) : 
                (inst_bgez) ? ($signed(id_src1_o) >= 0) :
                (inst_bgtz) ? ($signed(id_src1_o) > 0) :
                (inst_blez) ? ($signed(id_src1_o) <= 0) :
                (inst_bltz) ? ($signed(id_src1_o) < 0) :
                (inst_bgezal) ? ($signed(id_src1_o) >= 0) :
                (inst_bltzal) ? ($signed(id_src1_o) < 0) : 1'b0;
    
    wire shift = inst_sll | inst_sra | inst_srl;
    
    //对立即数进行符号扩展或者零扩展的信号
    wire sext = (inst_addiu | inst_sltiu | inst_lb | inst_lw | inst_sb | inst_sw | inst_addi | inst_slti | 
                 inst_lbu | inst_lh | inst_lhu | inst_sh);
    
    //加载高半字信号
    wire upper = inst_lui;
    
    //确定第二个操作数来源的信号（寄存器or立即数）
    wire immsel = (inst_addiu | inst_sltiu | inst_ori | inst_lui | inst_lb | inst_lw | inst_sb | inst_sw | 
                   inst_addi | inst_slti | inst_andi | inst_xori | inst_lbu | inst_lh | inst_lhu | inst_sh);
    
    //确定目的寄存器是rt还是rd的信号
    wire rtsel = (inst_addiu | inst_sltiu | inst_ori | inst_lui | inst_lb | inst_lw | 
                  inst_addi | inst_slti | inst_andi | inst_xori | inst_lbu | inst_lh | inst_lhu | inst_mfc0);
    
    //子程序调用使能信号
    wire jal = (inst_jal | inst_bgezal | inst_bltzal);
    
    assign id_mreg_o = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : (inst_lb | inst_lw | inst_lbu | inst_lh | inst_lhu);
    // 读通用寄存器堆端口1使能信号
    assign rreg1 = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : 
                             (inst_add | inst_subu | inst_slt | inst_and | inst_mult |
                              inst_addiu | inst_ori | inst_sltiu | inst_lb | inst_lw | inst_sb | inst_sw |
                              inst_addi | inst_addu | inst_sub | inst_slti | inst_sltu | inst_multu |
                              inst_andi | inst_nor | inst_or | inst_xor | inst_xori | inst_sllv |
                              inst_srav | inst_srlv | inst_mthi | inst_mtlo | inst_lbu | inst_lh | inst_lhu | 
                              inst_sh | inst_jr | inst_beq | inst_bne | inst_bgez | inst_bgtz | inst_blez | 
                              inst_bltz | inst_bltzal | inst_bgezal | inst_jalr | inst_div | inst_divu);
    // 读通用寄存器堆读端口2使能信号
    assign rreg2 = (cpu_rst_n == `RST_ENABLE) ? 1'b0 : 
                             (inst_add | inst_subu | inst_slt | inst_and | inst_mult | inst_sll | inst_sb | 
                              inst_sw | inst_addu | inst_sub | inst_sltu | inst_multu | inst_nor | inst_or |
                              inst_xor | inst_sllv | inst_sra | inst_srl | inst_srav | inst_srlv | inst_sh |
                              inst_beq | inst_bne | inst_div | inst_divu | inst_mtc0);
    
    //转移地址选择信号
    assign jtsel[1] = (inst_jr | inst_jalr |(inst_beq & bsel) | (inst_bne & bsel) | (inst_bgez & bsel) |
                       (inst_bgtz & bsel) | (inst_blez & bsel) | (inst_bltz & bsel) | (inst_bgezal & bsel) |
                        (inst_bltzal & bsel));
    assign jtsel[0] = (inst_j | inst_jal | (inst_beq & bsel) | (inst_bne & bsel) | (inst_bgez & bsel) |
                       (inst_bgtz & bsel) | (inst_blez & bsel) | (inst_bltz & bsel) | (inst_bgezal & bsel) |
                        (inst_bltzal & bsel));
    /*------------------------------------------------------------------------------*/
    
    assign id_pc_o          = (cpu_rst_n == `RST_ENABLE) ? `PC_INIT : id_pc_i;
    assign id_in_delay_o    = (cpu_rst_n == `RST_ENABLE) ? `FALSE_V : id_in_delay_i;
    
    // 读通用寄存器堆端口1的地址为rs字段，读端口2的地址为rt字段
    assign ra1   = (cpu_rst_n == `RST_ENABLE) ? 5'b0000_0 : rs;
    assign ra2   = (cpu_rst_n == `RST_ENABLE) ? 5'b0000_0 : rt;
                                            
    // 获得待写入目的寄存器的地址（rt或rd或31号寄存器）
    assign id_wa_o      = (cpu_rst_n == `RST_ENABLE) ? 5'b0000_0 : 
                          (rtsel == `RT_ENABLE) ? rt : 
                          (jal == `TRUE_V) ? 5'b11111 : rd;
     
    
    //只写hi寄存器和lo寄存器的使能
    assign id_whi_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD : inst_mthi;
    assign id_wlo_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD : inst_mtlo;
    
    //定向前推源操作数选择信号
    wire [1:0] fwrd1 = (cpu_rst_n == `RST_ENABLE) ? 2'b00 :
                       (exe2id_wreg == `WRITE_ENABLE && exe2id_wa == ra1 && rreg1 == `READ_ENABLE) ? 2'b01 :
                       (mem2id_wreg == `WRITE_ENABLE && mem2id_wa == ra1 && rreg1 == `READ_ENABLE) ? 2'b10 :
                       (rreg1 == `READ_ENABLE) ? 2'b11 : 2'b00;
    
    wire [1:0] fwrd2 = (cpu_rst_n == `RST_ENABLE) ? 2'b00 :
                       (exe2id_wreg == `WRITE_ENABLE && exe2id_wa == ra2 && rreg2 == `READ_ENABLE) ? 2'b01 :
                       (mem2id_wreg == `WRITE_ENABLE && mem2id_wa == ra2 && rreg2 == `READ_ENABLE) ? 2'b10 :
                       (rreg2 == `READ_ENABLE) ? 2'b11 : 2'b00;                   
     
    //存入数据存储器的数据（可能来自寄存器端口2或者定向前推的数据）                    
    assign id_din_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD : 
                      (fwrd2 == 2'b01) ? exe2id_wd :
                      (fwrd2 == 2'b10) ? mem2id_wd :
                      (fwrd2 == 2'b11) ? rd2 : `ZERO_WORD;          
    
    //获取指令所需的立即数
    wire [`WORD_BUS]    imm_ext = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD :
                                  (upper == `UPPER_ENABLE) ? {imm, {16{1'b0}}} :
                                  (sext == `SIGNED_EXT) ? {{16{imm[15]}}, imm} : {{16{1'b0}}, imm};
    
    // 获得源操作数1。如果shift信号有效，则源操作数1为移位位数；否则为从读通用寄存器堆端口1获得的数据
    assign id_src1_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD : 
                       (shift == `SHIFT_ENABLE) ? {27'b0, sa} :
                       (fwrd1 == 2'b01) ? exe2id_wd :
                       (fwrd1 == 2'b10) ? mem2id_wd :
                       (fwrd1 == 2'b11) ? rd1 : `ZERO_WORD;

    // 获得源操作数2。如果immsel信号有效，则源操作数1为立即数；否则为从读通用寄存器堆端口2获得的数据
    assign id_src2_o = (cpu_rst_n == `RST_ENABLE) ? `ZERO_WORD : 
                       (immsel == `IMM_ENABLE) ? imm_ext :
                       (fwrd2 == 2'b01) ? exe2id_wd :
                       (fwrd2 == 2'b10) ? mem2id_wd :
                       (fwrd2 == 2'b11) ? rd2 : `ZERO_WORD;   
                       
    wire [`INST_ADDR_BUS] pc_plus_8 = pc_plus_4 + 4;
    wire [`JUMP_BUS     ] instr_index = id_inst[25 : 0];   
    wire [`INST_ADDR_BUS] imm_jump = {{14{imm[15]}}, imm, 2'b00};
    
    assign jump_addr_1 = {pc_plus_4[31 : 28], instr_index, 2'b00};  //J, JAL
    assign jump_addr_2 = pc_plus_4 + imm_jump;    //BEQ,BNE           
    assign jump_addr_3 = id_src1_o;     //JR,JALR
    
    assign ret_addr = pc_plus_8;
    
    assign stallreq_id = (cpu_rst_n == `RST_ENABLE) ? `NOSTOP :
                         (((exe2id_wreg == `WRITE_ENABLE && exe2id_wa == ra1 && rreg1 == `READ_ENABLE) || 
                          (exe2id_wreg == `WRITE_ENABLE && exe2id_wa == ra2 && rreg2 == `READ_ENABLE)) && (exe2id_mreg == `TRUE_V)) ? `STOP :
                          (((mem2id_wreg == `WRITE_ENABLE && mem2id_wa == ra1 && rreg1 == `READ_ENABLE) ||
                          (mem2id_wreg == `WRITE_ENABLE && mem2id_wa == ra2 && rreg2 == `READ_ENABLE)) && (mem2id_mreg == `TRUE_V)) ? `STOP : `NOSTOP;
    
    // 判断下一条指令是否是延迟槽指令
    assign next_delay_o = (cpu_rst_n == `RST_ENABLE) ? `FALSE_V :
                            (inst_j | inst_jal | inst_jr | inst_jalr | inst_beq | inst_bne | inst_bgez |
                             inst_bgtz | inst_blez | inst_bltz | inst_bltzal | inst_bgezal);
    
    wire reserved = ~(inst_add | inst_subu | inst_slt | inst_and | inst_mult | inst_mfhi | inst_mflo |
                      inst_sll | inst_addu | inst_sub | inst_sltu | inst_multu | inst_nor | inst_or | inst_xor | 
                      inst_sllv | inst_sra | inst_srl | inst_srav | inst_srlv | inst_mthi | inst_mtlo | inst_jr | 
                      inst_jalr | inst_div | inst_divu | inst_break | inst_syscall | inst_ori | inst_lui | inst_addiu |
                      inst_sltiu | inst_lb | inst_lw | inst_sb | inst_sw | inst_addi | inst_slti | inst_andi | inst_xori |
                      inst_lbu | inst_lh | inst_lhu | inst_sh | inst_j | inst_jal | inst_beq | inst_bne | inst_bgez |
                      inst_bgtz | inst_blez | inst_bltz | inst_bgezal | inst_bltzal | inst_eret | inst_mfc0 | inst_mtc0);
                           
    assign id_exccode_o = (cpu_rst_n == `RST_ENABLE) ? `EXC_NONE :
                          (inst_syscall == `TRUE_V) ? `EXC_SYS :
                          (inst_break == `TRUE_V) ? `EXC_BREAK :
                          (inst_eret == `TRUE_V) ? `EXC_ERET : 
                          (reserved == `TRUE_V) ? `EXC_RI : id_exccode_i; //出现未定义指令
                          
    assign cp0_addr = (cpu_rst_n == `RST_ENABLE) ? `REG_NOP : rd; //cp0寄存器访问地址
   
    
endmodule
