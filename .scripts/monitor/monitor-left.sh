#!/bin/bash

main_monitor="eDP-1"

xrandr --output HDMI-1 --auto --left-of $main_monitor 
xrandr --output HDMI-2 --auto --left-of $main_monitor
