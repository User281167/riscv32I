@echo off

if exist "simulation\%1.vcd" (
    rm simulation\%1 -f
    rm simulation\%1.vcd -f
)

iverilog -g2012 -o simulation\%1 tests\%1.test.sv modules\%1.sv
cd simulation
vvp %1
cd ..

if "%2" == "gtk" (
    gtkwave simulation/%1.vcd
) else if "%2" == "vpp" (
    code simulation/%1.vcd
)
