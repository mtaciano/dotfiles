#!/bin/sh

# The default session name
session_name="mig"

# Check if there's not a session running already
if ! tmux has-session -t ${session_name}; then
    # Use -d to allow the rest of the function to run
    tmux new-session -d -s ${session_name}
fi

# Create new windows until there are >= 3
while [ "$(tmux list-windows | wc -l)" -lt "3" ]; do
    tmux new-window -d
done
