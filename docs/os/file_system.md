# File system

## BTRFS
- Recomendado por andres torrubia...
- ...No por prestaciones, lo ha elegido por funcionalidad
- Copias autoamáticas (equvalente a la Time Machine de apple)
- Con [snapper](https://wiki.archlinux.org/title/snapper) que es un sofware que va por encima, tienes facilmente recuperable como estaba tu ordenador hace 1 hora, hace 1 dia, ... te salva la vida cuando borras datos por accidente
- sucesor natural del sistema de archivos EXT4
- menos velocidad de lectura y escritura que EXT4

## ZFS
- Recomendado por profe ASORC carrera informatica
- Sistema por defecto de freeBSD
- Puedes meter y quitar Discos ampliando o reduciendo el espacio (y el logical volume y ZFS se adapta)
- ASi que va bien para tener hot-swapable disks
- Es sinónimo de escalabilidad
- Desventaja: consumo alto de memoria RAM

## EXT4
- Mas comun en linux.
- Tambien es rapido (mas que btrfs)

## XFS
- Tambien es rapido




copy-on-write (COW) mechanism: when you modify a file, the file system won’t overwrite the existing data on the drive. Instead, the newer data is written elsewhere. Once the write operation is over, the file system simply points to the newer data blocks.
  - Ventaja: asegurar la integridad de los archivos en caso de corte eléctrico. 
  - Desventaja: una alta fragmentación, 

journaling (mejora la integridad del sistema de archivos), por lo que no deberías tener pérdida de datos en caso de corte de alimentación



          Asegurar integridad        How to               Scalable for
          en caso de corte corr      RAID?                hot-swap disks
------------------------------------------------------------------------
EXT4       journaling              need to format             no
BTRFS      copy-on-write
ZFS       copy-on-write                                    pool of vdevs



vdevs == Virtual DEVice. A pool is made up of vdevs. A vdev is made up of physical devices.
Let's say you have 12 physical disks. You might have a pool consisting of 6 mirrors. Each two disk mirror is a vdev. So your pool has 6 vdevs.


> ### Optimizacion trick 1: Desactivar el atributo atime
>  El atributo atime (access time) es recopilado y actualizado cada vez que el usuario lee o modifica un determinado archivo. En total, se recogen 3 atributos:
>
> - Access: la última vez que el archivo fue leído
> - Modify: la última vez que el archivo fue modificado (su contenido)
> - Change: la última vez que los meta-datos del archivo fueron modificados (permisos, nombre, propietario, etc)
>
> Mediante `noatime` desactivamos esta funcionalidad y ganamos algo de velocidad al leer y escribira archivos.

https://markmcb.com/2020/01/07/five-years-of-btrfs/
https://carfax.org.uk/btrfs-usage/
https://www.linuxjournal.com/content/hot-swappable-filesystems-smooth-btrfs
https://www.salvagedata.com/btrfs-zfs-xfs-ext4-how-are-they-different/

