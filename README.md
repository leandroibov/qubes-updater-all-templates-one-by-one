# Qubes dom0 Script to Update All Templates One‑by‑One

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
