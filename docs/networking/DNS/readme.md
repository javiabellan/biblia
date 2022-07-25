# DNS

Under the hood when you run curl:
1. Consult your DNS servers (stored in `/etc/resolv.conf`)
   - `8.8.8.8` is Google DNS server!
2. curl call `getaddrinfo` is a 
3. `getaddrinfo` makes a "DNS request" to 8.8.8.8
4. Finally the IP is obtained


- `dig`,`nslookup`: what's the IP for that domain? (DNS query)
- `whois`: is this domain registered?

## `dig`

`dig` makes DNS queries!

```bash
dig google.com
```

## `nslookup`


## `whois`


## DNS Server

(static and dynamic, as dyndns)
