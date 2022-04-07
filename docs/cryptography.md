# Cryptography


## Hash function: MD5, SHA-1, SHA-256
- Non invertible
- Collision redundant

```bash
md5 myFile.txt
shasum myFile.txt
sha1sum myFile.txt
```


## Symetric cryptography (1 key)

1. keygen() -> key
2. encrypt(plaintext, key) -> ciphertext
3. decrypt(ciphertext, key) -> plaintext

```bash
# AES
openssl aes-256-cbc -salt -in aaa.py -out aaa.py.enc # Encription
openssl aes-256-cbc -d -in aaa.py.ec -out aaa2.py    # Decryption
```


## Asymmetric cryptography (public & private keys)


1. keygen() -> public key, private key
   - La clave pública solo se usa para cifrar (la usará el otro)
   - La clave privada solo se usa para descifrar (la usaré yo)
2. encrypt(plaintext, public key) -> ciphertext
3. decrypt(ciphertext, private key) -> plaintext

En general todo aque que quiera que LE LLEGEN los mensajes privados, debe comunicar su public key.
Si AMBOS extremos comunican su public key, la comunicación será cifrada

Ejemplos:
- RSA
- ED25519: more secure

```bash
# RSA
```


## Hybrid cryptography

Presmisa:
- La Symetric cryptography es rápida
- La Asymmetric cryptography es lenta

Entoces:
Usar la Asymmetric cryptography SOLO PARA INTERCAMBIAR LA CLAVE SIMETRICA. Asi ya se tiene una Symetric cryptography que es más rápida que la Asymmetric




## Asymmetric cryptography for signing

1. keygen() -> public key, private key
2. sign(message, private key) -> signature
3. verify(message, signature, public key) -> bool  (whether or not the signature is valid)

