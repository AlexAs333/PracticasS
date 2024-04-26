## Memoria Práctica 4
<div style="text-align: right;">
<b>Autores: Alex Asensio y Pablo Báscones</b>
</div>
<p></p>

Partimos de una máquina virtual ya configurada, la usada en otras prácticas, que usaremos como **máquina principal**. Por tanto el proceso del trabajo se divide en 2 partes: **Configuración de las máquinas host** y **Diseño del script**.

### 1.Configuración de las máquinas host
#### 1.1 Configuración de la red
Iniciamos sesión como root e instalamos los paquetes necesarios para el desarrollo de la práctica como *sudo* y *openssh-server*. Para poder usar sudo desde el usuario as sin contraseña usamos el comando *visudo* y adjuntamos la linea:
```bash
# User Privilege specification
as  ALL=(ALL:ALL) NOPASSWD : ALL
```
Ahora desde VirtualBox vamos a configurar la segunda tarjeta de red. Para ello seleccionamos la máquina virtual y vamos a *Configuración/Red/Adapatador 2* y ponemos: 
- Conectado a: Adaptador sólo anfitrión
- Nombre: VirtualBox Host-Only Ethernet Adapter

También nos aseguramos que la MAC sea distinta a la de la máquina principal. Si esto no ocurre se puede generar una nueva MAC con el botón de al lado.

Para comprobar que todo ha salido correctamente volvemos a hacer *ip a*. Deberían salir 3 interfaces, nos apuntamos el nombre de la 3ª. Aquí le llamaremos **n_interfaz**. Para que la IP sea estática abrimos *etc/network/interfaces* y ponemos al final:
```bash
#Red interna
allow-hotplug n_interfaz
iface n_interfaz inet static
    adress 192.168.56.11
```
Además cambiamos el nombre del host ebriendo */etc/hostname* y ponemos el que consideremos. En este caso **host1**.

Ahora colonamos esta máquina virtual, seleccionando la opción *Clonación enlazada*. Una vez creada tenemos que poner la IP estática y cabmiar el nombre del host. Esto se hace igual que en la primera máquina virtual, solo que en este caso el campo adress del fihero *interfaces* será **192.168.56.12** y lo que aparezca en *hostname* será **host2**.

#### 1.2 Configuración para la conexión ssh mediante clave pública
Se van a describir los pasos para que  **M1** se conecte mediante ssh, sin necesidad de contraseña, con **M2**. 

M1 y M2 son nombres de ejemplo. Para configurar la red tal y como la describe la práctica M1 y M2 debeán ser:
- M1 = host1, M2 = host2
- M1 = host2, M2 = host1
- M1 = maq principal, M2 = host1 y host2 (de forma simultánea).

Para que root no pueda conectarse abrimos */etc/ssh/ssh_config* y descomentamos las líneas (en algunas hay cambios):
```
PermitRootLogin no
AuthorizedKeysFile .ssh/authorized_keys
```
En **M1** emplearemos la siguiente sucesión de comandos:
```bash
$ ssh-keygen -t ed25519 -C "M2"  #En M2 pondremos -C "M1"
$ mv id_ed25519.pub authorized_keys
$ nc 192.168.56.12 9000 < id_ed25519    #IMPORTANTE este comando se lanzará DESPÚES del nc en M2. 
                                        #La dirección IP se pone la que corresponda (en este caso M2 es host2)
$ sudo systemctl restart sshd
$ rm id_ed25519
$ sudo systemctl enable ssh  #Para conectarse a ssh sin necesidad de iniciar sesión
```
Y en **M2**:
```bash
$ mkdir .ssh
$ cd .shh
$ nc -lvnp 9000 > id_as_ed25519     #Si no es la primera clave que se recibe: ... > id
ctrl C  #Para parar nc
$ cat id >> authorized_keys   #Solo si no es la primera clave que se recibe 
$ chmod 600 id_as_ed25519
``` 
### 2. Diseño del script
Al inicio del script tenemos una sección de Robustez. Aquí se comprueba que el usuario se conecta con permisos de administrador y que el número de parámetros es el correcto. 3: *[-a| -s] <fichero_usuarios> <fichero_maquinas>*. Si no es correcto algo de lo anterior se muestra un mensaje de error y se sale del programa.

Luego en la parte principal se hace un bucle que lee el *fichero_máquinas* linea a linea. Dentro de este bucle se copia el *script de la práctica 3* y el *fichero_usuarios* en la máquina que se ha leido. Estas copias se hacen en */tmp* para que se borren cuando se apague la máquina. Se comprueba si la conexión ha dado error. Si esto pasa se muestra un mensaje de error y se continua con la siguiente linea del fichero. Si no, se ejecuta mediante *ssh* el script.

Para la reusabilidad y comprensión del código se han creado las variables *script*, *clave* y *usr*. En las que se almacena el script a copiar, la ruta de la clave pública y el usuario a conectarse respectivamente.