# Use -d to allow the rest of the function to run
tmux new-session -d -s mig

# Create the 3 windows
tmux new-window -d
tmux new-window -d

# -d to detach any other client
tmux attach-session -d -t mig
