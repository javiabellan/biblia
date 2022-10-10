# Remote administration


## in-band management (OS level) (the usual network channel)

- SSH, sftp, scp (port 22)
- Telnet (port 23)
- Remote desktop
  - VNC (port 5900)
  - RDP (port 3389)
  - FreeNX
  - TeamViewer
- IPSec



## Out-of-band management (BIOS level) (dedicated Ethernet port)

### Advantages

- Reboot, Shutdown, Powering on
- Accesing the bios configuration
- broadcasting of video and receiving of input from remote keyboard and mouse (KVM over IP) (HDBaseT)
- Hardware sensor monitoring (fan speed, temeratures, voltages, chassis intrusion, etc.)
- Hardware inventory
- Hardware failure detection
- Reinstall the operating system
- Configure harware RAID


### Technologies
- IPMI: standard (a bit old)
- Redfish: standard (new, using HTTPS & JSON)
- DRAC: proprietary from Dell
- ILO:  proprietary from HP
- ILOM: proprietary from Sun/Oracle
- IMM:  proprietary from IBM



> ### Security
> Bear in mind that many of these built-in systems have been found to suffer from traditional security holes, such as buffer overruns. It is not wise to assume that setting a password on the OOB interface and using SSL is sufficient protection for such access to your servers. Assume that access to the OOB interface is equivalent to physical access to the machine, and establish additional security measures accordingly. For example, put OOB interfaces on a dedicated protected network. Allow access to this network only via a web proxy with certificate-based authentication, and appropriate authorization.




## Redfish

```bash
curl https://<OOB>/redfish/v1/Systems/System.Embedded.1 --user root:password | jq .Status

# {
#   "Health": "Ok",
#   "HealthRollUp": "Ok",
# }

curl https://<OOB>/redfish/v1/Systems/System.Embedded.1/Thermal --user root:password


curl https://<OOB>/redfish/v1/Systems/System.Embedded.1/Thermal --user root:password

```

https://www.youtube.com/watch?v=9tAXBvuyXJU





## Wake on LAN

- On the server
  1. `ip link` to find informatio about available network cards
    - find the name og the ethernet enterface (eg. `enp0s31f6`)
    - find the mac address (eg. e0:............)
  2. `sudo ethtool enp0s31f6 | grep Wake-on`
    - Check that is on 
- On the client
  1. Find the server mac address: `arp -a`
  2. Wake the server `wakeonlan *mac address*`


## shutdown

```bash
shutdown now
```

## Reboot

```bash
reboot now
```
