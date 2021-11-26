# MIPSCPU
A Simple 5-stage pipeline MIPS CPU for TJU Computer Architecture Course.

## 工程目录
- report: 实验报告
- Soc：CPU 核心工程文件，五级流水、分支预测
- Soc_Sram: soc_sram_lite 的平台代码，适配 GENESYS2
- Soc_AXI: soc_axi 的平台代码，适配 GENESYS2
- AXI: AXI 总线接口
- Cache: Cache的实现
- TEMU：使用 C 语言开发的 Mips32 仿真器，可用于做差分测试，使用 git submoudle 进行管理
- testbench：基准测试程序
- utils：我们在编写过程中使用的工具, 现在有以下工具：
  - assembler：使用 Python 编写的跨平台的汇编器
  - disassembler：使用 Python 编写的跨平台的反汇编器
