#!/bin/sh

# Use -d to allow the rest of the function to run
tmux new-session -d -s mig

# Create the windows until there are exactly 3
while [ "$(tmux list-windows | wc -l)" -lt "3" ]; do
    tmux new-window -d
done

# Use -d to detach any other client
tmux attach-session -d -t mig
