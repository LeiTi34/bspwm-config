#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload white &
  done
else
  polybar --reload white &
fi

# Launch bar1 and bar2
#polybar bar &
#polybar bar2 &

echo "Bars launched..."