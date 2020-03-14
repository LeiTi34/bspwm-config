#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# gnome-keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Dotnet Core
export PATH="$PATH:/home/user/.dotnet/tools"
# Android Studio
export _JAVA_AWT_WM_NONREPARENTING=1

# auto mount disks
exec udiskie &

# bspwm
exec bspwm 

#exec srandrd /home/user/Scripts/monitor-hook.sh
#exec forever start /home/user/shell-bot/server.js
