## Memoria Práctica 5
<div style="text-align: right;">
<b>Autores: Alex Asensio y Pablo Báscones</b>
</div>
<p></p>

Partimos desde las **máquinas de la Práctica 4**. En la que el anfitrión es capaz de conectarse con las claves públicas mediante un ssh al resto de dispositivos. Seguiremos distintos pasos:

**DISCO**

### 1. Creación del disco y sus particiones
### 1.1 Creación del disco
Con ``sudo fdisk -l`` comprobamos que hemos añadido el disco requerido, ya que este comando nos escribirá en pantalla los volúmenes de la máquina, incluido el deseado ``/dev/sdb``.

### 1.2 Creación de las particiones del disco
Se nos piden añadir dos particiones tipo de tamaño 16 MiB con una tabla de partición GUID en el disco.
Como bien es sabido, para el funcionamiento correcto de un disco debemos seguir los siguientes pasos:

### 1.2.1 Particiones
Se crearán con los  comandos:
```bash
sudo parted /dev/sdb
 (parted) mklabel gpt #creación de la tabla
 (parted) mkpart primary ext3 0GB 1GB #partición 1
 (parted) mkpart primary ext4 1GB 2GB #partición 2
 (parted) align-check op 1 #primer alineamiento correcto
 (parted) align-check op 2 #segundo alineamiento correcto
 (parted) quit #cerrar
```

### 1.2.2 Formateo
Previo al montaje del disco se han de formatear las particiones, esto se hará con los siguientes comandos:
```bash
sudo mkfs.ext3 /dev/sdb1 #formateo primera con sudo
sudo mkfs.ext4 /dev/sdb2 #formateo segunda con sudo
```

### 1.2.3 Montaje del disco
Por último se procederá al montaje del disco particionado:
```bash
sudo mount -t ext3 /dev/sdb1 ~/part1 #montaje partición 1
sudo mount -t ext4 /dev/sdb2 ~/part2 #montaje partición 2
```

Debido a que queremos que se monten las particiones al iniciar el sistema, deberemos modificar el fichero "/etc/fstab" de tal manera que:

```bash
UUID = $(ls -l /dev/disk/by-uuid/ | grep sdbl | cut -d' ' -f10)
echo "UUID = $UUID ~/part1 ext3 defaults 0 0" | sudo tee -a/etc/fstab
```

**LVM**
### 2. Grupo volumen

Tras añadir un pequeño disco de partición única a la máquina, pasaremos a crear su grupo de volumen.

Para ello deberemos utilizar los siguientes comandos:

```bash
sudo pvcreate /dev/sdc1 # crea el volumen fisico
sudo vgcreate vg_p5 /dev/sdc1 # crea el grupo volumen
sudo vgchange -a y vg_p5 # se activa
```

### 2.1 VG

Si queremos aumentar el tamaño del disco añadido, debemos, evidentemente, desmontarlo previamente con ``sudo umount`` en lo que hay que desmontar.

Si al hacer un ``vgdisplay`` como sudo, aparecen los volúmenes físicos que hayamos creado y su apartado de Metadata aparece un 3, si no:

```bash
vgextend vg_p5 /dev/sdb1 /dev/sdb2 
```

### 2.2 LV

Tras crear y extender los volúmenes físicos, se ha de crear el lógico:

```bash
sudo lvcreate -L 2GB --name lv_p5 vg_p5
sudo mkfs -t ext4 /dev/vg_p5/lv_p5 #creación completada
sudo lvextend -L +900MB /dev/vg_p5/lv_p5 #extender
```
Al igual que hemos comprobado antes con ``vgextend`` se hará con ``sudo lvdisplay`` pero en este caso deberá mostrar 2.9GB, el tamaño deseado.
