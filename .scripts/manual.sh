#!/bin/sh
menu=(rofi -dmenu)
terminal=(urxvt -e)

man -k . | "${menu[@]}" -l 30 | awk '{print $1}' | xargs -r "${terminal[@]}" man
