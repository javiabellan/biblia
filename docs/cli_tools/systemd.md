# SystemD

Manage "units" in a dependency graph

- Se puede definir que un servicio empiece antes que otro


| Unit type | Extension  | Description          |
|-----------|------------|----------------------|
| service   | .service   | A system service     |
| socket    | .socket    | An IPC socket        |
| device    | .device    | A device file        |
| mount     | .mount     | A mount point in the filesystem |
| automount | .automount | An automount point in the filesystem |
| swap      | .swap      | A swap device or file |
| target    | .target    | A group of units      |
| path      | .path      | A path (file or directory) monitored by systemd |
| timer     | .timer     | A timer controlled by systemd |
| snapshot  | .snapshot  | A saved state of systemd      |
| slice     | .slice     | A group of units, hierarchically organized in a tree, for managing processes |
| scope     | .scope     | A scope unit for managing externally created processes |



## Where store the units ?

| Directory             | Description                          |
|-----------------------|--------------------------------------|
| `/etc/systemd/system` | Administrator-configured units       |
| `/lib/systemd/system` | Package-installed units              |
| `/run/systemd/system` | Non-persistent runtime modifications |


## Service units

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

si quieres que un servicio que termina (script) se ejecute perciocamente (con la sisntaxis de CRON) puedes añadir un .timer unit **con el mismo nombre que el .service**

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



## Logging

Systemd tiene su propio log (journal)


## Permission

No se recomienda que el proprieerio del servicio sea el usurario root, para no tocar cosas que no debe.


## Todo se ejecuta con cgroups




## Reference
- https://www.youtube.com/watch?v=r_haLf5mWhE
- https://www.softprayog.in/tutorials/systemd-system-and-service-manager-in-linux
- https://alesnosek.com/blog/2016/12/04/controlling-a-multi-service-application-with-systemd