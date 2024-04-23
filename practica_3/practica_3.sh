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
if [ $# -ne 2 ]; then
	echo "Numero incorrecto de parametros"
	exit 2
fi
#Comprobar permisos de creación
if [[ "$1" != "-a" && "$1" != "-s" ]]; then
	echo "Opcion invalida" 	
	exit 3
fi

#----------BORRAR USUARIOS----------
if [ "$1" == -s ]; then
	#Crear directorio backup si no existe
	[ ! -d "/extra/backup" ] && mkdir -p /extra/backup
	while read -r linea; do #Leer lineas de fichero
		usuario=$(echo "$linea" | cut -d ',' -f 1) #Obtiene el usuario q hay q borrar
		#Comprobar que exista el usuario
		id $usuario &> /dev/null
		if [ $(echo $?) -eq 0 ]; then #si no existe no pasa nada
			home=$(grep $usuario /etc/passwd | cut -d: -f6)
			tar >/dev/null 2>&1 -cf /extra/backup/$usuario.tar $home			
			[ $(echo $?) -eq 0 ] && userdel -r "$usuario" 2>/dev/null #comprobar que backup OK, si tal userdel
		fi
	done < "$2"
	

#----------AÑADIR USUARIOS----------
else
	while read -r linea; do #Leer lineas de fichero
		IFS=, read -r usuario paswrd nComp <<< "$linea" #Guardar cada parámetro en su var
		#Comprobar que ningún campo sea nulo
		if [[ -z $usuario || -z $paswrd || -z $nComp ]]; then
			echo "Campo invalido"
			exit 4
		fi
		#Comprobar que no exista el usuario
		id $usuario &> /dev/null
		if [ $(echo $?) -eq 0 ]; then #Ya existe
			echo "El usuario $usuario ya existe" 
		else #No existe
			useradd -c "$nComp" "$usuario" -K PASS_MAX_DAYS=30 -K UID_MIN=1815 -U -m -k /etc/skel
			#cambiar pasword
			echo "$usuario:$paswrd" | chpasswd
			usermod -U "$usuario"
			echo "$nComp ha sido creado"	
		fi	      
	done < "$2"
fi