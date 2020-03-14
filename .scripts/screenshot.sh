#!/bin/sh

maim $@ --format=png /dev/stdout | tee "/home/user/Bilder/screenshots/screenshot_`date '+%Y%m%d_%H%M%S'`.png" | xclip -selection clipboard -t image/png -i
