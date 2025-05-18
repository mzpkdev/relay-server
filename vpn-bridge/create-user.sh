#!/bin/bash
set -e

read -rs -p "Hub: " VIRTUAL_HUB
read -rs -p "User: " USER_NAME
read -rs -p "Password: " USER_PASSWORD


./vpncmd localhost /SERVER /HUB:"$VIRTUAL_HUB" /CMD UserCreate "$USER_NAME"
./vpncmd localhost /SERVER /HUB:"$VIRTUAL_HUB" /CMD UserPasswordSet "$USER_NAME" "$USER_PASSWORD"


echo "An user \"$USER_NAME\" have been successfully created!"
