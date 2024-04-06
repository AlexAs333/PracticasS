#!/bin/bash
set -e
ghdl -a -fsynopsys -fexplicit --workdir=WORK *.vhd
ghdl -e -fsynopsys -fexplicit --workdir=WORK testbench
ghdl -r --workdir=WORK testbench --stop-time=10us --wave=wave.ghw
gtkwave -a ./testbench.gtkw wave.ghw