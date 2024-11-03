@echo off

if not exist "simulation\" (
    mkdir simulation
) else (
    if "%1"=="clear" (
        > simulation\log.txt echo.
    )
)

echo [Run on %DATE% %TIME%]>>simulation\log.txt
echo.>>simulation\log.txt

for /f %%f in ('dir /b .\modules') do (
    echo ============== running %%~nf ==============>> simulation\log.txt

    if exist "simulation\%filename%.vcd" (
        rm simulation\%%~nf -f
        rm simulation\%%~nf.vcd -f
    )

    iverilog -g2012 -o simulation\%%~nf tests\%%~nf.test.sv modules\%%~nf.sv
    cd simulation
    vvp %%~nf
    vvp %%~nf >> log.txt
    echo.>> log.txt
    cd ..
)