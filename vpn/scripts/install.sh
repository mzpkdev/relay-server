#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

sudo apt update
sudo apt install -y build-essential wget ufw libreadline-dev libssl-dev libncurses-dev zlib1g-dev

wget -O softether.tar.gz "https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/releases/download/v4.44-9807-rtm/softether-vpnserver-v4.44-9807-rtm-2025.04.16-linux-x64-64bit.tar.gz"
tar xzf softether.tar.gz
rm softether.tar.gz
sudo make -C ./vpnserver/

sudo cp $SCRIPT_DIR/../configurations/vpnserver.service  /etc/systemd/system/vpnserver.service
sudo rm -rf /usr/local/vpnserver
sudo mv ./vpnserver /usr/local/vpnserver
sudo chown -R root:root /usr/local/vpnserver/

sudo systemctl daemon-reload
sudo systemctl enable vpnserver
sudo systemctl start vpnserver

echo "Waiting for server to start..."
sleep 5

echo "Opening firewall ports (UFW)..."
sudo ufw allow 443/tcp
sudo ufw allow 992/tcp
sudo ufw allow 5555/tcp
sudo ufw allow 1194/udp
sudo ufw allow 500/udp
sudo ufw allow 4500/udp

set -e
echo
read -rs -p "ADMIN_PASSWORD: " ADMIN_PASSWORD
echo

VPNCMD=/usr/local/vpnserver/vpncmd
$VPNCMD localhost /SERVER /CMD ServerPasswordSet "$ADMIN_PASSWORD"
