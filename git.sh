#!/usr/bin/env bash

git config --global color.ui auto

read -p "Run git user config? (user.name and user.email setup)" -n 1 -r 
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then  
  echo "Enter the git user.name"
  read -p "> " -r GIT_NAME
  echo "Enter the git user.email (this should be your GitHub noreply email if you have privacy turned on)"
  read -p "> " -r GIT_EMAIL

  git config --global user.name "$GIT_NAME"
  git config --global user.email "$GIT_EMAIL"
fi


# Global excludes file
git config --global core.excludesfile ~/.gitexcludes_global

function download_gitexcludes() {
  wget -q 'https://raw.githubusercontent.com/github/gitignore/main/Global/macOS.gitignore' -O - >> "$HOME/.gitexcludes_global"
  wget -q 'https://raw.githubusercontent.com/github/gitignore/main/Go.gitignore' -O - >> "$HOME/.gitexcludes_global"
  wget -q 'https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore' -O - >> "$HOME/.gitexcludes_global"
  wget -q 'https://raw.githubusercontent.com/github/gitignore/main/Node.gitignore' -O - >> "$HOME/.gitexcludes_global"
  wc -l "$HOME/.gitexcludes_global"
}

if [[ -f "$HOME/.gitexcludes_global" ]]
then
    read -p "File $HOME/.gitexcludes_global already exists.  Pull down a new copy from github and overwrite? Yn" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        rm "$HOME/.gitexcludes_global"
        touch "$HOME/.gitexcludes_global"
        download_gitexcludes
    fi
else
    echo "File $HOME/.gitexcludes_global does not exist, creating.."
    touch "$HOME/.gitexcludes_global"
    download_gitexcludes
fi

# Set git to use the osxkeychain credential helper
git config --global credential.helper osxkeychain

# Set how to reconcile divergent branches when pulling
git config --global pull.rebase false     # merge (the default strategy)

# https://github.com/so-fancy/diff-so-fancy
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global interactive.diffFilter "diff-so-fancy --patch"
git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"
git config --global color.diff.meta       "11"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.func       "146 bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"

git config --global pull.ff true # Pull is fast-forwarded if possible, otherwise it's merged.

# Setting Up A Directory Structure for Projects
# http://golang.org/doc/code.html
# First create a top-level directory with a short, generic name like code
# In this directory, create an src sub-directory. 
# For each repository host, create a subdirectory in src that matches your username
# but they pay off when you have many projects, some of which are on different version control hosts.
if [[ -d "$HOME/code/src/github.com/jasoncuriano" ]]
then
    echo "Dir $HOME/code/src/github.com/jasoncuriano already exists." 
else
    echo "Error: Dir $HOME/code/src/github.com/jasoncuriano does not exist, creating.."
    mkdir -p "$HOME"/code/src/github.com/jasoncuriano/
fi
