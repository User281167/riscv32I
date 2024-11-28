@echo off

if not exist "simulation\" (
    mkdir simulation
)

if exist "simulation\%1.vcd" (
    rm simulation\%1 -f
    rm simulation\%1.vcd -f
)

if "%1" == "riscv" (
    iverilog -g2012 -o simulation\%1 tests\%1.test.sv %1.sv
) else if "%1" == "riscv_segmentation" (
    iverilog -g2012 -o simulation\%1 tests\%1.test.sv %1.sv
) else (
    iverilog -g2012 -o simulation\%1 tests\%1.test.sv modules\%1.sv
)

cd simulation

if "%~3"=="" (
    if "%1"=="riscv" (
        vvp %1 +file="..\programs\%2.hex" @REM pass parameter to riscv
    ) else if "%1"=="riscv_segmentation" (
        vvp %1 +file="..\programs\%2.hex" @REM pass parameter to riscv
    ) else (
        vvp %1 @REM only synthesis
    )
) else (
    vvp %1 +file="..\programs\%3.hex" @REM pass parameter to riscv and open waveform
)

cd ..

if "%2" == "gtk" (
    gtkwave simulation/%1.vcd
) else if "%2" == "vpp" (
    code simulation/%1.vcd
)
