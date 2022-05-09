# Hacking & Cibersecurity


## Videos
- [Canal de YouTube primario de S4vitar](https://youtube.com/s4vitar) (En Español)
- [Canal de YouTube secundario de S4vitar](https://www.youtube.com/c/S4viOnLive) (En Español)
- [Twitch de S4vitar](https://twitch.tv/s4vitaar) con directos todos los días a las 21 horas (España peninsular!)
- [S4vitar en Odysee](https://odysee.com/@s4vitar:f) (En Español)
- [Canal de YouTube de CyberMentor](https://www.youtube.com/channel/UC0ArlFuFYMpEewyRBzdLHiw) (En Inglés)
- [Canal de YouTube de Ippsec](https://youtube.com/ippsec) (En Inglés)
- [Canal de YouTube de John Hammond](https://www.youtube.com/user/RootOfTheNull) (En Inglés)


## Plataformas para practicar pentesting
- [HackTheBox](https://hackthebox.eu)
- [VulnHub](https://vulnhub.com)
- [OverTheWire](https://overthewire.org)
- [gf0s Labs](http://labs.gf0s.com)
- [Root-Me](https://root-me.org)
- [HackThisSite](https://hackthissite.org)
- [PicoCTF](https://picoctf.com)
- [DefendTheWeb](https://defendtheweb.net)
- [GoogleGruyere](https://google-gruyere.appspot.com)
- [bWapp](http://www.itsecgames.com)
- [OffensiveSecurity](https://www.offensive-security.com)
- [Crybary](https://www.cybrary.it)
- [HackRocks](https://hackrocks.com)
- [Atenea](https://atenea.ccn-cert.cni.es)
- [HackMyVM](https://hackmyvm.eu)
- [TryHackMe](https://tryhackme.com) warning  Con cuidado!

> - https://www.sothis.tech/capture-the-flag-aprende-hacking-jugando


## Blackarch repos in Arch linux

```bash
curl -O https://blackarch.org/strap.sh                               # Download script
echo 8bfe5a569ba7d3b055077a4e5ceada94119cccef strap.sh | sha1sum -c  # Verify the SHA1 sum
chmod +x strap.sh                                                    # Set execute bit
sudo ./strap.sh                                                      # Run strap.sh
sudo pacman -Syu                                                     # Enable multilib
```