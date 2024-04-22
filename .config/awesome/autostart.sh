#!/bin/sh

# Run and background a program if it's not already running
run() {
  if ! pgrep -xf "$*" > /dev/null; then
    $@ &
  fi
}

# Run and background a program if it's not already running (less strict)
run_relaxed() {
  if ! pgrep -f $1 > /dev/null; then
    shift
    $@ &
  fi
}

# Invokes a prompt to type your password for authentication
run /usr/libexec/polkit-gnome-authentication-agent-1

# Start gpg-agent
run_relaxed gpg-agent gpgconf --launch gpg-agent

# Make audio work
run_relaxed pipewire gentoo-pipewire-launcher

# Compositor
run picom --daemon

# Hide cursor after inactivity
run unclutter

# Volume % notification
run_relaxed volctl volctl

# Input method
run fcitx5 -d

# Screenshots
run flameshot

# Dim the screen based on the time of the day
run gammastep

# Start a tmux server
run ~/.config/awesome/tmux.sh

# Start the terminal and attach to the tmux server
run_relaxed wezterm wezterm start tmux attach

# Browser
run_relaxed firefox-bin firefox-bin
