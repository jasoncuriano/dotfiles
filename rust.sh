#!/usr/bin/env bash

# Install Poetry for python
if ! which -s cargo; then
    echo "Cargo not found, attempting install."
    curl https://sh.rustup.rs -sSf | sh
else
    echo "Rust already installed"
fi
