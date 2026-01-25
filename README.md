# Qubes dom0 Script to Update All Templates One‑by‑One
Attention: just work for Debian Templates, do not work for Fedora

## What it does
- Updates every active TemplateVM **one at a time**
- Uses `qvm-run <template> "sudo apt update && sudo apt upgrade"`
- Keeps RAM usage low and avoids the parallel‑template bugs of the default Qubes Update

## Installation

```bash
# In the vault AppVM (replace `user` with your Qubes username)
mkdir -p /home/user/scripts
# copy `updater` directory and `updater.sh` into /home/user/scripts
cd /home/user
tar -cvf scripts.tar scripts/

# In dom0
qvm-run --pass-io vault 'cat "/home/user/scripts.tar"' > /home/user/scripts.tar
tar -xvf /home/user/scripts.tar
chmod +x ~/scripts/*
cd ~/scripts
sudo cp -r updater /bin
now at any place of a terminal dom0 you can type updater, and the script update all templates one by one!

### Doe monero para nos ajudar: (donate XMR)

    87JGuuwXzoMGwQAcSD7cvS7D7iacPpN2f5bVqETbUvCgdEmrPZa12gh5DSiKKRgdU7c5n5x1UvZLj8PQ7AAJSso5CQxgjak
