#!/usr/bin/env bash

wait_for_space() {
    read -n1 -r -p "Press space to continue..." key
    if [ "$key" = '' ]; then
        echo "Continuing..."
    else
        echo "Exiting"
        exit 1
    fi
}
wait_for_space

declare -a ListOfScripts=(
    "homebrew.sh"
    "macos.sh"
    "git.sh"
    "ssh.sh"
    "extras.sh"
    )
# Iterate the string array using for loop
for script in "${ListOfScripts[@]}"; do
   echo "Making $script executable"
   chmod +x "${script}"
done

for script in "${ListOfScripts[@]}"; do
   echo "Running $script"
   sh "${script}"
done
