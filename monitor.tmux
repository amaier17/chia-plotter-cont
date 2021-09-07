#!/bin/bash

tmux new-session -d 'plotter-mon'
tmux send-keys "sudo journalctl -xef | grep -i plot-transfer" C-m
tmux split-window -v -p 70
tmux send-keys 'sudo journalctl -u chia-plotter -f' C-m
tmux split-window -v -p 10 -t 1
tmux send-keys 'watch -n 2 "ls /mnt/md0/*.plot | wc"' C-m
tmux -2 attach-session -d

