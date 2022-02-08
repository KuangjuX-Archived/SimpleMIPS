`include "defines.v"

module MiniMIPS32(
    input  wire                  cpu_clk_50M,
    input  wire                  cpu_rst_n,
    
    output wire                     inst_req,
    input wire                      inst_addr_ok,
    input wire                      inst_data_ok,
    output wire [`INST_ADDR_BUS]    iaddr, 
    input  wire [`INST_BUS]         inst,

    input wire                      data_addr_ok,
    input wire                      data_data_ok,
    output wire                     data_req,
    output wire                     data_wr,
    output wire [1:0]               data_size,
    input  wire [`WORD_BUS]         dout,
    output wire [`INST_ADDR_BUS]    daddr,
    //din write data
    output wire [`WORD_BUS]         din, 
    
    input  wire [`CP0_INT_BUS  ] int,
    
    output wire [`INST_ADDR_BUS]    debug_wb_pc,
    output wire [0 : 3]             debug_wb_rf_wen,
    output wire [`REG_ADDR_BUS  ]   debug_wb_rf_wnum,
    output wire [`REG_BUS       ]   debug_wb_rf_wdata
    );
    
    //连接取指模块和取值/译码模块的变量
    wire [`WORD_BUS      ] pc;
    wire [`WORD_BUS      ] pc_plus_4;
    wire [`EXC_CODE_BUS  ] if_exccode_o;

    // 连接IF/ID模块与译码阶段ID模块的变量 
    wire [`WORD_BUS      ] id_pc_i;
    wire [`WORD_BUS      ] pc_plus_4_i;
    wire [`EXC_CODE_BUS  ] id_exccode_i;
    
    //连接暂停控制模块和相关模块的变量
    wire [`STALL_BUS     ] stall;
    
    //连接译码模块和暂停控制模块的变量
    wire                    stallreq_id;
    
    //连接执行模块和暂停控制模块的变量
    wire                    stallreq_exe;
    
    //连接译码模块和取指模块的变量
    wire [`WORD_BUS      ] jump_addr_1;
    wire [`WORD_BUS      ] jump_addr_2;
    wire [`WORD_BUS      ] jump_addr_3;
    wire [`JTSEL_BUS     ] jtsel;
    
    // 连接译码阶段ID模块与通用寄存器Regfile模块的变量 
    wire 				   re1;
    wire [`REG_ADDR_BUS  ] ra1;
    wire [`REG_BUS       ] rd1;
    wire 				   re2;
    wire [`REG_ADDR_BUS  ] ra2;
    wire [`REG_BUS       ] rd2;
    
    //连接译码阶段与译码/执行寄存器的信号
    wire [`ALUOP_BUS     ] id_aluop_o;
    wire [`ALUTYPE_BUS   ] id_alutype_o;
    wire [`REG_BUS 	     ] id_src1_o;
    wire [`REG_BUS 	     ] id_src2_o;
    wire 				   id_wreg_o;
    wire [`REG_ADDR_BUS  ] id_wa_o;
    wire                   id_whilo_o;
    wire                   id_mreg_o;
    wire [`REG_BUS       ] id_din_o;
    wire                   id_whi_o;
    wire                   id_wlo_o;
    wire [`REG_BUS       ] id_ret_addr_o; 
    wire [`EXC_CODE_BUS ]  id_exccode_o;
    wire                   nexe_delay_o_i;
    wire [`INST_ADDR_BUS]  id_pc_o;
    wire [`REG_ADDR_BUS ]  cp0_addr;
    wire                   id_in_delay_o;
    
    //连接译码/执行模块与译码模块
    wire                   next_delay_o;
    
    //连接译码/执行与执行阶段的信号
    wire [`ALUOP_BUS     ] exe_aluop_i;
    wire [`ALUTYPE_BUS   ] exe_alutype_i;
    wire [`REG_BUS 	     ] exe_src1_i;
    wire [`REG_BUS 	     ] exe_src2_i;
    wire 				   exe_wreg_i;
    wire [`REG_ADDR_BUS  ] exe_wa_i;
    wire                   exe_whilo_i;
    wire                   exe_mreg_i;
    wire [`REG_BUS       ] exe_din_i;
    wire                   exe_whi_i;
    wire                   exe_wlo_i;
    wire [`REG_BUS       ] exe_ret_addr_i;
    wire [`EXC_CODE_BUS ]  exe_exccode_i;
    wire [`INST_ADDR_BUS]  exe_pc_i;
    wire [`REG_ADDR_BUS ]  exe_cp0_addr_i;
    wire                   exe_in_delay;

    //连接执行阶段与HILO寄存器的信号
    wire [`REG_BUS 	     ] exe_hi_i;
    wire [`REG_BUS 	     ] exe_lo_i;
    
    //连接执行阶段与执行/访存寄存器的信号
    wire [`ALUOP_BUS     ] exe_aluop_o;
    wire 				   exe_wreg_o;
    wire [`REG_ADDR_BUS  ] exe_wa_o;
    wire [`REG_BUS 	     ] exe_wd_o;
    wire                   exe_whilo_o;
    wire [`DOUBLE_REG_BUS] exe_hilo_o;
    wire                   exe_mreg_o;
    wire [`REG_BUS       ] exe_din_o;
    wire                   exe_whi_o;
    wire                   exe_wlo_o;
    wire [`EXC_CODE_BUS  ] exe_exccode_o;
    wire [`INST_ADDR_BUS ] exe_pc_o;
    wire                   exe_in_delay_o;
    wire                   cp0_we_o;
    wire [`REG_ADDR_BUS  ] cp0_waddr_o;
    wire [`REG_BUS       ] cp0_wdata_o;
    wire                   cp0_re_o;
	wire [`REG_ADDR_BUS  ] cp0_raddr_o;
    
    //连接执行/访存寄存器与访存阶段的信号
    wire [`ALUOP_BUS     ] mem_aluop_i;
    wire 				   mem_wreg_i;
    wire [`REG_ADDR_BUS  ] mem_wa_i;
    wire [`REG_BUS 	     ] mem_wd_i;
    wire                   mem_whilo_i;
    wire [`DOUBLE_REG_BUS] mem_hilo_i;
    wire                   mem_mreg_i;
    wire [`REG_BUS       ] mem_din_i;
    wire                   mem_whi_i;
    wire                   mem_wlo_i;
    wire [`INST_ADDR_BUS ] mem_pc_i;
    wire                   mem_in_delay_i;
    wire [`EXC_CODE_BUS  ] mem_exccode_i;
    wire                   cp0_we_i;
    wire [`REG_ADDR_BUS]   cp0_waddr_i;
    wire [`REG_BUS       ] cp0_wdata_i;

    //连接访存阶段与访存/写回寄存器的信号
    wire 				   mem_wreg_o;
    wire [`REG_ADDR_BUS  ] mem_wa_o;
    wire [`REG_BUS 	     ] mem_dreg_o;
    wire                   mem_whilo_o;
    wire [`DOUBLE_REG_BUS] mem_hilo_o;
    wire                   mem_mreg_o;
    wire [`BSEL_BUS      ] mem_dre_o;
    wire                   mem_whi_o;
    wire                   mem_wlo_o;
    wire                   mem_msext_o;  //从存储器中取出的数据进行符号扩展or0扩展
    wire                   mem_cp0_we_o;
	wire [`REG_ADDR_BUS  ] mem_cp0_waddr_o;
	wire [`REG_BUS       ] mem_cp0_wdata_o;
    
    //连接访存/写回寄存器与写回阶段的信号
    wire 				   wb_wreg_i;
    wire [`REG_ADDR_BUS  ] wb_wa_i;
    wire [`REG_BUS       ] wb_dreg_i;
    wire                   wb_whilo_i;
    wire [`DOUBLE_REG_BUS] wb_hilo_i;
    wire                   wb_mreg_i;
    wire [`BSEL_BUS      ] wb_dre_i;
    wire                   wb_whi_i;
    wire                   wb_wlo_i;
    wire                   wb_msext_i;
    wire                   wb_cp0_we_i;
    wire [`REG_ADDR_BUS  ] wb_cp0_waddr_i;
    wire [`REG_BUS       ] wb_cp0_wdata_i;
    wire [`INST_ADDR_BUS ] wb_pc_i;
    
    //连接写回阶段与通用寄存器的信号
    wire 				   wb_wreg_o;
    wire [`REG_ADDR_BUS  ] wb_wa_o;
    wire [`REG_BUS       ] wb_wd_o;
    
    //连接写回阶段与HILO寄存器的信号
    wire                   wb_whilo_o;
    wire                   wb_whi_o;
    wire                   wb_wlo_o;
    wire [`DOUBLE_REG_BUS] wb_hilo_o; 
    
    wire                   flush;
    wire                   flush_im;
    
    //连接cp0和取指阶段
    wire [`INST_ADDR_BUS]  cp0_excaddr;
    
    //连接写回和cp0寄存器
    wire                   wb_cp0_we_o;
	wire [`REG_ADDR_BUS  ] wb_cp0_waddr_o;
	wire [`REG_BUS       ] wb_cp0_wdata_o;
	
	//连接访存和cp0寄存器
	wire [`INST_ADDR_BUS ]       mem_cp0_pc_o;
	wire                         mem_cp0_in_delay_o;
	wire [`EXC_CODE_BUS  ]       mem_cp0_exccode_o;
	wire [`INST_ADDR_BUS ]       addr_misalign;
	
	//连接cp0和执行模块
	wire	[`REG_BUS      ]     data_o;
	
	//连接cp0和访存模块
	wire [`REG_BUS 	   ]  status_o;
	wire [`REG_BUS 	   ]  cause_o;
	
	//最终在写回阶段输出的pc
	wire [`INST_ADDR_BUS ] wb_pc_o;
    
    wire                    mem_mem_flag;
    wire                    mem_stop_wb;
    
    wire    ifid_inst_data_ok; 
    wire    idexe_inst_data_ok;
    wire    exemem_inst_data_ok; 
    wire    memcp0_inst_data_ok;
    //取指
    if_stage if_stage0(.cpu_clk_50M(cpu_clk_50M), .cpu_rst_n(cpu_rst_n),
        .jump_addr_1(jump_addr_1), .jump_addr_2(jump_addr_2), .jump_addr_3(jump_addr_3), .jtsel(jtsel),
        .stall(stall), .flush(flush), .cp0_excaddr(cp0_excaddr),
        .inst_addr_ok(inst_addr_ok), .inst_data_ok(inst_data_ok), .mem_mem_flag(mem_mem_flag),
        .pc_o(pc), .iaddr(iaddr), .pc_plus_4(pc_plus_4),
        .if_exccode_o(if_exccode_o), .inst_req(inst_req), .inst_data_ok_o(ifid_inst_data_ok)
        );

    //取指/译码
    ifid_reg ifid_reg0(.cpu_clk_50M(cpu_clk_50M), .cpu_rst_n(cpu_rst_n),    
        .if_pc(pc), .if_pc_plus_4(pc_plus_4),
        .stall(stall), .flush(flush), .if_exccode(if_exccode_o),
        .id_pc(id_pc_i), .id_pc_plus_4(pc_plus_4_i), .id_exccode(id_exccode_i),
        .if_inst_data_ok(ifid_inst_data_ok), .id_inst_data_ok(idexe_inst_data_ok)
    );
    
    
    //译码
    id_stage id_stage0(
        .cpu_rst_n(cpu_rst_n),
        .id_pc_i(id_pc_i), 
        .id_inst_i(inst),
        .rd1(rd1), .rd2(rd2),
        .exe2id_wreg(exe_wreg_o), .exe2id_wa(exe_wa_o), .exe2id_wd(exe_wd_o),
        .mem2id_wreg(mem_wreg_o), .mem2id_wa(mem_wa_o), .mem2id_wd(mem_dreg_o),
        .exe2id_mreg(exe_mreg_o), .mem2id_mreg(mem_mreg_o),
        .pc_plus_4(pc_plus_4_i), .id_in_delay_i(next_delay_o), .flush_im(flush_im),
        .mem_mem_flag(mem_mem_flag),
        .id_exccode_i(id_exccode_i),
        .rreg1(re1), .rreg2(re2), 	  
        .ra1(ra1), .ra2(ra2), 
        .id_aluop_o(id_aluop_o), .id_alutype_o(id_alutype_o),
        .id_src1_o(id_src1_o), .id_src2_o(id_src2_o),
        .id_wa_o(id_wa_o), .id_wreg_o(id_wreg_o),
        .id_whilo_o(id_whilo_o),
        .id_mreg_o(id_mreg_o), .id_din_o(id_din_o),
        .id_whi_o(id_whi_o), .id_wlo_o(id_wlo_o),
        .jump_addr_1(jump_addr_1), .jump_addr_2(jump_addr_2), .jump_addr_3(jump_addr_3), 
        .jtsel(jtsel), .ret_addr(id_ret_addr_o),
        .stallreq_id(stallreq_id), .id_exccode_o(id_exccode_o), .id_pc_o(id_pc_o),
        .next_delay_o(next_delay_o_i), .cp0_addr(cp0_addr), .id_in_delay_o(id_in_delay_o)
    );
    
    //通用寄存器
    regfile regfile0(.cpu_clk_50M(cpu_clk_50M), .cpu_rst_n(cpu_rst_n),
        .we(wb_wreg_o), .wa(wb_wa_o), .wd(wb_wd_o),
        .re1(re1), .ra1(ra1), .rd1(rd1),
        .re2(re2), .ra2(ra2), .rd2(rd2)
    );
    
    //译码/执行
    idexe_reg idexe_reg0(.cpu_clk_50M(cpu_clk_50M), .cpu_rst_n(cpu_rst_n), 
        .id_alutype(id_alutype_o), .id_aluop(id_aluop_o),
        .id_src1(id_src1_o), .id_src2(id_src2_o),
        .id_wa(id_wa_o), .id_wreg(id_wreg_o), .id_whilo(id_whilo_o),
        .id_mreg(id_mreg_o), .id_din(id_din_o),
        .id_whi(id_whi_o), .id_wlo(id_wlo_o),
        .id_ret_addr(id_ret_addr_o), .stall(stall),
        .id_exccode(id_exccode_o), .id_pc(id_pc_o),
        .next_delay_i(next_delay_o_i), .id_cp0_addr(cp0_addr), 
        .id_in_delay(id_in_delay_o), .flush(flush),
        .exe_alutype(exe_alutype_i), .exe_aluop(exe_aluop_i),
        .exe_src1(exe_src1_i), .exe_src2(exe_src2_i), 
        .exe_wa(exe_wa_i), .exe_wreg(exe_wreg_i), .exe_whilo(exe_whilo_i),
        .exe_mreg(exe_mreg_i), .exe_din(exe_din_i),
        .exe_whi(exe_whi_i), .exe_wlo(exe_wlo_i),
        .exe_ret_addr(exe_ret_addr_i),
        .exe_exccode(exe_exccode_i), .exe_pc(exe_pc_i), 
        .next_delay_o(next_delay_o), .exe_cp0_addr(exe_cp0_addr_i), .exe_in_delay(exe_in_delay_i),
        .id_inst_data_ok(idexe_inst_data_ok), .exe_inst_data_ok(exemem_inst_data_ok)
    );
    
    //执行
    exe_stage exe_stage0(
        .cpu_rst_n(cpu_rst_n), .cpu_clk_50M(cpu_clk_50M),
        .exe_alutype_i(exe_alutype_i), .exe_aluop_i(exe_aluop_i),
        .exe_src1_i(exe_src1_i), .exe_src2_i(exe_src2_i),
        .exe_wa_i(exe_wa_i), .exe_wreg_i(exe_wreg_i), .exe_whilo_i(exe_whilo_i),
        .exe_mreg_i(exe_mreg_i), .exe_din_i(exe_din_i),
        .hi_i(exe_hi_i), .lo_i(exe_lo_i),
        .mem2exe_whilo(mem_whilo_o), .mem2exe_hilo(mem_hilo_o),
        .wb2exe_whilo(wb_whilo_o), .wb2exe_hilo(wb_hilo_o),
        .exe_whi_i(exe_whi_i), .exe_wlo_i(exe_wlo_i),
        .mem2exe_cp0_we(mem_cp0_we_o), .mem2exe_cp0_wa(mem_cp0_waddr_o), .mem2exe_cp0_wd(mem_cp0_wdata_o),
        .wb2exe_cp0_we(wb_cp0_we_o), .wb2exe_cp0_wa(wb_cp0_waddr_o), .wb2exe_cp0_wd(wb_cp0_wdata_o),
        .exe_exccode_i(exe_exccode_i), .exe_pc_i(exe_pc_i), .cp0_data_i(data_o),
        .cp0_addr_i(exe_cp0_addr_i), .exe_in_delay_i(exe_in_delay_i),
        .ret_addr(exe_ret_addr_i),
        .mem2exe_whi(mem_whi_o), .wb2exe_whi(wb_whi_o), .mem2exe_wlo(mem_wlo_o), .wb2exe_wlo(wb_wlo_o),
        .exe_aluop_o(exe_aluop_o), 
        .exe_wa_o(exe_wa_o), .exe_wreg_o(exe_wreg_o), .exe_wd_o(exe_wd_o),
        .exe_whilo_o(exe_whilo_o), .exe_hilo_o(exe_hilo_o),
        .exe_mreg_o(exe_mreg_o), .exe_din_o(exe_din_o),
        .exe_whi_o(exe_whi_o), .exe_wlo_o(exe_wlo_o),
        .stallreq_exe(stallreq_exe), .exe_exccode_o(exe_exccode_o), .exe_pc_o(exe_pc_o),
        .exe_in_delay_o(exe_in_delay_o), .cp0_re_o(cp0_re_o), .cp0_raddr_o(cp0_raddr_o),
        .cp0_we_o(cp0_we_o), .cp0_waddr_o(cp0_waddr_o), .cp0_wdata_o(cp0_wdata_o)
    );
    
    //执行/访存    
    exemem_reg exemem_reg0(.cpu_clk_50M(cpu_clk_50M), .cpu_rst_n(cpu_rst_n),
        .exe_aluop(exe_aluop_o),
        .exe_wa(exe_wa_o), .exe_wreg(exe_wreg_o), .exe_wd(exe_wd_o),
        .exe_whilo(exe_whilo_o), .exe_hilo(exe_hilo_o),
        .exe_mreg(exe_mreg_o), .exe_din(exe_din_o),
        .exe_whi(exe_whi_o), .exe_wlo(exe_wlo_o),
        .stall(stall), .flush(flush), .exe_exccode(exe_exccode_o), .exe_pc(exe_pc_o),
        .exe_in_delay(exe_in_delay_o), .exe_cp0_we(cp0_we_o), .exe_cp0_waddr(cp0_waddr_o), .exe_cp0_wdata(cp0_wdata_o),
        .mem_aluop(mem_aluop_i),
        .mem_wa(mem_wa_i), .mem_wreg(mem_wreg_i), .mem_wd(mem_wd_i),
        .mem_whilo(mem_whilo_i), .mem_hilo(mem_hilo_i),
        .mem_mreg(mem_mreg_i), .mem_din(mem_din_i),
        .mem_whi(mem_whi_i), .mem_wlo(mem_wlo_i),
        .mem_exccode(mem_exccode_i), .mem_pc(mem_pc_i), .mem_in_delay(mem_in_delay_i),
        .mem_cp0_we(cp0_we_i), .mem_cp0_waddr(cp0_waddr_i), .mem_cp0_wdata(cp0_wdata_i),
        .exe_inst_data_ok(exemem_inst_data_ok), .mem_inst_data_ok(memcp0_inst_data_ok)
    );
    wire [31:0]mem_daddr;
    //访存
    mem_stage mem_stage0(
        .cpu_clk_50M(cpu_clk_50M),
        .cpu_rst_n(cpu_rst_n),
        .mem_aluop_i(mem_aluop_i),
        .mem_wa_i(mem_wa_i), .mem_wreg_i(mem_wreg_i), .mem_wd_i(mem_wd_i),
        .mem_whilo_i(mem_whilo_i), .mem_hilo_i(mem_hilo_i),
        .mem_mreg_i(mem_mreg_i), .mem_din_i(mem_din_i),
        .mem_whi_i(mem_whi_i), .mem_wlo_i(mem_wlo_i),
        .mem_exccode_i(mem_exccode_i), .mem_pc_i(mem_pc_i), .mem_in_delay_i(mem_in_delay_i),
        .cp0_we_i(cp0_we_i), .cp0_waddr_i(cp0_waddr_i), .cp0_wdata_i(cp0_wdata_i),
        .wb2mem_cp0_we(wb_cp0_we_o), .wb2mem_cp0_wa(wb_cp0_waddr_o), .wb2mem_cp0_wd(wb_cp0_wdata_o),
        .cp0_status(status_o), .cp0_cause(cause_o),
        .mem_wa_o(mem_wa_o), .mem_wreg_o(mem_wreg_o), .mem_dreg_o(mem_dreg_o),
        .mem_whilo_o(mem_whilo_o), .mem_hilo_o(mem_hilo_o),
        .mem_mreg_o(mem_mreg_o), .dre(mem_dre_o),
        .data_addr_ok       (data_addr_ok   ),
        .data_data_ok       (data_data_ok   ),
        .data_req           (data_req       ),
        .data_wr            (data_wr        ),
        .data_size          (data_size      ),
        .daddr              (mem_daddr      ),
        .din                (din            ),
        .mem_mem_flag       (mem_mem_flag   ),
        .mem_stop_wb        (mem_stop_wb    ),
        .mem_whi_o(mem_whi_o), .mem_wlo_o(mem_wlo_o),
        .mem_msext_o(mem_msext_o),
        .cp0_exccode(mem_cp0_exccode_o), .cp0_pc(mem_cp0_pc_o), .cp0_in_delay(mem_cp0_in_delay_o),
        .cp0_we_o(mem_cp0_we_o), .cp0_waddr_o(mem_cp0_waddr_o), .cp0_wdata_o(mem_cp0_wdata_o),
        .cp0_addr_disalign(addr_misalign)
    );
    assign daddr = mem_daddr;
    wire [31:0]mem2wb_rdata;
    //访存/写回
    memwb_reg memwb_reg0(.cpu_clk_50M(cpu_clk_50M), .cpu_rst_n(cpu_rst_n),
        .mem_wa(mem_wa_o), .mem_wreg(mem_wreg_o), .mem_dreg(mem_dreg_o),
        .mem_whilo(mem_whilo_o), .mem_hilo(mem_hilo_o),
        .mem_mreg(mem_mreg_o), .mem_dre(mem_dre_o),
        .mem_whi(mem_whi_o), .mem_wlo(mem_wlo_o),
        .mem_msext(mem_msext_o),
        .mem_cp0_we(mem_cp0_we_o), .mem_cp0_waddr(mem_cp0_waddr_o), .mem_cp0_wdata(mem_cp0_wdata_o),
        .flush(flush), .mem_pc(mem_cp0_pc_o),
        .mem_rdata(dout), .mem_stop_wb(mem_stop_wb),
        .wb_wa(wb_wa_i), .wb_wreg(wb_wreg_i), .wb_dreg(wb_dreg_i),
        .wb_whilo(wb_whilo_i), .wb_hilo(wb_hilo_i),
        .wb_mreg(wb_mreg_i), .wb_dre(wb_dre_i),
        .wb_whi(wb_whi_i), .wb_wlo(wb_wlo_i),
        .wb_msext(wb_msext_i), .wb_cp0_we(wb_cp0_we_i), .wb_cp0_waddr(wb_cp0_waddr_i),
        .wb_cp0_wdata(wb_cp0_wdata_i), .wb_pc(wb_pc_i),
        .wb_rdata(mem2wb_rdata)
    );
    
    //写回
    wb_stage wb_stage0(
        .cpu_rst_n(cpu_rst_n),
        .wb_wa_i(wb_wa_i), .wb_wreg_i(wb_wreg_i), .wb_dreg_i(wb_dreg_i), 
        .wb_whilo_i(wb_whilo_i), .wb_hilo_i(wb_hilo_i),
        .wb_mreg_i(wb_mreg_i), .wb_dre_i(wb_dre_i),
        .wb_whi_i(wb_whi_i), .wb_wlo_i(wb_wlo_i),
        .wb_msext_i(wb_msext_i),
        .cp0_we_i(wb_cp0_we_i), .cp0_waddr_i(wb_cp0_waddr_i), .cp0_wdata_i(wb_cp0_wdata_i),
        .wb_pc_i(wb_pc_i),
        .dm(mem2wb_rdata),
        .wb_wa_o(wb_wa_o), .wb_wreg_o(wb_wreg_o), .wb_wd_o(wb_wd_o),
        .wb_whilo_o(wb_whilo_o), .wb_hilo_o(wb_hilo_o),
        .wb_whi_o(wb_whi_o), .wb_wlo_o(wb_wlo_o), 
        .cp0_we_o(wb_cp0_we_o), .cp0_waddr_o(wb_cp0_waddr_o), .cp0_wdata_o(wb_cp0_wdata_o),
        .wb_pc_o(wb_pc_o)
    );
    
    assign debug_wb_pc = wb_pc_o;
    assign debug_wb_rf_wen = {wb_wreg_o, wb_wreg_o, wb_wreg_o, wb_wreg_o};
    assign debug_wb_rf_wnum = wb_wa_o;
    assign debug_wb_rf_wdata = wb_wd_o;
    
    hilo hilo0(
        .cpu_clk_50M(cpu_clk_50M), .cpu_rst_n(cpu_rst_n),
        .we(wb_whilo_o), .we_hi(wb_whi_o), .we_lo(wb_wlo_o),
        .hi_i(wb_hilo_o[63 : 32]), .lo_i(wb_hilo_o[31 : 0]),
        .hi_o(exe_hi_i), .lo_o(exe_lo_i)
    );
    
    scu scu0(
        .cpu_rst_n(cpu_rst_n),
        .stallreq_id(stallreq_id), 
        .stallreq_exe(stallreq_exe),
        .stall(stall)
    );
    
    cp0_reg cp0_reg0(
        .cpu_clk_50M(cpu_clk_50M), .cpu_rst_n(cpu_rst_n),
        .exccode_i(mem_cp0_exccode_o), .pc_i(mem_cp0_pc_o), .in_delay_i(mem_cp0_in_delay_o),
        .re(cp0_re_o), .raddr(cp0_raddr_o), .misalign_addr(addr_misalign),
        .inst_data_ok(memcp0_inst_data_ok),
        .we(wb_cp0_we_o), .waddr(wb_cp0_waddr_o), .wdata(wb_cp0_wdata_o),
        .int_i( int), 
        .flush(flush), .flush_im(flush_im), .cp0_excaddr(cp0_excaddr),
        .data_o(data_o), .status_o(status_o), .cause_o(cause_o) 
    );
    

    

    
endmodule
