# Wake on LAN

## On the server

1. `ip link` to find informatio about available network cards
   - find the name og the ethernet enterface (eg. `enp0s31f6`)
   - find the mac address (eg. e0:............)
2. `sudo ethtool enp0s31f6 | grep Wake-on`
   - Check that is on 

## On the client

1. Find the server mac address: `arp -a`
2. Wake the server `wakeonlan *mac address*`