#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Swap ESC with Caps
#setxkbmap -option caps:swapescape
 #[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

# gnome-keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Dotnet Core
#export PATH="$PATH:/home/user/.dotnet/tools"
# Android Studio
#export _JAVA_AWT_WM_NONREPARENTING=1
# Alacritty no DPI scale
export WINIT_X11_SCALE_FACTOR=1

# XDG Dirs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# auto mount disks
exec udiskie &

# Compositor
exec picom &

# Bar
#exec polybar white &
#exec /home/user/.config/polybar/launch.sh

# background
feh --bg-scale /home/user/Bilder/Wallpaper.png &

# leftwm
#exec dbus-launch leftwm

# bspwm
#exec bspwm 
export EDITOR=/usr/bin/nvim
# xmonad
exec xmonad

#exec srandrd /home/user/Scripts/monitor-hook.sh
#exec forever start /home/user/shell-bot/server.js
