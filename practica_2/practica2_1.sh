#!/bin/bash
#874252, Asensio Boj, Alex, T, 2, B
#874802, Báscones Gállego, Pablo, T, 2, B

echo -n "Introduzca el nombre del fichero: "
read fichero
if [ ! -e "$fichero" ]; then 
	echo ""$fichero" no existe"
	exit 1
fi

#opcion 1: 
#permisos=$(stat -c "%A" "$fichero" | cut -c 2-4)
#echo "Los permisos del "$fichero" son $permisos"

#opcion 2:
#permisos=""

#[ -r "$fichero" ] && permisos="r" || permisos="-"
#[ -w "$fichero" ] && permisos+="w" || permisos+="-"
#[ -x "$fichero" ] && permisos+="x" || permisos+="-"

#echo "Los permisos del archivo "$fichero" son $permisos"

#opcion 3:
echo -n "Los permisos del archivo "$fichero" son: "

[ -r "$fichero" ] && echo -n "r" || echo -n "-"
[ -w "$fichero" ] && echo -n "w" || echo -n "-"
[ -x "$fichero" ] && echo "x" || echo "-"





