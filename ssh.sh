#!/usr/bin/env bash

mkdir "$HOME"/.ssh
chmod 0700 "$HOME"/.ssh

read -p "Generate SSH Key?" -n 1 -r 
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then  
  ssh-keygen -t rsa -b 4096
fi
