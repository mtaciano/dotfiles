#!/bin/sh

# Currently focused window
focusedwindow=$(xdotool getactivewindow)

# Take screenshot and select the currently focused window,
# since the flameshot gui changes focus
flameshot gui -c -g >/dev/null
if [ $focusedwindow = $(xdotool getactivewindow) ]; then
  xdotool windowfocus $focusedwindow
fi
