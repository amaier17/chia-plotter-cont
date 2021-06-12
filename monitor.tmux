#!/bin/bash

tmux new-session -d 'plotter-mon'
tmux send-keys "htop" C-m
tmux split-window -v -p 70
tmux send-keys 'watch -n 2 "sudo systemctl status chia-plotter.service"' C-m
tmux split-window -v -p 10 -t 1
tmux send-keys 'watch -n 2 "ls /local-plot | wc"' C-m
tmux -2 attach-session -d

