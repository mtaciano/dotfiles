#!/bin/sh

# Run and background a program if it's not already running
run() {
  if ! pgrep -x $1; then
    $@ &
  fi
}

# Invokes a prompt to type your password for authentication
run /usr/libexec/polkit-gnome-authentication-agent-1

# Start gpg-agent
run gpgconf --launch gpg-agent

# Make audio work
run gentoo-pipewire-launcher

# Compositor
run picom --daemon

# Hide cursor after inactivity
run unclutter

# Volume % notification
run volctl

# Input method
run fcitx5 -d

# Screenshots
run flameshot

# Dim the screen based on the time of the day
run gammastep

# Start a tmux server
run ~/.config/awesome/tmux.sh

# Start the terminal and attach to the tmux server
run wezterm start tmux attach

# Browser
run firefox-bin
