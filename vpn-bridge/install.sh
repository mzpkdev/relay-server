#!/bin/bash

echo "Installing dependencies..."
sudo apt update
sudo apt install -y build-essential libreadline-dev libssl-dev libncurses-dev zlib1g-dev ufw wget

echo "Downloading SoftEther VPN Server..."
wget -O softether.tar.gz "https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/releases/download/v4.44-9807-rtm/softether-vpnserver-v4.44-9807-rtm-2025.04.16-linux-x64-64bit.tar.gz"
tar xzf softether.tar.gz
cd vpnserver || exit

echo "Compiling SoftEther VPN Server..."
yes 1 | sudo make

echo "Starting SoftEther VPN Server..."
sudo ./vpnserver start

echo "Waiting for server to start..."
sleep 5

echo "Opening firewall ports (UFW)..."
sudo ufw allow 443/tcp
sudo ufw allow 5555/tcp
sudo ufw allow 992/tcp
