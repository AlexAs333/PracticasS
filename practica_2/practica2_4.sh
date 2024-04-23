#!/bin/bash
#874252, Asensio Boj, Alex, T, 2, B
#874802, Báscones Gállego, Pablo, T, 2, B

echo -n "Introduzca una tecla: "
read tecla
teclaL=$(echo "$tecla" | cut -c 1) # obtenemos solo el primer carácter de lo introducido

echo -n "$teclaL"
case "$teclaL" in
    [0-9])
        echo " es un numero"
        ;;

    [a-zA-Z])
        echo " es una letra"
        ;;

    *)
        echo " es un caracter especial"
        ;;
esac

