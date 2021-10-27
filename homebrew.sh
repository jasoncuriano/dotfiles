#!/usr/bin/env bash

which -s brew

if [[ $? != 0 ]] ; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Get 'brew' working on the PATH before we pull down our .zshrc
    UNAME_MACHINE="$(uname -m)"
    if [[ "$UNAME_MACHINE" == "arm64" ]]; then
    # ARM macOS
    HOMEBREW_PREFIX="/opt/homebrew"
    else
    # Intel macOS
    HOMEBREW_PREFIX="/usr/local"
    fi
    export PATH="${HOMEBREW_PREFIX}/bin:$PATH"
    brew bundle install
else
    # Make sure we’re using the latest Homebrew.
    echo "Homebrew already installed, updating.."
    brew update
    brew bundle install
fi
