`include "defines.v"

module MiniMIPS32(
    input  wire                  cpu_clk_50M,
    input  wire                  cpu_rst_n,
    input  wire [5:0]            int,
    output wire                  timer_int_o,
    

    output wire[3:0]   arid_o, // 读地址ID
    output wire[31:0]  araddr_o, // 读地址
    output wire[3:0]   arlen_o, // Burst length
    output wire[2:0]   arsize_o, // Burst size
    output wire[1:0]   arburst_o, // Burst type
    output wire[1:0]   arlock_o, // Lock type
    output wire[3:0]   arcache_o, // Memory type
    output wire[2:0]   arprot_o, // Protection type
    output wire        arvalid_o, // Read address valid
    input  wire        arready_i, // Read address ready

    input  wire[3:0]   rid_i, // Read ID tag
    input  wire[31:0]  rdata_i, // Read data
    input  wire[1:0]   rresp_i, // Read response
    input  wire        rlast_i, // Read last
    input  wire        rvalid_i, // Read valid
    output wire        rready_o, // Read ready

    output wire[3:0]   awid_o, // Write address ID
    output wire[31:0]  awaddr_o, // Write address
    output wire[3:0]   awlen_o, // Burst length
    output wire[2:0]   awsize_o, // Burst size
    output wire[1:0]   awburst_o, // Burst type
    output wire[1:0]   awlock_o, // Lock type
    output wire[3:0]   awcache_o, // Memory type
    output wire[2:0]   awprot_o, // Protection type
    output wire        awvalid_o, // Write address valid
    input  wire        awready_i, // Write address ready

    output wire[3:0]   wid_o, // Write ID tag
    output wire[31:0]  wdata_o, // Write data
    output wire[3:0]   wstrb_o, // Write strobes. This signal indicates which byte lanes hold valid data. 
    output wire        wlast_o, // Write last. This signal indicates the last transfer in a write burst. 
    output wire        wvalid_o, // Write valid
    input  wire        wready_i, // Write ready

    input  wire[3:0]   bid_i, // Reasponse ID tag
    input  wire[1:0]   bresp_i, // Write response. This signal indicates the status of the write transaction. 
    input  wire        bvalid_i, // Write response valid
    output wire        bready_o, // Response ready

    output  wire [31: 0] debug_wb_pc,
    output  wire [3 :0]  debug_wb_rf_wen,
    output  wire [4 :0]  debug_wb_rf_wnum,
    output  wire [31:0]  debug_wb_rf_wdata

    );

    wire [`WORD_BUS      ] pc;

    // 连接IF/ID模块与译码阶段ID模块的变量 
    wire [`WORD_BUS      ] id_pc_i;
    
    // 连接译码阶段ID模块与通用寄存器Regfile模块的变量 
    wire 				   re1;
    wire [`REG_ADDR_BUS  ] ra1;
    wire [`REG_BUS       ] rd1;
    wire 				   re2;
    wire [`REG_ADDR_BUS  ] ra2;
    wire [`REG_BUS       ] rd2;
    
    wire [ 1: 0         ]  jtsel;
    wire [`REG_BUS      ]  addr1;
    wire [`REG_BUS      ]  addr2;
    wire [`REG_BUS      ]  addr3;
    
    wire                      exe2id_wreg;
    wire [`REG_ADDR_BUS  ]    exe2id_wa;
    wire [`REG_BUS       ]    exe2id_wd;
    wire                      mem2id_wreg;
    wire [`REG_ADDR_BUS  ]    mem2id_wa;
    wire [`REG_BUS       ]    mem2id_wd;
    
    wire                     mem2exe_whilo;
    wire [`DOUBLE_REG_BUS]   mem2exe_hilo;
    wire                     wb2exe_whilo;
    wire [`DOUBLE_REG_BUS]   wb2exe_hilo;
    
    wire [`ALUOP_BUS     ] id_aluop_o;
    wire [`ALUTYPE_BUS   ] id_alutype_o;
    wire [`REG_BUS 	     ] id_src1_o;
    wire [`REG_BUS 	     ] id_src2_o;
    wire [`DATA_BUS      ] id_din_o;
    wire 				   id_wreg_o;
    wire                   id_whilo_o;
    wire                   id_mreg_o;
    wire [`REG_ADDR_BUS  ] id_wa_o;
    wire [`REG_BUS       ] id_retaddr_o;
    wire [`REG_ADDR_BUS  ] id_cp0_addr_o;
    wire [`INST_ADDR_BUS ] id_pc_o;
    wire                   id_in_delay_o;
    wire                   next_delay_i;
    wire [`EXC_CODE_BUS  ] id_exccode_o;
    wire [`ALUOP_BUS     ] exe_aluop_i;
    wire [`ALUTYPE_BUS   ] exe_alutype_i;
    wire [`REG_BUS 	     ] exe_src1_i;
    wire [`REG_BUS 	     ] exe_src2_i;
    wire [`DATA_BUS      ] exe_din_i;
    wire 				   exe_wreg_i;
    wire                   exe_whilo_i;
    wire                   exe_mreg_i;
    wire [`REG_ADDR_BUS  ] exe_wa_i;
    wire [`REG_BUS       ] exe_retaddr_i;
    wire [`REG_BUS       ] exe_hi_i;
    wire [`REG_BUS       ] exe_lo_i;
    wire [`REG_ADDR_BUS  ] exe_cp0_addr_i;
    wire [`INST_ADDR_BUS ] exe_pc_i;
    wire                   exe_in_delay_i;
    wire                   next_delay_o;
    wire [`EXC_CODE_BUS  ] exe_exccode_i;
    
    wire [`ALUOP_BUS     ] exe_aluop_o;
    wire 				   exe_wreg_o;
    wire 				   exe_whilo_o;
    wire                   exe_mreg_o;
    wire [`REG_ADDR_BUS  ] exe_wa_o;
    wire [`REG_BUS 	     ] exe_wd_o;
    wire [`DATA_BUS      ] exe_din_o;
    wire [`DOUBLE_REG_BUS] exe_hilo_o;
    wire                   exe_cp0_we_o;
    wire [`REG_ADDR_BUS  ] exe_cp0_waddr_o;
    wire [`REG_BUS       ] exe_cp0_wdata_o;
    wire [`INST_ADDR_BUS ] exe_pc_o;
    wire                   exe_in_delay_o;
    wire [`EXC_CODE_BUS  ] exe_exccode_o;
    wire [`ALUOP_BUS     ] mem_aluop_i;
    wire 				   mem_wreg_i;
    wire 				   mem_whilo_i;
    wire                   mem_mreg_i;
    wire [`REG_ADDR_BUS  ] mem_wa_i;
    wire [`REG_BUS 	     ] mem_wd_i;
    wire [`DATA_BUS      ] mem_din_i;
    wire [`DOUBLE_REG_BUS] mem_hilo_i;
    wire                   mem_cp0_we_i;
    wire [`REG_ADDR_BUS  ] mem_cp0_waddr_i;
    wire [`REG_BUS       ] mem_cp0_wdata_i;
    wire [`INST_ADDR_BUS ] mem_pc_i;
    wire                   mem_in_delay_i;
    wire [`EXC_CODE_BUS  ] mem_exccode_i;

    wire 				   mem_wreg_o;
    wire 				   mem_whilo_o;
    wire                   mem_mreg_o;
    wire [`ALUOP_BUS     ] mem_aluop_o;
    wire [`REG_ADDR_BUS  ] mem_wa_o;
    wire [`REG_BUS 	     ] mem_dreg_o;
    wire [`DOUBLE_REG_BUS] mem_dhilo_o;
    wire [`DATA_WE_BUS   ] mem_dre_o;
    wire                   mem_cp0_we_o;
    wire [`REG_ADDR_BUS  ] mem_cp0_waddr_o;
    wire [`REG_BUS       ] mem_cp0_wdata_o;
    wire [`INST_ADDR_BUS ] mem_pc_o;

    wire 				   wb_wreg_i;
    wire 				   wb_whilo_i;
    wire                   wb_mreg_i;
    wire [`ALUOP_BUS     ] wb_aluop_i;
    wire [`REG_ADDR_BUS  ] wb_wa_i;
    wire [`REG_BUS       ] wb_dreg_i;
    wire [`DOUBLE_REG_BUS] wb_dhilo_i;
    wire [`DATA_WE_BUS   ] wb_dre_i;
    wire                   wb_cp0_we_i;
    wire [`REG_ADDR_BUS  ] wb_cp0_waddr_i;
    wire [`REG_BUS       ] wb_cp0_wdata_i;
    wire [`INST_ADDR_BUS ] wb_pc_i;

    wire 				   wb_wreg_o;
    wire 				   wb_whilo_o;
    wire [`REG_ADDR_BUS  ] wb_wa_o;
    wire [`REG_BUS       ] wb_wd_o;
    wire [`REG_BUS       ] wb_ds;
    wire [`REG_BUS       ] wb_dlo_o;
    wire [`INST_ADDR_BUS ] wb_pc_o;
    
    wire [`STALL_BUS     ] stall;
    wire                   exe2id_mreg;
    wire                   mem2id_mreg;
    wire                   stallreq_id;
    wire                   stallreq_exec;                         
    wire 				   cp0_we;
    wire 				   cp0_re;
    wire [`REG_ADDR_BUS   ] raddr;
    wire [`REG_ADDR_BUS   ] waddr;
    wire [`REG_BUS        ] wdata;
    wire [`CP0_INT_BUS    ] int_i;
        
    wire [`INST_ADDR_BUS  ] pc_i;
    wire                    in_delay_i;
    wire [`EXC_CODE_BUS   ] exccode_i;
    wire [`REG_BUS        ] badvaddr_i;
         
    wire                    flush;
    wire                    flush_im;
    wire [`INST_ADDR_BUS  ] cp0_excaddr;
    
    wire [`REG_BUS        ] data_o;
    wire [`REG_BUS        ] status_o;
    wire [`REG_BUS        ] cause_o;

    wire                    mem_device;
    wire                    wb_device;

    // 类sram接口定义
    // inst sram-like
    wire                    inst_req;
    wire                    inst_wr;
    wire [1:0]              inst_size;
    wire [31:0]             inst_addr;
    wire [31:0]             inst_wdata;
    wire [31:0]             inst_rdata;
    wire                    inst_addr_ok;
    wire                    inst_data_ok;

    // data sram-like
    wire                    data_req;
    wire                    data_wr;
    wire [1:0]              data_size;
    wire [31:0]             data_addr;
    wire [31:0]             data_wdata;
    wire [31:0]             data_rdata;
    wire                    data_addr_ok;
    wire                    data_data_ok;

    // sram 信号
    wire [31:0]  inst_sram_addr;
    wire         inst_sram_en;
    wire [31:0]  inst_sram_rdata;
    

    wire [31:0]  data_sram_addr;
    wire         data_sram_en;
    wire         data_sram_wen;
    wire [31:0]  data_sram_wdata;
    wire [31:0]  data_sram_rdata;

    wire         stallreq_rinst;
    wire         stallreq_rdata;
    wire         stallreq_wdata;

    if_stage if_stage0(.cpu_clk_50M(cpu_clk_50M), .cpu_rst_n(cpu_rst_n),
        .pc(pc), .ice(inst_sram_en), .iaddr(inst_sram_addr),
        .jtsel(jtsel), .addr1(addr1), .addr2(addr2), .addr3(addr3),
        .stall(stall), .flush(flush), .cp0_excaddr(cp0_excaddr)
    );
    
    ifid_reg ifid_reg0(.cpu_clk_50M(cpu_clk_50M), .cpu_rst_n(cpu_rst_n),
        .if_pc(pc), .id_pc(id_pc_i), .stall(stall), .flush(flush)
    );

    id_stage id_stage0(.cpu_rst_n(cpu_rst_n), .id_pc_i(id_pc_i), 
        .id_inst_i(inst_sram_rdata),
        .rd1(rd1), .rd2(rd2),
        .rreg1(re1), .rreg2(re2), 	  
        .ra1(ra1), .ra2(ra2), 
        .id_aluop_o(id_aluop_o), .id_alutype_o(id_alutype_o),
        .id_src1_o(id_src1_o), .id_src2_o(id_src2_o),
        .id_wa_o(id_wa_o), .id_wreg_o(id_wreg_o), .id_whilo_o(id_whilo_o),
        .id_mreg_o(id_mreg_o), .id_din_o(id_din_o),
        .id_retaddr_o(id_retaddr_o),
        .jtsel(jtsel), .addr1(addr1), .addr2(addr2), .addr3(addr3),
        .exe2id_wreg(exe2id_wreg), .exe2id_wa(exe2id_wa), .exe2id_wd(exe2id_wd),
        .mem2id_wreg(mem2id_wreg), .mem2id_wa(mem2id_wa), .mem2id_wd(mem2id_wd),
        .exe2id_mreg(exe2id_mreg), .mem2id_mreg(mem2id_mreg), .stallreq_id(stallreq_id),
        .id_in_delay_i(next_delay_o), .flush_im(flush_im),
        .cp0_addr(id_cp0_addr_o), .id_pc_o(id_pc_o),
        .id_in_delay_o(id_in_delay_o), .next_delay_o(next_delay_i),
        .id_exccode_o(id_exccode_o)
    );
    
    regfile regfile0(.cpu_clk_50M(cpu_clk_50M), .cpu_rst_n(cpu_rst_n),
        .we(wb_wreg_o), .wa(wb_wa_o), .wd(wb_wd_o),
        .re1(re1), .ra1(ra1), .rd1(rd1),
        .re2(re2), .ra2(ra2), .rd2(rd2)
    );
    
    idexe_reg idexe_reg0(.cpu_clk_50M(cpu_clk_50M), .cpu_rst_n(cpu_rst_n), 
        .id_alutype(id_alutype_o), .id_aluop(id_aluop_o),
        .id_src1(id_src1_o), .id_src2(id_src2_o),
        .id_wa(id_wa_o), .id_wreg(id_wreg_o), .id_whilo(id_whilo_o),
        .id_mreg(id_mreg_o), .id_din(id_din_o), .id_retaddr(id_retaddr_o),
        .id_cp0_addr(id_cp0_addr_o), .id_pc(id_pc_o),
        .id_in_delay(id_in_delay_o), .next_delay_i(next_delay_i),
        .id_exccode(id_exccode_o),
        .exe_alutype(exe_alutype_i), .exe_aluop(exe_aluop_i),
        .exe_src1(exe_src1_i), .exe_src2(exe_src2_i), 
        .exe_wa(exe_wa_i), .exe_wreg(exe_wreg_i), .exe_whilo(exe_whilo_i),
        .exe_mreg(exe_mreg_i), .exe_din(exe_din_i), .exe_retaddr(exe_retaddr_i),
        .exe_cp0_addr(exe_cp0_addr_i), .exe_pc(exe_pc_i),
        .exe_in_delay(exe_in_delay_i), .next_delay_o(next_delay_o),
        .exe_exccode(exe_exccode_i),
        .stall(stall), .flush(flush)
    );
    
    exe_stage exe_stage0(.cpu_clk_50M(cpu_clk_50M), .cpu_rst_n(cpu_rst_n),
        .exe_alutype_i(exe_alutype_i), .exe_aluop_i(exe_aluop_i),
        .exe_src1_i(exe_src1_i), .exe_src2_i(exe_src2_i),
        .exe_wa_i(exe_wa_i), .exe_wreg_i(exe_wreg_i), .exe_whilo_i(exe_whilo_i),
        .exe_mreg_i(exe_mreg_i), .exe_din_i(exe_din_i),
        .exe_retaddr_i(exe_retaddr_i),
        .exe_hi_i(exe_hi_i), .exe_lo_i(exe_lo_i),
        .exe_aluop_o(exe_aluop_o),
        .exe_wa_o(exe_wa_o), .exe_wreg_o(exe_wreg_o), .exe_wd_o(exe_wd_o),
        .exe_whilo_o(exe_whilo_o), .exe_hilo_o(exe_hilo_o),
        .exe_mreg_o(exe_mreg_o), .exe_din_o(exe_din_o),
        .exe2id_wreg(exe2id_wreg), .exe2id_wa(exe2id_wa), .exe2id_wd(exe2id_wd),
        .mem2exe_whilo(mem2exe_whilo), .mem2exe_hilo(mem2exe_hilo),
        .wb2exe_whilo(wb2exe_whilo), .wb2exe_hilo(wb2exe_hilo),
        .exe2id_mreg(exe2id_mreg), .stallreq_exe(stallreq_exe),
        .cp0_addr_i(exe_cp0_addr_i), .cp0_data_i(data_o),
        .exe_pc_i(exe_pc_i), .exe_in_delay_i(exe_in_delay_i),
        .exe_exccode_i(exe_exccode_i),
        .cp0_re_o(cp0_re), .cp0_raddr_o(raddr),
        .cp0_we_o(exe_cp0_we_o), .cp0_waddr_o(exe_cp0_waddr_o),
        .cp0_wdata_o(exe_cp0_wdata_o), .exe_pc_o(exe_pc_o),
        .exe_in_delay_o(exe_in_delay_o), .exe_exccode_o(exe_exccode_o),
        .mem2exe_cp0_we(mem_cp0_we_o), .mem2exe_cp0_wa(mem_cp0_waddr_o),
        .mem2exe_cp0_wd(mem_cp0_wdata_o),
        .wb2exe_cp0_we(cp0_we), .wb2exe_cp0_wa(waddr), .wb2exe_cp0_wd(wdata)
    );
    
    hilo hilo0(.cpu_clk_50M(cpu_clk_50M), .cpu_rst_n(cpu_rst_n),
        .we(wb_whilo_o),
        .hi_i(wb_dhi_o), .lo_i(wb_dlo_o),
        .hi_o(exe_hi_i), .lo_o(exe_lo_i)
    );
        
    exemem_reg exemem_reg0(.cpu_clk_50M(cpu_clk_50M), .cpu_rst_n(cpu_rst_n),
        .exe_aluop(exe_aluop_o),
        .exe_wa(exe_wa_o), .exe_wreg(exe_wreg_o), .exe_wd(exe_wd_o),
        .exe_whilo(exe_whilo_o), .exe_hilo(exe_hilo_o),
        .exe_mreg(exe_mreg_o), .exe_din(exe_din_o),
        .exe_cp0_we(exe_cp0_we_o), .exe_cp0_waddr(exe_cp0_waddr_o),
        .exe_cp0_wdata(exe_cp0_wdata_o), .exe_pc(exe_pc_o),
        .exe_in_delay(exe_in_delay_o), .exe_exccode(exe_exccode_o),
        .mem_aluop(mem_aluop_i),
        .mem_wa(mem_wa_i), .mem_wreg(mem_wreg_i), .mem_wd(mem_wd_i),
        .mem_whilo(mem_whilo_i), .mem_hilo(mem_hilo_i),
        .mem_mreg(mem_mreg_i), .mem_din(mem_din_i),
        .mem_cp0_we(mem_cp0_we_i), .mem_cp0_waddr(mem_cp0_waddr_i),
        .mem_cp0_wdata(mem_cp0_wdata_i), .mem_pc(mem_pc_i),
        .mem_in_delay(mem_in_delay_i), .mem_exccode(mem_exccode_i),
        .stall(stall), .flush(flush)
    );
    
    scu scu0(.cpu_rst_n(cpu_rst_n),
        .stallreq_id(stallreq_id), 
        .stallreq_exe(stallreq_exe), 
        .stallreq_rinst(stallreq_rinst),
        .stallreq_rdata(stallreq_rdata),
        .stallreq_wdata(stallreq_wdata),
        .stall(stall)
    );

    mem_stage mem_stage0(.cpu_rst_n(cpu_rst_n), .mem_aluop_i(mem_aluop_i),
        .mem_wa_i(mem_wa_i), .mem_wreg_i(mem_wreg_i), .mem_wd_i(mem_wd_i),
        .mem_whilo_i(mem_whilo_i), .mem_hilo_i(mem_hilo_i),
        .mem_mreg_i(mem_mreg_i), .mem_din_i(mem_din_i),
        .mem_aluop_o(mem_aluop_o), .mem_wa_o(mem_wa_o), .mem_wreg_o(mem_wreg_o), .mem_dreg_o(mem_dreg_o),
        .mem_whilo_o(mem_whilo_o), .mem_dhilo_o(mem_dhilo_o),
        .mem_mreg_o(mem_mreg_o), .mem_pc_o(mem_pc_o),
        .daddr(data_sram_addr), .dce(data_sram_en), .we(data_sram_wen), .din(data_sram_wdata), .dre(mem_dre_o),
        .mem2id_wreg(mem2id_wreg), .mem2id_wa(mem2id_wa), .mem2id_wd(mem2id_wd),
        .mem2exe_whilo(mem2exe_whilo), .mem2exe_hilo(mem2exe_hilo),
        .mem2id_mreg(mem2id_mreg),
        .cp0_we_i(mem_cp0_we_i), .cp0_waddr_i(mem_cp0_waddr_i),
        .cp0_wdata_i(mem_cp0_wdata_i), .mem_pc_i(mem_pc_i),
        .mem_in_delay_i(mem_in_delay_i), .mem_exccode_i(mem_exccode_i),
        .cp0_we_o(mem_cp0_we_o), .cp0_waddr_o(mem_cp0_waddr_o),
        .cp0_wdata_o(mem_cp0_wdata_o),
        .cp0_status(status_o), .cp0_cause(cause_o),
        .cp0_pc(pc_i), .cp0_in_delay(in_delay_i), .cp0_exccode(exccode_i), .cp0_badvaddr(badvaddr_i),
        .wb2mem_cp0_we(cp0_we), .wb2mem_cp0_wa(waddr), .wb2mem_cp0_wd(wdata),
        .device(mem_device)
    );
    	
    memwb_reg memwb_reg0(.cpu_clk_50M(cpu_clk_50M), .cpu_rst_n(cpu_rst_n),
        .mem_aluop(mem_aluop_o), .mem_wa(mem_wa_o), .mem_wreg(mem_wreg_o), .mem_dreg(mem_dreg_o),
        .mem_whilo(mem_whilo_o), .mem_dhilo(mem_dhilo_o),
        .mem_mreg(mem_mreg_o), .mem_dre(mem_dre_o),
        .mem_cp0_we(mem_cp0_we_o), .mem_cp0_waddr(mem_cp0_waddr_o),
        .mem_cp0_wdata(mem_cp0_wdata_o),
        .wb_aluop(wb_aluop_i), .wb_wa(wb_wa_i), .wb_wreg(wb_wreg_i), .wb_dreg(wb_dreg_i),
        .wb_whilo(wb_whilo_i), .wb_dhilo(wb_dhilo_i),
        .wb_mreg(wb_mreg_i), .wb_dre(wb_dre_i),
        .wb_cp0_we(wb_cp0_we_i), .wb_cp0_waddr(wb_cp0_waddr_i),
        .wb_cp0_wdata(wb_cp0_wdata_i),
        .flush(flush), .mem_pc(mem_pc_o), .wb_pc(wb_pc_i),
        .mem_device(mem_device), .wb_device(wb_device)
    );

    wb_stage wb_stage0(.cpu_rst_n(cpu_rst_n),
        .wb_aluop_i(wb_aluop_i), .wb_wa_i(wb_wa_i), .wb_wreg_i(wb_wreg_i), .wb_dreg_i(wb_dreg_i),
        .wb_whilo_i(wb_whilo_i), .wb_dhilo_i(wb_dhilo_i),
        .wb_mreg_i(wb_mreg_i), .wb_dre_i(wb_dre_i),
        .dm(data_sram_rdata),
        .wb_wa_o(wb_wa_o), .wb_wreg_o(wb_wreg_o), .wb_wd_o(wb_wd_o),
        .wb_whilo_o(wb_whilo_o), .wb_dhi_o(wb_dhi_o), .wb_dlo_o(wb_dlo_o),
        .wb2exe_whilo(wb2exe_whilo), .wb2exe_hilo(wb2exe_hilo),
        .cp0_we_i(wb_cp0_we_i), .cp0_waddr_i(wb_cp0_waddr_i),
        .cp0_wdata_i(wb_cp0_wdata_i),
        .cp0_we_o(cp0_we), .cp0_waddr_o(waddr),
        .cp0_wdata_o(wdata), .wb_pc_i(wb_pc_i), .wb_pc_o(wb_pc_o),
        .device(wb_device)
    );
    
    cp0_reg cp0_reg0(.cpu_clk_50M(cpu_clk_50M), .cpu_rst_n(cpu_rst_n), 
        .we(cp0_we), 
        .re(cp0_re),
        .raddr(raddr),
        .waddr(waddr), 
        .wdata(wdata), 
        .int_i(int), 
        .pc_i(pc_i),
        .in_delay_i(in_delay_i),
        .exccode_i(exccode_i), 
        .badvaddr_i(badvaddr_i),
        .flush(flush),
        .flush_im(flush_im),
        .cp0_excaddr(cp0_excaddr), 
        .data_o(data_o), 
        .status_o(status_o), 
        .cause_o(cause_o),
        .timer_int_o(timer_int_o)
    );

    sram_like_interface sram_like_interface_0(
        .clk(cpu_clk_50M),
        .resetn(cpu_rst_n),
        .flush(flush),

        .inst_sram_addr_v(inst_sram_addr),
        .inst_sram_en(inst_sram_en),
        .inst_sram_rdata(inst_sram_rdata),
        .stallreq_rinst(stallreq_rinst),

        .data_sram_addr_v(data_sram_addr),
        .data_sram_en(data_sram_en),
        .data_sram_wen(data_sram_wen),
        .data_sram_wdata(data_sram_wdata),
        .data_sram_rdata(data_sram_rdata),
        .stallreq_rdata(stallreq_rdata),
        .stallreq_wdata(stallreq_wdata),

        .inst_req(inst_req),
        .inst_wr(inst_wr),
        .inst_size(inst_size),
        .inst_addr(inst_addr),
        .inst_wdata(inst_wdata),
        .inst_rdata(inst_rdata),
        .inst_addr_ok(inst_addr_ok),
        .inst_data_ok(inst_data_ok),

        .data_req(data_req),
        .data_wr(data_wr),
        .data_size(data_size),
        .data_addr(data_addr),
        .data_wdata(data_wdata),
        .data_rdata(data_rdata),
        .data_addr_ok(data_addr_ok),
        .data_data_ok(data_data_ok)
    );

    cpu_axi_interface cpu_axi_interface0(
        .clk(cpu_clk_50M),
        .resetn(cpu_rst_n),
        
        .inst_req(inst_req),
        .inst_wr(inst_wr),
        .inst_size(inst_size),
        .inst_addr(inst_addr),
        .inst_wdata(inst_wdata),
        .inst_rdata(inst_rdata),
        .inst_addr_ok(inst_addr_ok),
        .inst_data_ok(inst_data_ok),

        .data_req(data_req),
        .data_wr(data_wr),
        .data_size(data_size),
        .data_addr(data_addr),
        .data_wdata(data_wdata),
        .data_rdata(data_rdata),
        .data_addr_ok(data_addr_ok),
        .data_data_ok(data_data_ok),

        .arid(arid_o),
        .araddr(araddr_o),
        .arlen(arlen_o),
        .arsize(arsize_o),
        .arburst(arburst_o),
        .arlock(arlock_o),
        .arcache(arcache_o),
        .arprot(arprot_o),
        .arvalid(arvalid_o),
        .arready(arready_i),

        .rid(rid_i),
        .rdata(rdata_i),
        .rresp(rresp_i),
        .rlast(rlast_i),
        .rvalid(rvalid_i),
        .rready(rready_o),

        .awid(awid_o),
        .awaddr(awaddr_o),
        .awlen(awlen_o),
        .awsize(awsize_o),
        .awburst(awburst_o),
        .awlock(awlock_o),
        .awcache(awcache_o),
        .awprot(awprot_o),
        .awvalid(awvalid_o),
        .awready(awready_i),

        .wid(wid_o),
        .wdata(wdata_o),
        .wstrb(wstrb_o),
        .wlast(wlast_o),
        .wvalid(wvalid_o),
        .wready(wready_i),

        .bid(bid_i),
        .bresp(bresp_i),
        .bvalid(bvalid_i),
        .bready(bready_o)
    );


    // 用来做 debug 的信号
    assign debug_wb_pc = wb_pc_o;
    assign debug_wb_rf_wen = {{4{wb_wreg_o}}};
    assign debug_wb_rf_wnum = wb_wa_o;
    assign debug_wb_rf_wdata = wb_wd_o;


endmodule
