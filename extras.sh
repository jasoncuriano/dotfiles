#!/usr/bin/env bash

# Install Poetry for python
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -


# Install oh-my-zsh
[[ ! -d "~/.oh-my-zsh" ]] || sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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
curl -LSso ~/itermprofile.json https://raw.githubusercontent.com/jasoncuriano/dotfiles/master/iterm2/profile.json
echo "iTerm profile config copied to ~/.itermprofile.json, please upload to iTerm."

# https://github.com/zsh-users/zsh-autosuggestions
#[[ ! -d "~/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]] || git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions

[[ ! -d "~/.oh-my-zsh/custom/themes/powerlevel10k" ]] || git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k

# Configure Git https://github.com/olivierverdier/zsh-git-prompt

exec "$SHELL"
