#!/bin/bash
#874252, Asensio Boj, Alex, T, 2, B
#874802, Báscones Gállego, Pablo, T, 2, B
echo -n "Introduzca el nombre de un directorio: "
read rutadir

if [ ! -d "$rutadir" ]; then
    	echo "$rutadir no es un directorio"
    	exit 1
fi

#ls -p añade / después de los directorios. grep -v invierte la selección de grep
nFich=$(ls "$rutadir" -p | grep -v / | wc -l)
nDir=$(ls "$rutadir" -p | grep / | wc -l)
echo "El numero de ficheros y directorios en $rutadir es de $nFich y $nDir, respectivamente"
