# MIPSCPU
A Simple MIPS CPU for TJU Computer Architecture Course

## 工程目录
- ip： ip核目录
- report： 报告目录
- Soc：CPU 核心工程文件，五级流水、分支预测
- Cache: Cache的实现
- TEMU：Mips32 仿真器，使用 git submoudle 进行管理
- testbench：基准测试程序
- utils：我们在编写过程中使用的工具, 现在有以下工具：
  - assembler：使用 Python 编写的跨平台的汇编器
  - disassembler：使用 Python 编写的跨平台的反汇编器

## 测试通过的指令
### I-type
- [x] LUI
- [x] ADDI 

### R-type
- [x] AND

### J-type

### 自陷指令

## TODO
- [ ] 将译码阶段的一些部分进行封装