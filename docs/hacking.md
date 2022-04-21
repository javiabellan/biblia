# Hacking

## BLACKARCH repos in ARCH
```bash
curl -O https://blackarch.org/strap.sh                               # Download script
echo 8bfe5a569ba7d3b055077a4e5ceada94119cccef strap.sh | sha1sum -c  # Verify the SHA1 sum
chmod +x strap.sh                                                    # Set execute bit
sudo ./strap.sh                                                      # Run strap.sh
sudo pacman -Syu                                                     # Enable multilib
```