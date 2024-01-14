#!/bin/sh

# set bg
sh /home/heavenmaido/.fehbg &

#set status bar
dwmstatus 2>&1 >/dev/null &

# Run picom for cool effects
exec picom &

#run autojump
# source /usr/share/autojump/autojump.sh
