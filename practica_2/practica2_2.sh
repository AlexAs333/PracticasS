#!/bin/bash
#874252, Asensio Boj, Alex, T, 2, B
#874802, Báscones Gállego, Pablo, T, 2, B

for fichero in "$@"; do
	[ -f "$fichero" ] && more "$fichero" || echo "$fichero no es un fichero válido"
done

