#!/bin/bash

set -e
echo
read -rs -p "ADMIN_PASSWORD: " ADMIN_PASSWORD
echo
read -rs -p "HUB_NAME: " HUB_NAME
echo
read -rs -p "ETH_DEVICE: " ETH_DEVICE
echo

VPNCMD=/usr/local/vpnserver/vpncmd
{
  if [ -n "$ADMIN_PASSWORD" ]; then
    echo "$ADMIN_PASSWORD"
    sleep 1
  fi

  echo "BridgeCreate /DEVICE:$ETH_DEVICE /TAP:yes"

  # Select the hub
  echo "$HUB_NAME"
  sleep 1

  # Exit
  echo "exit"
} | $VPNCMD localhost /SERVER /CMD
