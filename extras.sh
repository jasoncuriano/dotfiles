#!/usr/bin/env bash

# .zshrc config
if [[ -f "$HOME/.zshrc" ]]
then
    read -p "File $HOME/.zshrc already exists.  Pull down a new copy from github and overwrite? Yn" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        rm "$HOME/.zshrc"
        curl -LSso "$HOME"/.zshrc https://raw.githubusercontent.com/jasoncuriano/dotfiles/master/.zshrc
    fi
else
    echo "File $HOME/.zshrc does not exist, creating.."
    curl -LSso "$HOME"/.zshrc https://raw.githubusercontent.com/jasoncuriano/dotfiles/master/.zshrc
fi

# Silence last login messages in iTerm
if [[ -f "$HOME/.hushlogin" ]]
then
    echo "File $HOME/.hushlogin already exists."
else
    echo "File $HOME/.hushlogin does not exist, creating.."
    touch "$HOME"/.hushlogin
fi

# Terraform tfswitch binary location setup
if [[ -d "$HOME/.tfswitch/bin" ]]
then
    echo "Dir $HOME/.tfswitch/bin already exists."
else
    echo "Dir $HOME/.tfswitch/bin does not exist, creating.."
    mkdir -p "$HOME"/.tfswitch/bin
fi

# Terraform Tfswitch toml config setup
if [[ -f "$HOME/.tfswitch.toml" ]]
then
    echo "File $HOME/.tfswitch.toml already exists."
else
    echo "File $HOME/.tfswitch.toml does not exist, creating.."
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

# Copy down iTerm profile config - needs manual upload to iTerm
if [[ -f "$HOME/JC_iTerm.json" ]]
then
    echo "File $HOME/JC_iTerm.json already exists, manually upload this to iTerm."
else
    echo "File $HOME/JC_iTerm.json does not exist, creating.. (manually upload this to iTerm)"
    curl -LSso "$HOME"/JC_iTerm.json https://raw.githubusercontent.com/jasoncuriano/dotfiles/master/iterm2/JC_iTerm.json
fi

# Antigen Zsh Plugins
if [[ -f "$HOME/.antigen.zsh" ]]
then
    echo "File $HOME/.antigen.zsh already exists."
else
    echo "File $HOME/.antigen.zsh does not exist, creating.."
    curl -L git.io/antigen > "$HOME/.antigen.zsh"
fi

if [[ -f "$HOME/.antigenrc" ]]
then
    read -p "File $HOME/.antigenrc already exists.  Pull down a new copy from github and overwrite? Yn" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        rm "$HOME/.antigenrc"
        curl -LSso "$HOME"/.antigenrc https://raw.githubusercontent.com/jasoncuriano/dotfiles/main/.antigenrc
    fi
else
    echo "File $HOME/.antigenrc does not exist, creating.."
    curl -LSso "$HOME"/.antigenrc https://raw.githubusercontent.com/jasoncuriano/dotfiles/main/.antigenrc
fi
