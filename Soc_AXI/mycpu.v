module mycpu_top(
    input wire           [5:0] ext_int,
    input wire           aclk,
    input wire           aresetn,

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

//inst_sram_like 
wire        inst_req;
wire        inst_wr; 
wire [1 :0] inst_size; 
wire [31:0] inst_addr;
wire [31:0] inst_wdata;
wire [31:0] inst_rdata;
wire        inst_addr_ok;
wire        inst_data_ok;
//data sram-like 
wire        data_req;
wire        data_wr; 
wire [1 :0] data_size; 
wire [31:0] data_addr;
wire [31:0] data_wdata;
wire [31:0] data_rdata;
wire        data_addr_ok;
wire        data_data_ok;

//never write inst 
// inst size always 32
assign inst_wr  = 1'b0;
assign inst_size = 2'b10;
assign inst_wdata = 32'h0000_0000;

   MiniMIPS32 MiniMIPS32_0(
    .cpu_clk_50M       (aclk              ),
    .cpu_rst_n         (aresetn           ),
    .int               (ext_int         ),

    .inst_req           (inst_req),
    .inst_data_ok       (inst_data_ok),
    .inst_addr_ok       (inst_addr_ok),
    .iaddr             (inst_addr),
    .inst              (inst_rdata       ),

    .data_data_ok       (data_data_ok),
    .data_addr_ok       (data_addr_ok),
    .data_req           (data_req    ),
    .data_wr            (data_wr),
    .data_size          (data_size),

    .dout              (data_rdata        ),
    .daddr             (data_addr),
    .din               (data_wdata         ),

        //debug interface
        .debug_wb_pc      (debug_wb_pc      ),
        .debug_wb_rf_wen  (debug_wb_rf_wen  ),
        .debug_wb_rf_wnum (debug_wb_rf_wnum ),
        .debug_wb_rf_wdata(debug_wb_rf_wdata)
    );
    
    cpu_axi_interface cpu_axi_interface0(
    	.clk          (aclk         ),
        .resetn       (aresetn      ),

        .inst_req     (inst_req     ),
        .inst_wr      (inst_wr      ),
        .inst_size    (inst_size    ),
        .inst_addr    (inst_addr    ),
        .inst_wdata   (inst_wdata   ),
        .inst_rdata   (inst_rdata   ),
        .inst_addr_ok (inst_addr_ok ),
        .inst_data_ok (inst_data_ok ),

        .data_req     (data_req     ),
        .data_wr      (data_wr      ),
        .data_size    (data_size    ),
        .data_addr    (data_addr    ),
        .data_wdata   (data_wdata   ),
        .data_rdata   (data_rdata   ),
        .data_addr_ok (data_addr_ok ),
        .data_data_ok (data_data_ok ),

        .arid         (arid         ),
        .araddr       (araddr       ),
        .arlen        (arlen        ),
        .arsize       (arsize       ),
        .arburst      (arburst      ),
        .arlock       (arlock       ),
        .arcache      (arcache      ),
        .arprot       (arprot       ),
        .arvalid      (arvalid      ),
        .arready      (arready      ),
        .rid          (rid          ),
        .rdata        (rdata        ),
        .rresp        (rresp        ),
        .rlast        (rlast        ),
        .rvalid       (rvalid       ),
        .rready       (rready       ),
        .awid         (awid         ),
        .awaddr       (awaddr       ),
        .awlen        (awlen        ),
        .awsize       (awsize       ),
        .awburst      (awburst      ),
        .awlock       (awlock       ),
        .awcache      (awcache      ),
        .awprot       (awprot       ),
        .awvalid      (awvalid      ),
        .awready      (awready      ),
        .wid          (wid          ),
        .wdata        (wdata        ),
        .wstrb        (wstrb        ),
        .wlast        (wlast        ),
        .wvalid       (wvalid       ),
        .wready       (wready       ),
        .bid          (bid          ),
        .bresp        (bresp        ),
        .bvalid       (bvalid       ),
        .bready       (bready       )
);
    
endmodule