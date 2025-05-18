#!/bin/bash
set -e

VIRTUAL_HUB="main"
BRIDGE_INTERFACE="eth0"

read -rs -p "Password: " ADMIN_PASSWORD
echo


echo "Setting up server..."
./vpnserver/vpncmd localhost /SERVER /CMD ServerPasswordSet "$ADMIN_PASSWORD"

echo "Creating virtual hub..."
./vpnserver/vpncmd localhost /SERVER /CMD HubCreate $VIRTUAL_HUB
./vpnserver/vpncmd localhost /SERVER /HUB:$VIRTUAL_HUB /CMD PasswordSet "$ADMIN_PASSWORD"

echo "Setting up \"$BRIDGE_INTERFACE\" bridge..."
./vpnserver/vpncmd localhost /SERVER /CMD BridgeCreate $VIRTUAL_HUB
./vpnserver/vpncmd localhost /SERVER /CMD BridgeAdd $VIRTUAL_HUB $BRIDGE_INTERFACE


echo "Your \"$VIRTUAL_HUB\" virtual hub is ready!"
