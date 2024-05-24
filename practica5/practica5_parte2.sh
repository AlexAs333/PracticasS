#!/bin/bash
#874252, Asensio Boj, Alex, T, 2, B
#874802, Báscones Gállego, Pablo, T, 2, B

if [ $# -ne 1 ]; then
    echo "Uso ./practica5_parte2.sh <ip_objetivo>"
    exit 1
fi

clave="~/.ssh/id_as_ed25519"
usuario="as@$1"

ping -c 1 "$1" &>/dev/null

if [ $? -ne 0 ]; then
    echo "No se ha podido conectar con la maquina "$1""
    exit 1
else
    ssh -q -i "$clave" "$usuario" "sudo sfdisk -s | awk '/^\/dev\//'" #discos disponibles y tamaño bloque
    ssh -q -i "$clave" "$usuario" 'sudo sfdisk -l | awk "/^\/dev\// {gsub(/\"|\\*/, \"\"); gsub(/ +/, \" \"); print \$1, \$5}"' #particiones y tamaño de cada
    ssh -q -i "$clave" "$usuario" "sudo df -hT | awk '!/tmpfs/ && /^\/dev\//'" #info del sistema de ficheros
fi
exit 0