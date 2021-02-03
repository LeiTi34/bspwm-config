set -g -x PATH /usr/local/bin $PATH
set fish_greeting

#thefuck --alias | source

function fish_greeting
    /opt/shell-color-scripts/colorscript.sh -r
end

set -g man_bold -o yellow

fish_vi_key_bindings

# Start X at login
#if status is-login
#    if test -z "$DISPLAY" -a $XDG_VTNR = 1
#        exec startx -- -keeptty
#    end
#end

complete -c cheat.sh -xa '(curl -s cheat.sh/:list)'
complete -c cht.sh -xa '(curl -s cheat.sh/:list)'

starship init fish | source
