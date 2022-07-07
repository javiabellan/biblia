# Processes



## Basics

- A process is an instance of a program/command.
- Each process has a unique PID (5 digits number).
- Every process has a parent (the one who create the process).
- When you close/kill the parent pocess you kill all the child processes

## How to start a process

- Manually (run command in terminal)
- At boot time (services or daemons)
- Scheduled ( crontab )
- From anothter process (child process)


## Process states

Processes can have several states:

- Running (R)
- Uninterruptible Sleep (D)
- Interruptable Sleep (S)
- Stopped (T)
- Zombie (Z)


- Foreground Process : (default mode) receives input from the keyboard, and sends output to the screen


## Process priorities

https://www.tecmint.com/set-linux-process-priority-using-nice-and-renice-commands/




## Tracking ongoing processes (`ps`)

- `ps` (Process status) can be used to see/list all the running processes.
- `ps -f` (full) For more information variables
- `ps 19` For single-process information, ps along with process id is used  


UID:   User ID that this process belongs to (the person running it)
PID:   Process ID
PPID:  Parent process ID (the ID of the process that started it)
C:     CPU utilization of process
STIME: Process start time
TTY:   Terminal type associated with the process
TIME:  CPU time is taken by the process
CMD:   The command that started this process

  UID   PID  PPID   C STIME   TTY           TIME CMD
    0     1     0   0  5may22 ??        98:12.93 /sbin/launchd
    0    69     1   0  5may22 ??         4:07.06 /usr/sbin/syslogd


## Basics commands

- `disown -a` Idepedizar tareas hijas (que probablemente estan en segundo plano)

```bash
CTRL + l   # Clean terminal
CTRL + c   # Interrumpir programa (SIGINT)
CTRL + \   # Salir programa (SIGQUIT)
CTRL + z   # Pausar programa que se puede reunaudar (SIGSTOP)
jobs        # See all the jobs that are running or suspended.
my_command  # Foreground process.
my_command &  # When you append " &"  it becomes a "background process".
my_command_2 && my_command_2 # Do my_command_2 only if my_command_2 was success
fg          # Bring the job to the foreground.
bg          # Send the job to the background.
stop {PID} or Ctrl + z          # Suspend the job.
kill {PID} or Ctrl + c          # Terminate the job.
```



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





## Proc dir

It has PID 28, so we check the /proc




## Inter Process Comunication (IPC)

- Shared files
- Shared memory (with semaphores)
- Pipes
  - unnamed pipes `|`
  - named pipes `mkfifo my_pipe`
- Message queues
- Sockets
  - Unix domain sockets
  - TCP/IP sockets
- Signals
- semaphores


https://opensource.com/article/20/1/inter-process-communication-linux

https://opensource.com/downloads/guide-inter-process-communication-linux


