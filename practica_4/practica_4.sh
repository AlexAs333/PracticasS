#!/bin/bash
#874252, Asensio Boj, Alex, T, 2, B
#874802, Báscones Gállego, Pablo, T, 2, B

#----------ROBUSTEZ----------
#Comprobar que el usuario que ejecuta tiene privilegios de administracion
if [ "$(id -u)" -ne 0 ]; then
 	echo "Este script necesita privilegios de administracion" 
	exit 1
fi

#Comprobar número de parámetros
if [ $# -ne 3 ]; then
	echo "Numero incorrecto de parametros"
	exit 2
fi

#La comprobación de -a / -s ya se hacen en el script copiado

#----------PROGRAMA----------
script="/home/as/MVAdsis/tests_practicas_AS/practica_3/practica_3.sh"
clave="/home/as/.ssh/id_as_ed25519"
usr="as"

while read -r dir; do
    #COPIA DE FICHEROS EN LA OTRA MÁQUINA
    scp -i "$clave" "$script" "$usr"@"$dir":/tmp &> /dev/null    #Copia del script
    scp -i "$clave" "$2" "$usr"@"$dir":/tmp &> /dev/null   #Copia del fichero de usuarios 

    if [ $(echo $?) -ne 0 ]; then #Comprobación de que se ha podido conectar a la máquina
        echo "$dir no es accesible"
        exit 3
    fi

    ssh -i "$clave" "$usr"@"$dir" "sudo bash /tmp/practica_3.sh $1 $2"    #ejecución del script
done < "$3"