`timescale 1ps / 1ps

module MiniMIPS32_SYS_tb();

    // Inputs
	reg sys_clk_200M_p;
	reg sys_clk_200M_n;
	reg sys_rst_n;
	
	MiniMIPS32_SYS SoC (
		.sys_clk_200M_p(sys_clk_200M_p),
		.sys_clk_200M_n(sys_clk_200M_n),
		.sys_rst_n(sys_rst_n)
	);
	
	initial begin
		// Initialize Inputs
		sys_clk_200M_p = 1'b0;
		sys_clk_200M_n = 1'b1;
		sys_rst_n = 0;
		
		sys_rst_n = 1'b0;
		#200_000;
		sys_rst_n = 1'b1;
		
		#50_000_000 $stop;
	end
	
	always #2500 sys_clk_200M_p = ~sys_clk_200M_p;     // ÿ��2.5ns��sys_clk_200M_p�źŷ�תһ�Σ�����һ��������5ns����Ӧ200MHz
	always #2500 sys_clk_200M_n = ~sys_clk_200M_n;     // ÿ��2.5ns��sys_clk_200M_n�źŷ�תһ�Σ�����һ��������5ns����Ӧ200MHz

endmodule
