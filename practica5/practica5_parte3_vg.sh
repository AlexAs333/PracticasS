#!/bin/bash
#874252, Asensio Boj, Alex, T, 2, B
#874802, Báscones Gállego, Pablo, T, 2, B

#--------------------------ROBUSTEZ--------------------------
if [ $# -lt 2 ]; then
    echo "./practica5_parte3_vg.sh <nombre_vg> <nombre_parte_1> ... <nombre_parte_i>"
    exit 1
fi

if [ $EUID -ne 0 ]; then
    echo "Hay que ejecutar el script con permisos de administrador"
    exit 2
fi

#--------------------------PROGRAMA PRINCIPAL--------------------------
vg="$1"
shift

if [ -z "$(sudo vgscan | grep "\"$vg\"")" ]; then
    echo "El grupo volumen \""$vg"\" no se ha encontrado"
    exit 3

else
    for parte in "$@"; do
        if [ -z "$(sfdisk -l | grep "$parte")" ]; then
            echo "No se ha encontrado en la particion \""$parte"\""
        
        else
            if [ -n "$(cat /etc/mtab | grep "$parte")" ]; then
                echo "La particion \""$parte"\" esta montada por lo que la desmontamos"
                umount "$parte"
            fi
            vgextend "$vg" "$parte"
        fi
    done
fi
