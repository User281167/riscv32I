## RISC-V 32I Core Implementation

### Overview

This repository contains a simple and efficient implementation of the RISC-V 32I instruction set architecture using SystemVerilog. It is designed for educational purposes and provides a clean and well-documented codebase for those interested in learning or teaching about the RISC-V architecture.

### Features

- Compliant with the RISC-V 32I base integer instruction set
- Written in SystemVerilog for hardware description and design
- Easy to understand and extend for custom projects
- Suitable for educational use and small-scale RISC-V projects

### Getting Started

1.  **Clone the Repository**:

```
git clone https://github.com/User281167/riscv32I.git
cd riscv32I
```

2.  **Compile and Simulate**:

- Ensure you have Icarus Verilog and GTKWave installed.
- Run the simulation script provided to verify the functionality.

You can use RISC-V Venus Simulator extension in VSCode:

```
ext install hm.riscv-venus
```

### Usage

Modules are located in the `modules` folder, and you can test each one individually.

**To run a test:**

```
.\run_test.bat module_name
```

Do not use the file extension, just the name.

**To run a test and open with GTKWave:**

```
.\run_test.bat module_name gtk
```

**To run a test and open with VSCode extension:**

```
.\run_test.bat module_name vpp
```

**To run all tests:**

```
.\run_test.bat
```

**Clear a log txt file:**

```
.\run_test.bat
```

The file is cleared in each run.

Vpp files are saved in the `simulation` folder, which is created by the bat file.

### RISC-V

**To test and run the RISC-V top entity and open with GTKWave, you can run:**

```
.\run_test.bat riscv gtk example_compile_programm
```

**Run the multiplication program:**

```
.\run_test.bat riscv gtk mul
```

Or using the VSCode extension:

```
.\run_test.bat riscv vpp example_compile_programm
```

`example_compile_programm` is the program to load in instruction memory, containing the byte of the instruction, see programs folder.

Example:

```
0010001
0010001
...
```

Instructions load with:

```
$value$plusargs("file=%s", filename)
```

No need to rerun `riscv` and open GTKWave or VSCode extension again.
**Example previous run:**

```
.\run_test.bat riscv gtk mul
```

If code changes and you have GTKWave open with previous output:

```
.\run_test.bat riscv mul
```

Then push update in GTKWave app or VSCode extension.
