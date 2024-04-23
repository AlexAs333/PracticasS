#!/bin/bash
#874252, Asensio Boj, Alex, T, 2, B
#874802, Báscones Gállego, Pablo, T, 2, B

# Ver si ya existe algún fichero con el patron binXXX
nDir=$(ls -p "$HOME" | grep -E "bin[a-zA-Z0-9]{3}/" | wc -l)

if [ $nDir -ne 0 ]; then
    tiempo=0
    for directorio in $(ls -p "$HOME" | grep -E "bin[a-zA-Z0-9]{3}/"); do
        dirPath="$HOME/$directorio"
        if [ "$(stat -c %Y "$dirPath")" -gt $tiempo ]; then
            tiempo=$(stat -c %Y "$dirPath")
            bin=$(echo "$dirPath" | cut -c 1-$((${#dirPath}-1)))
        fi
    done
else
    bin=$(mktemp -d "$HOME/binXXX")
    echo "Se ha creado el directorio $bin"
fi

# Copiar los archivos del directorio al temporal
n=0
echo "Directorio destino de copia: $bin"
for fichero in *; do
    if [ -x "$fichero" -a ! -d "$fichero" ]; then 
        cp "$fichero" "$bin"
        echo "./$fichero ha sido copiado a $bin"
        n=$((n+1))
    fi
done

if [ $n -eq 0 ]; then
    echo "No se ha copiado ningun archivo"
else
    echo "Se han copiado $n archivos"
fi

