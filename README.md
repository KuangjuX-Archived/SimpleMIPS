# MIPSCPU
A Simple MIPS CPU for TJU Computer Architecture Course

## 工程目录
- ip： ip核目录
- report： 报告目录
- Soc：CPU 核心工程文件，五级流水、分支预测、Cache 的实现都在里面
- TEMU：Mips32 仿真器，使用 git submoudle 进行管理
- testbench：基准测试程序
- vivado：vivado 工程目录，仿真时需要导入工程文件和 ip 核