#!/bin/bash

set -e
echo
read -rs -p "ADMIN_PASSWORD: " ADMIN_PASSWORD
echo
read -rs -p "HUB_NAME: " HUB_NAME
echo
read -rs -p "HUB_PASSWORD: " HUB_PASSWORD
echo

VPNCMD=/usr/local/vpnserver/vpncmd
$VPNCMD localhost /SERVER /CMD HubCreate "$HUB_NAME"
{
  # If admin password is set
  if [ -n "$ADMIN_PASSWORD" ]; then
    echo "$ADMIN_PASSWORD"
    sleep 1
  fi

  # Select the hub
  echo "Hub $HUB_NAME"
  sleep 1

  # Set the hub password
  echo "SetHubPassword"
  echo "$HUB_PASSWORD"
  sleep 1

  # Confirm the password
  echo "$HUB_PASSWORD"
  sleep 1

  # Exit
  echo "exit"
} | $VPNCMD localhost /SERVER /CMD
