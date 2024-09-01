#!/bin/sh

if [ "$DESKTOP_SESSION" = "xfce" ]; then 
   sleep 10s
   killall conky
   cd "$HOME/.conky/donzi_lite"
   conky -c "$HOME/.conky/donzi_lite/conky.conf" &
   exit 0
fi
