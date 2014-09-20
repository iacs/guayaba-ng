#!/bin/bash

tmux start-server
#tmux set-remain-on-exit on
tmux new-session -d -s 'webstack' -n 'Web Stack'
tmux send-keys -t webstack:1 'git status' C-m
tmux split-window -h
tmux send-keys -t webstack:1 'bundle exec "compass watch"' C-m
tmux split-window -v
tmux send-keys -t webstack:1 'bundle exec "jekyll serve -w"' C-m
#tmux select-pane -D
#tmux split-window -v
tmux attach-session -d -t 'webstack'
