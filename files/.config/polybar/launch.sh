#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

POLYBAR_CONFIG="$XDG_CONFIG_HOME/polybar/config.ini"

# https://github.com/polybar/polybar/issues/763
# I couldn't use 'polybar --list-monitors'.
# if type "xrandr"; then
#   for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#     # https://github.com/adi1090x/polybar-themes/blob/master/polybar-5/launch.sh
#     MONITOR=$m polybar -c $POLYBAR_CONFIG top &
#     MONITOR=$m polybar -c $POLYBAR_CONFIG bottom &
#   done
# else
polybar -c "$POLYBAR_CONFIG" top &
polybar -c "$POLYBAR_CONFIG" bottom &
# fi
