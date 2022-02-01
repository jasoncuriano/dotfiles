#!/usr/bin/env bash

# Install Poetry for python
if ! which -s poetry; then
    echo "Poetry not found, attempting install."
    curl -sSL https://install.python-poetry.org | POETRY_HOME="$HOME/.poetry/" python3 -
else
    # Make sure we’re using the latest Homebrew.
    echo "Poetry already installed, running 'poetry self update'"
    poetry self update
fi

# Silence last login messages in iTerm
if [[ -f "$HOME/.hushlogin" ]]
then
    echo "File $HOME/.hushlogin already exists." 
else
    echo "File $HOME/.hushlogin does not exist, creating.."
    touch "$HOME"/.hushlogin
fi

# Terraform Tfswitch binary location setup
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

# Create a ~/.secrets file
if [[ -f "$HOME/.secrets" ]]
then
    echo "File $HOME/.secrets already exists." 
else
    echo "File $HOME/.secrets does not exist, creating.."
    touch "$HOME"/.secrets
fi

# Copy down iTerm profile config - needs manual upload to iTerm
if [[ -f "$HOME/JC_iTerm.json" ]]
then
    echo "File $HOME/JC_iTerm.json already exists, manually upload this to iTerm." 
else
    echo "File $HOME/JC_iTerm.json does not exist, creating.. (manually upload this to iTerm)"
    curl -LSso "$HOME"/JC_iTerm.json https://raw.githubusercontent.com/jasoncuriano/dotfiles/master/iterm2/JC_iTerm.json
fi

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


# zsh_plugins.txt config for Antibody plugin manager
if [[ -f "$HOME/.zsh_plugins.txt" ]]
then
    read -p "File $HOME/.zsh_plugins.txt already exists.  Pull down a new copy from github and overwrite? Yn" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        rm "$HOME/.zsh_plugins.txt"
        curl -LSso "$HOME"/.zsh_plugins.txt https://raw.githubusercontent.com/jasoncuriano/dotfiles/main/.zsh_plugins.txt
        antibody bundle < "$HOME"/.zsh_plugins.txt > "$HOME"/.zsh_plugins.sh
        antibody update
    fi
else
    echo "File $HOME/.zsh_plugins.txt does not exist, creating.."
    curl -LSso "$HOME"/.zsh_plugins.txt https://raw.githubusercontent.com/jasoncuriano/dotfiles/main/.zsh_plugins.txt
    antibody bundle < "$HOME"/.zsh_plugins.txt > "$HOME"/.zsh_plugins.sh
    antibody update
fi
