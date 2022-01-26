#!/usr/bin/env bash

# Install Poetry for python
if ! which -s poetry; then
    echo "Poetry not found, attempting install."
    curl -sSL https://install.python-poetry.org | POETRY_HOME="$HOME/.poetry/" python3 -
else
    # Make sure we’re using the latest Homebrew.
    echo "Poetry already installed, updating."
    poetry self update
fi

# Silence last login messages in iTerm
if [[ -f "$HOME/.hushlogin" ]]
then
    echo "File $HOME/.hushlogin already exists." 
else
    echo "Error: File $HOME/.hushlogin does not exist, creating.."
    touch "$HOME"/.hushlogin
fi

# Terraform Tfswitch binary location setup
if [[ -d "$HOME/.tfswitch/bin" ]]
then
    echo "Dir $HOME/.tfswitch/bin already exists." 
else
    echo "Error: Dir $HOME/.tfswitch/bin does not exist, creating.."
    mkdir -p "$HOME"/.tfswitch/bin
fi

# Terraform Tfswitch toml config setup
if [[ -f "$HOME/.tfswitch.toml" ]]
then
    echo "File $HOME/.tfswitch.toml already exists." 
else
    echo "Error: File $HOME/.tfswitch.toml does not exist, creating.."
    echo "bin = \"\$HOME/.tfswitch/bin/terraform\"" > "$HOME/.tfswitch.toml"
fi

# Install oh-my-zsh
if [[ -d "$HOME/.oh-my-zsh" ]]
then
    echo "Dir $HOME/.oh-my-zsh already exists." 
else
    echo "Dir $HOME/.oh-my-zsh does not exist, running oh-my-zsh installer."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Create a ~/.secrets file
if [[ -f "$HOME/.secrets" ]]
then
    echo "File $HOME/.secrets already exists." 
else
    echo "Error: File $HOME/.secrets does not exist, creating.."
    touch "$HOME"/.secrets
fi

# Copy down iTerm profile config - needs manual upload to iTerm
if [[ -f "$HOME/JC_iTerm.json" ]]
then
    echo "File $HOME/JC_iTerm.json already exists." 
else
    echo "Error: File $HOME/JC_iTerm.json does not exist, creating.."
    curl -LSso "$HOME"/JC_iTerm.json https://raw.githubusercontent.com/jasoncuriano/dotfiles/master/iterm2/JC_iTerm.json
fi

# .zshrc config
read -p "Pull down and overwrite .zshrc from github? Yn" -n 1 -r 
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then  
  [[ ! -f "$HOME/.zshrc" ]] || rm ~/.zshrc
  curl -LSso ~/.zshrc https://raw.githubusercontent.com/jasoncuriano/dotfiles/master/.zshrc
fi

# zsh_plugins.txt config for Antibody plugin manager
read -p "Pull down and overwrite .zsh_plugins.txt from github? Yn" -n 1 -r 
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then  
  [[ ! -f "$HOME/.zsh_plugins.txt" ]] || rm ~/.zsh_plugins.txt
  curl -LSso ~/.zshrc https://raw.githubusercontent.com/jasoncuriano/dotfiles/master/.zsh_plugins.txt
  antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh
  antibody update
fi
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh
antibody update
