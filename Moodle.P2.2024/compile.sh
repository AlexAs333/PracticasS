set -e

mkdir -p WORK
ghdl -a -fexplicit -fsynopsys --std=08 --workdir=WORK fuentesMoodle/*.vhd
ghdl -e -fexplicit -fsynopsys --std=08 --workdir=WORK testbench
set +e
ghdl -r --workdir=WORK testbench --stop-time=10us --wave=wave.ghw
gtkwave wave.ghw
