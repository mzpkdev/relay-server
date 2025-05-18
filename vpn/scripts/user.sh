#!/bin/bash

set -e
echo
read -rs -p "HUB_NAME" HUB_NAME
echo
read -rs -p "USER_NAME" USER_NAME
echo
read -rs -p "USER_PASSWORD" USER_PASSWORD
echo

VPNCMD=/usr/local/vpnserver/vpncmd
$VPNCMD localhost /SERVER /HUB:"$HUB_NAME" /CMD UserCreate "$USER_NAME"
$VPNCMD localhost /SERVER /HUB:"$HUB_NAME" /CMD UserPasswordSet "$USER_NAME" "$USER_PASSWORD"
