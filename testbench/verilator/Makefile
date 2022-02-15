MODULE = soc_lite_top

.PHONY: obj_dir/Vsoc_lite_top
TRACE_TIME := 100000

run: obj_dir/Vsoc_lite_top
	@obj_dir/Vsoc_lite_top 

trace.vcd: obj_dir/Vsoc_lite_top
	@obj_dir/Vsoc_lite_top -trace $(TRACE_TIME)

obj_dir/Vsoc_lite_top:
	verilator --cc --trace --exe -LDFLAGS "lncurses" --build sim_main.cpp ../../src/Soc_Sram/*.v ../../src/Soc_Sram/pipeline/*.v -y ../../src/Soc_Sram/pipeline --top-module $(MODULE)
