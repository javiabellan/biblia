# SystemD




| Unit type    | Description          |
|--------------|----------------------|
| `.service`   | A system service     |
| `.socket`    | An IPC socket        |
| `.device`    | A device file        |
| `.mount`     | A mount point in the filesystem |
| `.automount` | An automount point in the filesystem |
| `.swap`      | A swap device or file |
| `.target`    | A group of units. Equivalent of trditional init’s run levels      |
| `.path`      | A path (file or directory) monitored by systemd |
| `.timer`     | A timer controlled by systemd |
| `.snapshot`  | A saved state of systemd      |
| `.slice`     | A group of units, hierarchically organized in a tree, for managing processes |
| `.scope`     | A scope unit for managing externally created processes |



## Where store the units ?

| Directory             | Description                          |                              |
|-----------------------|--------------------------------------|------------------------------|
| `/etc/systemd/system` | Administrator-configured units       | Your local units can go here |
| `/lib/systemd/system` | Package-installed units              | you shouldn’t modify them    |
| `/run/systemd/system` | Non-persistent runtime modifications | An area for transient units  |

> If there’s any conflict, the files in `/etc` have the highest priority






 
 

## `systemctl`: manage systemd


```bash
systemctl                           # Eqivalent to systemctl list-units
systemctl list-units                # shows LOADED and ACTIVE services, sockets, targets, mounts, and devices.
systemctl list-units --type=service # shows LOADED and ACTIVE services.
systemctl list-unit-files           # See all unit files, regardless of whether or not they’re active
systemctl list-unit-files --type=service # See all services files, regardless of whether or not they’re active.


systemctl status cups.service #  
systemctl status cups         # The same (systemctl can usually accept a unit name without a unit-type suffix)

```


| `systemctl` Subcommand            | Function                                           |
|-----------------------------------|----------------------------------------------------|
| **list-units**                    | Shows LOADED services, sockets, targets, mounts, and devices. |
| **list-units** --type=service     |                                                    |
| **list-units** [ *pattern* ]      |                                                    |
| **list-unit-files** --type=service|                                                    |
| **list-unit-files** [ *pattern* ] | Shows installed units; optionally matching pattern |
| **enable** *unit*                 | Start unit **at boot**                             |
| **disable** *unit*                | Not start unit **at boot**                         |
| **start** *unit*                  | Start unit **immediately**                         |
| **stop** *unit*                   | Stop unit **immediately**                          |
| **restart** *unit*                | Restarts unit **immediately**                      |
| **status** *unit*                 | Shows unit’s status and recent log entries         |
| **kill** pattern                  | Sends a signal to units matching pattern           |
| **reboot**                        | Reboots the computer                               |
| **daemon-reload**                 | Reloads unit files and systemd configuration       |

> *units* can be full name (`cups.service`) or sometimes without a unit-type suffix can be accepted (`cups`)



## Unit statuses `systemctl list-units`

| LOAD        | ACTIVE     | SUB       | Meaning |
|-------------|------------|-----------|-------------|
| `not-found` | `inactive` | `dead`    | 
| `loaded`    | `inactive` | `dead`    | 
| `loaded`    | `active`   | `exited`  |
| `loaded`    | `active`   | `running` |

## Unit file statuses `systemctl list-unit-files`

| State      | Meaning                                                     |
|------------|-------------------------------------------------------------|
| `bad`      | Some kind of problem within systemd; usually a bad unit file|
| `disabled` | Present, but not configured to start autonomously           |
| `enabled`  | Installed and runnable; will start autonomously             |
| `indirect` | Disabled, but has peers in Also clauses that may be enabled |
| `linked`   | Unit file available through a symlink                       |
| `masked`   | Banished from the systemd world from a logical perspective  |
man 





## `.target` units (dependencies)

Manage "units" in a dependency graph

- Se puede definir que un servicio empiece antes que otro


| SystemV Run level | SystemD Target      | Description
|-------------------|---------------------|-------------------------------------
| Run level 0       | `poweroff.target`   | System halt
| emergency         | `emergency.target`  | Bare-bones shell for system recovery
| Run level 1       | `rescue.target`     | Single-user mode
| Run level 2       | `multi-user.target` | Multiuser mode (command line)
| Run level 3       | `multi-user.target` | Multiuser mode with networking
| Run level 4       | `multi-user.target` | Not normally used by init
| Run level 5       | `graphical.target`  | Multiuser mode with networking and GUI
| Run level 6       | `reboot.target`     | System reboot


```bash

systemctl list-units --type=target            # To see all the system’s available targets
systemctl list-dependencies graphical.target  # Explore dependency order of some unit

# To change the system’s current operating mode, use the systemctl isolate command:
sudo systemctl isolate multi-user.target

# To see the target the system boots into by default, run the get-default subcommand:
systemctl get-default

# Most Linux distributions boot to graphical.target by default,
# which isn’t appropriate for servers that don’t need a GUI.
# But that’s easily changed:
sudo systemctl set-default multi-user.target
```

Under traditional init, you use the `telinit` command to change run levels once the system is booted.


> More info on `man systemd.target`

## `.service` units

1. specifies the location of the executable file for the daemon
2. tells systemd how to start and stop the service
3. and identifies any other units that the service depends on


1. Create a service (`my_custom.service`) an place it in `/etc/systemd/system`
2. Refresh systemD avaialblae services `sudo systemctl daemon-reload`
3. Start the service `sudo systemctl start my_custom.service`
4. OPTINAL: Enable on booting `sudo systemctl start my_custom.service`
5. See output (logging) of a **u**nit `journalctl -u triton.service`
   - `journalctl -u triton.service -f` To **f**ollow the latest changes in real time



Example of `rsync.service`:
```bash
[Unit]
Description=fast remote file copy program daemon
ConditionPathExists=/etc/rsyncd.conf

[Service]
ExecStart=/usr/bin/rsync --daemon --no-detach

[Install] WantedBy=multi-user.target
```

```bash
[Unit]
Description=The SAMPLE server
After=syslog.target network.target remote-fs.target nss-lookup.target

[Service] # Esta seccion solo esta para units de tipo .service
Type=forking
PIDFile=/run/sample.pid
ExecStartPre=/usr/sbin/sample -t
ExecStart=/usr/sbin/sample
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true

[Install]   # Esta seccion es la encargada de poner la unit en el dependency tree
WantedBy=app.service # This unit should start when app.service is starting
```

## Servicio que se levanta solo, si se cae

dentro de `[Service]` si especificamos `Restart=on-failure` conseguimos esta funcionalidad. Ademas podemos definir `RestartSec=5s` para que se levante a los 5 segundos de haberse caido.

```bash
[Unit]
Description=Triton

[Service]
ExecStart=/home/javi/wesog/models/5_Triton_server/start.sh
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
```

> https://www.redhat.com/sysadmin/systemd-automate-recovery
> More info on `man systemd.service`








## .service + .socket

Cuando el servicio esta inactivo (se esta iniciando, se cae, o se reinicia con una nueva version), las peticiones que recibe durante ese tiempo no se pierden sino que se meantienen en su socket, hasta que el servicio este operativo de nuevo. A esto se le conoce como Socket activation.

Asi que las servidos no deben crear sus sockets manuelamente, sino usar el socket que le da systemD.

Un servicio se crea con socket ativation crando **con el mismo nombre** `myservwithsocket.service` y `myservwithsocket.socket`


`myservwithsocket.service`:

```bash
[Unit]
Description=My service with socket activation

[Service]
ExecStart=/path/to/exec
```

`myservwithsocket.socket`:

```bash
[Socket]
ListenStream=8000
BindIPv6Only=both

[Install]
WantedBy=sockets.target # After sockets is availabe
```









## .service + .timer

si quieres que un servicio que termina (script) se ejecute periodicamente (con la sisntaxis de CRON) puedes añadir un .timer unit **con el mismo nombre que el .service**

`date.timer`:

```bash
[Unit]
Description=Run date.service every 10 minutes

[Timer]
OnCalendar=*:0/10
```

| Timer type        | Description                                         |
|-------------------|-----------------------------------------------------|
| OnCalendar        | A specific day and time.                            |
| OnBootSec         | Seconds after system boot time.                     |
| OnStartupSec      | Seconds after systemd was started.                  |
| OnActiveSec       | Seconds after the timer itself was activated.       |
| OnUnitActiveSec   | Seconds after the specified unit was last active.   |
| OnUnitInactiveSec | Seconds after the specified unit was last inactive. |


OnBootSec=2h 1m
OnStartupSec=1week 2days 3hours
OnActiveSec=1hr20m30sec10msec

```bash
# Ver los timers actuales
systemctl list-timers

#  archlinux-keyring-wkd-sync.timer | Refresh existing PGP keys of archlinux-keyring regularly
#  fstrim.timer                     | Discard unused blocks once a week
#  shadow.timer                     | Daily verification of password and group files
#  systemd-tmpfiles-clean.timer     | Daily Cleanup of Temporary Directories
```

https://wiki.archlinux.org/title/Systemd/Timers




## CRON Syntax

```
┌───────────── minute (0 - 59)
│ ┌───────────── hour (0 - 23)
│ │ ┌───────────── day of the month (1 - 31)
│ │ │ ┌───────────── month (1 - 12)
│ │ │ │ ┌───────────── day of the week (0=Sun - 6=Sat)
│ │ │ │ │                                   
* * * * *
```

| minute | hour  | day of the month | month | day of the week       |
|--------|-------|------------------|-------|-----------------------|
| 0..59  | 0..23 | 1..31            | 1..12 | 0..6 (Sun,Mon,..,Sat) |

- `*` means “every” 
- `,` value list separator
- `-` Range of values.
- `/` step values. Eg. `/5 * * * *` means every 5 minutes. 

### Examples:

- `* * * * *`: Every minute
- `*/5 * * * *`: Every 5 minutes
  - `*/5 8-16 * * 1-5`: Every 5 minutes from 8:00 to 16:00, from Mon to Fri.
- `0 * * * *`: Every hour (at minute 0)
- `0 0 * * *`: Every day (at 00:00)
- `0 0 * * 0`: Every week (at 00:00 on Sunday)
- `0 0 1 * *`: Mothly (at 00:00 on day 1)
- `0 0 1 1 *`: Yearly (at 00:00 on day 1 of January)

Check [crontab guru](https://crontab.guru) to come up with the cron syntax for your schedule.






## Logging

Systemd tiene su propio log (journal)


## Permission

No se recomienda que el proprieerio del servicio sea el usurario root, para no tocar cosas que no debe.


## Todo se ejecuta con cgroups




## Reference
- https://www.youtube.com/watch?v=r_haLf5mWhE
- https://www.softprayog.in/tutorials/systemd-system-and-service-manager-in-linux
- https://alesnosek.com/blog/2016/12/04/controlling-a-multi-service-application-with-systemd







====================



# Booting

|   |                                    | OLD (GRUB + SystemV)           | NEW (UEFI + SystemD)   |
|---|------------------------------------|--------------------------------|------------------------|
|   | Power On                           |                                |                        |
| 1 | Load BIOS/UEFI from NVRAM          | Load **BIOS** firmware from ROM| UEFI                   |
|   | Probe for hardware                 |                                |                        |
|   | Select boot device (disk, net,...) | MBR (Master Boot Record)       | GPT (GUID Partition Table) |
|   | Identify EFI system partition      |                                |                        |
|   | Load boot loader                   | GRUB                           | systemd-bootctl        |
|   | Determine which kernel to boot     |                                |                        |
|   | Load kernel                        |                                |                        |
|   | Instantiate kernel data structures |                                |                        |
|   | Start init/systemd as PID 1        |                                |                        |
|   | Execute startup scripts            | Runlevel programs `/etc/rc.d/` | SystemD uses "targets" |
|   | Running system                     |                                |                        |


1. **BIOS** (Basic Input/Output System)
2. **MBR** (Master Boot Record)
3. **GRUB** (Grand Unified Bootloader)
4. **Kernel**




### Process managers

- launchd (OS X)
- Upstart (Ubuntu) (antiguo y tradicional sistema init)
- SystemV (SysV) (antiguo y tradicional sistema init)
- SystemD (el mas usado (y odiado) en la acutailidad
- Systemd-shim (alternativa moderna)
- In BSD, the init binary doesn't do much regarding startup, basically just executes /etc/rc; it's shell scripts all the way afterwards.


|         | SystemV                               | SystemD                                                 |
|---------|---------------------------------------|---------------------------------------------------------|
| Distros | Gentoo, Slackware, Linux from Scratch | ArchLinux, AWS, Red Hat, CentOS, Fedora, Debian, Ubuntu |
| Restart |  `/etc/init.d/sshd start`             | `systemctl restart sshd`                                |
| Enable  |                                       | `systemctl enable NetworkManager.service`               |
|         |                                       | `systemctl enable wpa_supplicant`                       |


https://papers.freebsd.org/2018/bsdcan/rice-the_tragedy_of_systemd/


FreeBSD ventajas: init system, LLVM, documentation, ZFS, dtrace


### Boot time (System V)

1. **BIOS** (Basic Input/Output System)
2. **MBR** (Master Boot Record)
3. **GRUB** (Grand Unified Bootloader)
4. **Kernel**
	- Mounts the root file system as specified in the “root=” in grub.conf
	- Kernel executes the `/sbin/init` program
5. **Init** (PID=1)
	- Es el primer proceso que se inicia durante el arranque del sistema por parte del kernel.
	- Se ejecutará en segundo plano continuamente hasta que el sistema se apague.
	- Lee el archivo `/etc/inittab` para decidir el nivel de ejecución de Linux.
	- luego inicia todos los demás procesos.
	- Run level 0 –> halt (CAUTION: never set initdefault to this)
	- Run level 1 –> Single user mode
	- Run level 2 –> Multiuser, without NFS (The same as 3, if you do not have networking)
	- Run level 3 –> Full multiuser mode (common initdefault)
	- Run level 4 –> unused
	- Run level 5 –> X11 (common initdefault)
	- Run level 6 –> reboot (CAUTION: never set initdefault to this)
	- Ejemplo de inittab: `id:3:initdefault:`
6. **Runlevel programs**
Depending on your default init level setting, the system will execute the programs from one of the following directories.
	- Run level 0 –> `/etc/rc.d/rc0.d/`
	- Run level 1 –> `/etc/rc.d/rc1.d/`
	- Run level 2 –> `/etc/rc.d/rc2.d/`
	- Run level 3 –> `/etc/rc.d/rc3.d/`
	- Run level 4 –> `/etc/rc.d/rc4.d/`
	- Run level 5 –> `/etc/rc.d/rc5.d/`
	- Run level 6 –> `/etc/rc.d/rc6.d/`
  - Programs starts with S are used during startup. S for startup.
  - Programs starts with K are used during shutdown. K for kill.


Ejemplo de un script que:

```bash
#      ┌───────────── rc3: Será ejecutado en el Run level 3
#      │   ┌───────── S:   Será ejecutado al encenderse
#      │   │ ┌─────── 98:  Momento de ejecución, a menor número, antes se ejecuta
#      │   │ │  
/etc/rc3.d/S98miscript

# Puede ser un enlace simbolico a un script que esté en otro sitio
ln -s  /etc/init.d/mi_script /etc/rc3.d/S98miscript
```


![](../img/linux-boot-process.png)

Reference: https://www.thegeekstuff.com/2011/02/linux-boot-process/








### Boot time (SystemD)

SystemD uses "targets" instead of runlevels.

By default, there are two main targets:
- multi-user.target: analogous to runlevel 3
- graphical.target: analogous to runlevel 5




systemd not only manages processes in parallel, but also manages:
- network connections (networkd)
- kernel log entries (journald)
- and logins (logind).



```bash
# To view current default target, run:
systemctl get-default

# To set a default target, run:
#systemctl set-default TARGET.target

# Establezca el nivel de ejecución actual en 3 (comenzar en modo de línea de comando)
systemctl set-default multi-user.target
 
# Establezca el nivel de ejecución actual en 5 (encendido para la interfaz gráfica)
systemctl set-default graphical.target
```


## systemD haters

you may find it informative to peruse the Arguments against systemd section at without-systemd.org


