#!/usr/bin/env bash

git config --global color.ui auto

read -p "Run git user config? (user.name and user.email setup)" -n 1 -r 
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then  
  echo "Enter the git user.name"
  read -p "> " -r GIT_NAME
  echo "Enter the git user.email (this should be your noreply email if you have privary turned on)"
  read -p "> " -r GIT_EMAIL

  git config --global user.name "$GIT_NAME"
  git config --global user.email "$GIT_EMAIL"
fi


git config --global core.excludesfile ~/.gitexcludes_global
# Global excludes file
read -p "Overwrite global excludes file?" -n 1 -r 
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  [[ -f "~/.gitexcludes_global" ]] || rm ~/.gitexcludes_global  
  [[ ! -f "~/.gitexcludes_global" ]] || touch ~/.gitexcludes_global
  wget 'https://raw.githubusercontent.com/github/gitignore/master/Global/macOS.gitignore' -O - >> ~/.gitexcludes_global
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
mkdir -p ~/code/src/github.com/jasoncuriano/
mkdir -p ~/code/src/gitlab.com/jasoncuriano/

cat ~/.gitconfig
