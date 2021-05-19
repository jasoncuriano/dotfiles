#!/usr/bin/env bash

# Install Poetry for python
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -

# Silence last login messages in iTerm
touch ~/.hushlogin

# Terraform Tfswitch binary location setup
mkdir -p ~/.tfswitch/bin
echo "bin = \"\$HOME/.tfswitch/bin/terraform\"" > ~/.tfswitch.toml

# Install oh-my-zsh
[[ ! -d "~/.oh-my-zsh" ]] || sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# .zshrc config
read -p "Pull down and overwrite .zshrc? Yn" -n 1 -r 
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then  
  [[ ! -f "~/.zshrc" ]] || rm ~/.zshrc
  # Copy down Zsh config
  curl -LSso ~/.zshrc https://raw.githubusercontent.com/jasoncuriano/dotfiles/master/.zshrc
fi

[[ ! -f "~/.secrets" ]] || touch ~/.secrets

# Copy down iTerm profile config - needs manual upload to iTerm
curl -LSso ~/JC_iTerm.json https://raw.githubusercontent.com/jasoncuriano/dotfiles/master/iterm2/JC_iTerm.json
echo "iTerm profile copied to ~/.JC_iTerm.json, please upload to iTerm."

# Reload shell
exec "$SHELL"
