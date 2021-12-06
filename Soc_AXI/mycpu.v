module mycpu(
    input wire           [5:0] ext_int,
    input wire           aclk,
    input wire           aresetn,

    // output  wire         inst_sram_en,
    // output  wire [3:0]   inst_sram_wen,
    // output  wire [31:0]  inst_sram_addr,
    // output  wire [31:0]  inst_sram_wdata,
    // input   wire [31:0]  inst_sram_rdata,
    
    // output  wire         data_sram_en,
    // output  wire [3:0]   data_sram_wen,
    // output  wire [31:0]  data_sram_addr,
    // output  wire [31:0]  data_sram_wdata,
    // input   wire [31:0]  data_sram_rdata,

    output wire [3:0]       arid,
    output wire [31:0]      araddr,
    output wire [3:0]       arlen,
    output wire [2:0]       arsize,
    output wire [1:0]       arburst,
    output wire [1:0]       arlock,
    output wire [3:0]       arcache,
    output wire [2:0]       arprot,
    output wire             arvalid,
    input  wire             arready,

    input  wire [3:0]       rid,
    input  wire [31:0]      rdata,
    input  wire [1:0]       rresp,
    input  wire             rlast,
    input  wire             rvalid,
    output wire             rready, 

    output wire [3:0]       awid,
    output wire [31:0]      awaddr,
    output wire [3:0]       awlen,
    output wire [2:0]       awsize,
    output wire [1:0]       awburst,
    output wire [1:0]       awlock,
    output wire [3:0]       awcache,
    output wire [2:0]       awprot,
    output wire             awvalid,    
    input  wire             awready,

    output wire [3:0]       wid,
    output wire [31:0]      wdata,
    output wire [3:0]       wstrb, 
    output wire             wlast,
    output wire             wvalid,
    input  wire             wready,

    input  wire [3:0]       bid, 
    input  wire [1:0]       bresp,
    input  wire             bvalid,
    output wire             bready,    

    output  wire [31:0]  debug_wb_pc,
    output  wire [3 :0]  debug_wb_rf_wen,
    output  wire [4 :0]  debug_wb_rf_wnum,
    output  wire [31:0]  debug_wb_rf_wdata
);

    // wire           ice;
    // wire           dce;

    // assign inst_sram_en = (resetn == 1'b0) ? 1'b0 : ice;
    // assign inst_sram_wen = 4'b0000;
    // assign inst_sram_wdata = 32'h00000000;

    // assign data_sram_en = (resetn == 1'b0) ? 1'b0 : dce;

    // wire [31:0] inst_sram_addr_v, data_sram_addr_v;

    wire timer_int;

    // MiniMIPS32 MiniMIPS32_0(
    //     .cpu_clk_50M(clk),
    //     .cpu_rst_n(resetn),

    //     .iaddr(inst_sram_addr_v), 
    //     .ice(ice),
    //     .inst(inst_sram_rdata),
    //     .dce(dce),
    //     .daddr(data_sram_addr_v),
    //     .we(data_sram_wen),
    //     .din(data_sram_wdata),
    //     .dm(data_sram_rdata),

    //     .int({timer_int, ext_int[4:0]}),
    //     .timer_int_o(timer_int),

    //     .debug_wb_pc(debug_wb_pc),
    //     .debug_wb_rf_wen(debug_wb_rf_wen),
    //     .debug_wb_rf_wnum(debug_wb_rf_wnum),
    //     .debug_wb_rf_wdata(debug_wb_rf_wdata)
    // );

    // AXI 接口的核心文件
    MiniMIPS32 MiniMIPS32_0(
        .cpu_clk_50M(aclk),
        .cpu_rst_n(aresetn),
        .int({timer_int, ext_int[4:0]}),

        .arid_o      (arid      ),
        .araddr_o    (araddr    ),
        .arlen_o     (arlen     ),
        .arsize_o    (arsize    ),
        .arburst_o   (arburst   ),
        .arlock_o    (arlock    ),
        .arcache_o   (arcache   ),
        .arprot_o    (arprot    ),
        .arvalid_o   (arvalid   ),
        .arready_i   (arready   ),
                    
        .rid_i       (rid       ),
        .rdata_i     (rdata     ),
        .rresp_i     (rresp     ),
        .rlast_i     (rlast     ),
        .rvalid_i    (rvalid    ),
        .rready_o    (rready    ),
                
        .awid_o      (awid      ),
        .awaddr_o    (awaddr    ),
        .awlen_o     (awlen     ),
        .awsize_o    (awsize    ),
        .awburst_o   (awburst   ),
        .awlock_o    (awlock    ),
        .awcache_o   (awcache   ),
        .awprot_o    (awprot    ),
        .awvalid_o   (awvalid   ),
        .awready_i   (awready   ),
        
        .wid_o       (wid       ),
        .wdata_o     (wdata     ),
        .wstrb_o     (wstrb     ),
        .wlast_o     (wlast     ),
        .wvalid_o    (wvalid    ),
        .wready_i    (wready    ),
        
        .bid_i       (bid       ),
        .bresp_i     (bresp     ),
        .bvalid_i    (bvalid    ),
        .bready_o    (bready    ),

        //debug interface
        .debug_wb_pc      (debug_wb_pc      ),
        .debug_wb_rf_wen  (debug_wb_rf_wen  ),
        .debug_wb_rf_wnum (debug_wb_rf_wnum ),
        .debug_wb_rf_wdata(debug_wb_rf_wdata)
    );

    // // 指令存储器地址映射
    // mmu u0_mmu(
    //     .addr_i(inst_sram_addr_v),
    //     .addr_o(inst_sram_addr)
    // );

    // // 数据存储器地址映射
    // mmu u1_mmu(
    //     .addr_i(data_sram_addr_v),
    //     .addr_o(data_sram_addr)
    // );
    
endmodule