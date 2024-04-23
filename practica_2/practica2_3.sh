#!/bin/bash
#874252, Asensio Boj, Alex, T, 2, B
#874802, Báscones Gállego, Pablo, T, 2, B

if [ $# -ne 1 ]; then
    echo "Sintaxis: practica2_3.sh <nombre_archivo>"
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "$1 no existe"
    exit 2
fi

chmod u+x "$1"
stat -c "%A" "$1"

