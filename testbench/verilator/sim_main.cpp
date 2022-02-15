#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vsoc_lite_top.h"

#define MAX_SIM_TIME 1000000

int main(int argc, char** argv, char** env){
    Verilated::commandArgs(argc, argv);
    // 新建对象
    Vsoc_lite_top* top = new Vsoc_lite_top;

    Verilated::traceEveron(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    top->trace(m_trace, 5);
    m_trace->open("trace.vcd");

    top->resetn = 0;
    top->clk = 0;
    while(sim_time < MAX_SIM_TIME){
        top->clk ^= 1;
        if(sim_time == 10){
            top->resetn = 1;
        }
        top->eval();
        sim_time++;
    }

    m_trace->close();
    delete top;
}