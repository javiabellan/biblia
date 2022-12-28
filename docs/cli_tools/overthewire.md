# Over the wire

## Bandit

```bash
ssh bandit0@bandit.labs.overthewire.org -p 2220
```

| Level    | Entry SSH password               | Answer command                                               |
|----------|----------------------------------|--------------------------------------------------------------|
| bandit0  | bandit0                          | `cat readme`                                                 |
| bandit1  | NH2SXQwcBdpmTEzi3bvBHMM9H66vVXjL | `cat ./-`                                                    |
| bandit2  | rRGizSaX8Mk1RTb1CNQoXTcYZWU6lgzi | `cat spaces\ in\ this\ filename`                             |
| bandit3  | aBZ0W5EmUfAf7kHTQeOwd8bauFJ2lAiG | `cat inhere/.hidden`                                         |
| bandit4  | 2EW7BBsr6aMMoJ2HjW067dm8EgX26xNe | `file inhere/*` o `ls inhere/* | xargs file`                 |
| bandit5  | lrIWWI6bB37kxfiCQZqUdOIYfr6eEeqR | `find . -readable ! -executable -size 1033c`                 |
| bandit6  | P4L4vucdmLnm8I7Vl7jG1ApGSfjYKqJU | `find / -user bandit7 -group bandit6 -size 33c 2> /dev/null` |
| bandit7  | z7WtoNQU2XfjmMtWA8u5rN4vzqu4v99S | `grep millionth data.txt`                                    |
| bandit8  | TESKZC0XvTetK0S9xNwm25STk5iWrBvP | `sort data.txt | uniq -u`                                    |
| bandit9  | EN632PlfYiZbn3PhVK3XOGSlNInNE00t | `strings data.txt | grep =`                                  |
| bandit10 | G7w8LIi6J3kTb8A7j9LgrywtEUlyyp6s | `base64 -d data.txt`                                         |
| bandit11 | 6zPeziLdR2RKNdNYFNb6nVCKzphlXHBM | `cat data.txt | tr a-zA-Z n-za-mN-ZA-M`                      |
| bandit12 | JVNBBFSmZwKKOP0XbFXOoW8chDz5yVRv | `cat data.txt | xxd -r | gzip -d - | .....`                  |
| bandit13 | wbWdlBxEir4CaE8LaPhauuOo6pwRmrDw | `ssh -i sshkey.private bandit14@localhost -p 2220`           |
| bandit14 | fGrHPx402xGC7U7rXKDaxiWFTOiF0ENq | `telnet localhost 30000` then enter pass.                    |
|          |                                  | Or `cat /etc/bandit_pass/bandit14 |  nc localhost 30000`     |
| bandit15 | jN2kgmIXJ6fShzhT2avhotn4Zcka6tnt | `openssl s_client -connect localhost:30001` then enter pass  | 
| bandit16 | JQttfApK4SeyHwDlI9SXGR50qclOAil1 | `nmap --open -T5 -v -n -p31000-32000 127.0.0.1`              |
|          |                                  | `openssl s_client -connect localhost:31790`                  |
|          |                                  | e introducir contenido de /etc/bandit_pass/bandit16          |
| bandit17 | VwOSWtCA7lRKkTfbr2IDh6awj9RNZM5e | `diff passwords.new  passwords.old`                          |
| bandit18 | hga5tuuCLF6fFzUpnagiMN8ssu9LFrdg | `ssh bandit18@bandit.labs.overthewire.org -p 2220 cat readme`|
| bandit19 | awhqfNnAbc1naukrpqDYcF95h7HoMTrC | `./bandit20-do cat /etc/bandit_pass/bandit20`                |
| bandit20 | VxCazJaVykI6W36BkBU0mJTCM8rR95XT | window 1: listen on `nc -l -p 5757`                          |
|          |                                  | window 2: `./suconnect 5757`                                 |
|          |                                  | window 1: paste currnt level password on `nc`                |
| bandit21 | NvEJF7oVjkddltPSrdKEFOllh9V1IBcq | `cat cronjob_bandit22` `cat /usr/bin/cronjob_bandit22.sh`    |
| bandit22 | WdDozAdTM2z9DiFEQ2mGlwngMfj4EZff | `echo I am user bandit23 | md5sum` 
| bandir23 | QYw0Y2aiA672PsMmh9puTQuhoz8SyR2G | 