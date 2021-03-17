#!/usr/bin/env bash

# Check if we've not already got a session created
if [[ $(tmux ls 2> /dev/null | grep -c work) -eq 1 ]]; then
  tmux attach -t work
else
  # Every time I restart my computer I forget about doing this
  # I then wonder why I can't push to GitHub/GitLab
  eval "$(ssh-agent -s)"
  ssh-add -K ~/.ssh/id_rsa

  # Create a new session and detach from it
  tmux new -s work -d

  # Work
  tmux rename-window -t 1 'work'
  tmux send-keys -t work:1 'cd ~/git' 'C-m'
  tmux split-window -p 30

  # ipython REPL
  #tmux new-window -n 'ipython' -t work:2
  #tmux send-keys -t work:2 'cd ~/Code/Python/3.8-dev && pyenv activate ipython_env && ipython' 'C-m'

  # htop
  #tmux new-window -n 'htop' -t work:3
  #tmux send-keys -t work:3 'htop' 'C-m'

  # Now everything is setup we'll attach to a specific window we're interested in
  tmux attach -t work:3
fi