#!/usr/bin/env bash

# Install Poetry for python
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python3 -

# Silence last login messages in iTerm
[[ ! -f "~/.hushlogin" ]] || touch "~/.hushlogin" || echo "Created ~/.hushlogin file"

# Terraform Tfswitch binary location setup
[[ ! -d "~/.tfswitch/bin" ]] || mkdir -p "~/.tfswitch/bin" || echo "Created ~/.tfswitch/bin dir"
[[ ! -f "~/.tfswitch.toml" ]] || echo "bin = \"\$HOME/.tfswitch/bin/terraform\"" > "~/.tfswitch.toml" || echo "Setup ~/.tfswitch.toml config"

# Install oh-my-zsh
[[ ! -d "~/.oh-my-zsh" ]] || sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# .zshrc config
read -p "Pull down and overwrite .zshrc? Yn" -n 1 -r 
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then  
  [[ ! -f "~/.zshrc" ]] || rm ~/.zshrc
  curl -LSso ~/.zshrc https://raw.githubusercontent.com/jasoncuriano/dotfiles/master/.zshrc
fi

[[ ! -f "~/.secrets" ]] || touch ~/.secrets || echo "Created ~/.secrets file."

# Copy down iTerm profile config - needs manual upload to iTerm
[[ ! -f "~/iTerm_downloaded.json" ]] || curl -LSso ~/iTerm_downloaded.json "https://raw.githubusercontent.com/jasoncuriano/dotfiles/master/iterm2/JC_iTerm.json" || echo "iTerm profile copied to ~/.iTerm_downloaded.json, please upload to iTerm."

