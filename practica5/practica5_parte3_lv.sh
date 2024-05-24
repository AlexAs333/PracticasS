#!/bin/bash
#874252, Asensio Boj, Alex, T, 2, B
#874802, Báscones Gállego, Pablo, T, 2, B

#!/bin/bash

#--------------------------ROBUSTEZ--------------------------
if [ $EUID -ne 0 ]; then
    echo "Se requieren permisos de administrador"
    exit 1
fi

#--------------------------OBTENCIÓN DATOS--------------------------
echo "Introduzca la información necesaria en el formato: nombreVG,nombreLV,size,tipoFS,dirMontaje"
echo -n "-> "
read -r vg lv size fs dirM

#--------------------------COMPROBACIÓN DATOS--------------------------
if [ -z "$vg" ] || [ -z "$lv" ] || [ -z "$size" ] || [ -z "$fs" ] || [ -z "$dirM" ]; then #No campos vacíos
    echo "Alguno de los campos introducidos está vacío"
    exit 2
fi

if ! vgscan | grep -q "\"$vg\""; then   #Existe grupo de volumen
    echo "El grupo de volumen \"$vg\" no se ha encontrado"
    exit 3
fi

# Verificar que el tamaño tenga un formato correcto
if ! echo "$size" | grep -q '^[0-9]\+\(B\|K\|M\|G\)$'; then #Tamaño correcto
    echo "Tamaño introducido incorrectamente. Formato: [0-9]+(B|K|M|G)"
    exit 4
fi

if ! grep -q "$fs" /proc/filesystems; then  #Sistema archivos válidos
    echo "$fs no es un sistema de archivos soportado"
    exit 5
fi

if [ ! -d "$dirM" ]; then   #Existe punto de montaje
    echo "El directorio $dirM no existe o no es accesible"
    exit 6
fi

#--------------------------PROGRAMA PRINCIPAL--------------------------
if ! lvscan | grep -q "$vg/$lv"; then
    echo "Creando $lv..."
    lvcreate -L "$size" --name "$lv" "$vg"
    mkfs -t "$fs" /dev/"$vg"/"$lv"
    mount -t "$fs" /dev/"$vg"/"$lv" "$dirM"
    echo "$(blkid /dev/"$vg"/"$lv" | awk '{print $2}' | tr -d '"') $dirM $fs defaults 0 0" | tee -a /etc/fstab
else
    echo "Expandiendo $lv..."
    umount /dev/"$vg"/"$lv"
    lvextend -L +"$size" /dev/"$vg"/"$lv"
    resize2fs /dev/"$vg"/"$lv"
    mount -t "$fs" /dev/"$vg"/"$lv" "$dirM"
fi
