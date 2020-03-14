#!/bin/sh

devices=$(xrandr | grep ' connected' | awk '{print $1}')
ncdevices=$(xrandr | grep ' disconnected' | awk '{print $1}')

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

while IFS= read -r device; do
    if [ $device != 'eDP-1' ]
    then
        xrandr --output $device --auto --left-of eDP-1
    fi
    MONITOR=$device polybar --reload white &
done <<< "$devices"

while IFS= read -r device; do
    if [ $device != 'eDP-1' ]
    then
        xrandr --output $device --off
    fi
done <<< "$ncdevices"

#sleep 1

#/home/user/.config/polybar/launch.sh
