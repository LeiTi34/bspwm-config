set -g -x PATH /usr/local/bin $PATH
set fish_greeting

# Start X at login
if status is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
end
end
