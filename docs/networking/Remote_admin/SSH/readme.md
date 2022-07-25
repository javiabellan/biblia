# SSH


## En el servidor:

```bash
sudo systemctl status sshd  # Ver si esta encendido
sudo systemctl start sshd   # Encender
sudo systemctl stop sshd    # Apagar
sudo systemctl enable sshd  # Al arrancar por defecto: encendido
sudo systemctl disable sshd # Al arrancar por defecto: apagado
```


## Common flags

- `ssh javi@192.168.0.1 -L 8888:localhost:8888`: Redirect port
- `ssh javi@192.168.0.1 -p 2222`: Conct over a specific port (Defualt port is 22)


## En el cliente. Conectar y redirigir puerto 8888 (juypter)

```bash
ssh javi@192.168.0.103 -L 8888:localhost:8888  # Conectar
jupyter notebook --no-browser                  # Abrir Jupyter
exit                                           # Desconectar o CTL+
```


## Key generation
```bash
# Gerenar claves publica y privada
ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519

# Llevar la clave publica al cliente
cat .ssh/id_ed25519.pub | ssh foobar@remote 'cat >> ~/.ssh/authorized_keys'
```

- `-o`: Save the private-key using the new OpenSSH format rather than the PEM format. Actually, this option is implied when you specify the key type as ed25519.
- `-a`: It’s the numbers of KDF (Key Derivation Function) rounds. Higher numbers result in slower passphrase verification, increasing the resistance to brute-force password cracking should the private-key be stolen.
- `-t`: Specifies the type of key to create, in our case the Ed25519.
- `-f`: Specify the filename of the generated key file. If you want it to be discovered automatically by the SSH agent, it must be stored in the default `.ssh` directory within your home directory.



## Dejar un programa largo en ejecucion

### Simple option (`nohup`)
```bash
nohup COMMAND        # Run a command immune to hangups
nohup COMMAND > FILE # Ademas puede guardar su salida estandar en un fichero
```

### Session programs option (`screen` or `tmux`)

Son programas que mantienen la sesion activa.

1. `ssh` log in into your remote machine. 
2. `tmux` or `screen`
3. Start the long process you want.
4. Leave/detach `tmux` or `screen` session, but leave your processes running.
   - Ctrl+A then Ctrl+D (para salir de screen)
   - Ctrl+B then Ctrl+D (para salir de tmux)
5. `exit` ssh

...One eternity later...

1. `ssh` log in again into your remote machine. 
2. Return back to see the output of your process.
   - `screen -r`: "resume" your screen session
   - `tmux a`: "atach" to the last tmux session
