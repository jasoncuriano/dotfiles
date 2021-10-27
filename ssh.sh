#!/usr/bin/env bash

[[ ! -d '"$HOME"/.ssh' ]] || mkdir "$HOME"/.ssh && chmod 0700 "$HOME"/.ssh || echo "Created dir"$HOME"/.ssh"

read -p "Generate SSH Key?" -n 1 -r 
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then  
  ssh-keygen -t rsa -b 4096
fi
