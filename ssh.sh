#!/usr/bin/env bash

if [[ -d "$HOME/.ssh" ]]
then
    echo "Directory $HOME/.ssh already exists." 
else
    echo "Error: Directory $HOME/.ssh does not exist, creating.."
    mkdir "$HOME"/.ssh
    chmod 0700 "$HOME"/.ssh
fi

read -p "Run ssh-keygen to generate new RSA4096 key?" -n 1 -r 
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then  
  ssh-keygen -t rsa -b 4096
fi
