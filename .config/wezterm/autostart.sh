#!/bin/sh

# The default session name
session_name="mig"

# Check if tmux and fish is installed
if command -v tmux && command -v fish; then
    # If it is, check if there's already a session running
    if tmux has-session -t ${session_name}; then
        # If we're not inside a session already
        if [ -z $TMUX ]; then
            # Then attach to it
            fish -c "tmux attach -t ${session_name}"
        else
            # Switch to it if we already are inside a session
            fish -c "tmux switch-client -t ${session_name}"
        fi
    else
        # There's no session running, so start one and attach to it
        sh -c ~/.config/hypr/tmux.sh
        fish -c "tmux attach -t ${session_name}"
    fi
else
    # If everything else fails, just run bash...
    bash
fi
