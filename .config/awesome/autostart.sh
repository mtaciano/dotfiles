#!/bin/sh

# Run and background a program if it's not already running
run() {
  if ! pgrep -x $1; then
    $@ &
  fi
}

# Commands to run
run /usr/libexec/polkit-gnome-authentication-agent-1
run gentoo-pipewire-launcher
run picom --daemon
run unclutter
run volctl
run fcitx5 -d
run flameshot
run gammastep
run ~/.config/awesome/tmux.sh
run wezterm start tmux attach
run firefox-bin
run keepassxc
