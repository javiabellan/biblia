## Visible IP on the internet


### Problem 1: Static IP

THere are not enough IPv4 adresses for everyone in the world
so your ISP (Internet Service Provider) probably has given you a **dynamic IP adress** instead of an **static IP adress**.

Solution:

- OPTION 1) You can ask for you ISP to give a **static IP adress**.
- OPTION 2) You can use [noip](https://www.noip.com/es-MX) which track your current ip
  1. Wen you sign up, you pick a free domain name and automaticlly detect your external IP
  2. In order to detect changes of your IOP, you need to install the [noip software]() on the server.



### Problem 2: you router need to allow oustside traffic to get in to your network.

- Open up port 80 on the router (this is port forawrding)
- https://www.youtube.com/watch?v=ZlYyiuBc8Mc

Ojo que el ISP tiene un servidor ACS que controla todos sus routers




## Wake on lan

### Server

2. `ip link` to find informatio about available network cards
   - find the name og the ethernet enterface (eg. `enp0s31f6`)
   - find the mac address (eg. e0:............)
3. `sudo ethtool enp0s31f6 | grep Wake-on`
   - Check that is on 

### Client

wakeonlan *mac address*