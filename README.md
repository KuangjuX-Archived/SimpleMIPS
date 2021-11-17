# MIPSCPU
A Simple MIPS CPU for TJU Computer Architecture Course

## 工程目录
- report： 报告目录
- Soc：CPU 核心工程文件，五级流水、分支预测
- Soc_Sram: soc_sram_lite 的平台代码
- Soc_AXI: soc_axi 的平台代码
- AXI: AXI 总线接口
- Cache: Cache的实现
- TEMU：Mips32 仿真器，使用 git submoudle 进行管理
- testbench：基准测试程序
- utils：我们在编写过程中使用的工具, 现在有以下工具：
  - assembler：使用 Python 编写的跨平台的汇编器
  - disassembler：使用 Python 编写的跨平台的反汇编器

## 实现的指令
### I-type
- [x] ADDI 
- [x] ADDIU
- [x] ANDI
- [x] BEQ
- [x] BGEZ
- [x] BGTZ
- [x] BLEZ
- [x] BLTZ
- [x] BNE
- [x] LB
- [x] LBU
- [x] LH
- [x] LHU
- [x] LUI
- [x] ORI 
- [x] LW
- [x] SB
- [x] SLTI
- [x] SLTIU
- [x] SH
- [x] SW  
- [x] XORI



### R-type
- [x] ADD
- [x] ADDU
- [x] AND
- [ ] BREAK
- [x] DIV
- [x] DIVU
- [x] JALR
- [x] JR
- [x] MFHI
- [x] MFLO
- [x] MTHI
- [x] MTLO 
- [x] MULT
- [x] MULTU
- [x] NOR
- [x] OR
- [x] SLL
- [x] SLLV
- [x] SLT
- [x] SLTU
- [x] SRA
- [x] SRAV
- [x] SRL
- [x] SRLV
- [x] SUB
- [x] SUBU
- [x] SYSCALL
- [x] XOR

### J-type
- [x] J
- [x] JAL






## 测试通过的指令
### I-type
- [x] ADDI 
- [x] ADDIU
- [x] ANDI
- [ ] BEQ
- [ ] BGEZ
- [ ] BGTZ
- [ ] BLEZ
- [ ] BLTZ
- [ ] BNE
- [x] LB
- [x] LBU
- [x] LH
- [x] LHU
- [x] LUI
- [x] ORI 
- [x] LW
- [x] SB
- [x] SLTI
- [x] SLTIU
- [x] SH
- [x] SW  
- [x] XORI

### R-type
- [x] ADD
- [x] ADDU
- [x] AND
- [ ] BREAK
- [ ] DIV
- [ ] DIVU
- [ ] JALR
- [ ] JR
- [x] MFHI
- [x] MFLO
- [x] MTHI
- [x] MTLO 
- [x] MULT
- [x] MULTU
- [x] NOR
- [x] OR
- [x] SLL
- [x] SLLV
- [x] SLT
- [x] SLTU
- [x] SRA
- [x] SRAV
- [x] SRL
- [x] SRLV
- [x] SUB
- [x] SUBU
- [ ] SYSCALL
- [x] XOR

### J-type
- [ ] J
- [ ] JAL

## TODO
- [ ] 将译码阶段的一些部分进行封装