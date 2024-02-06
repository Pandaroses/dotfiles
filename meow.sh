#!/bin/bash

# Kill any running pipewire processes
killall -q wireplumber & killall -q pipewire-pulse & killall -q pipewire

# Wait for processes to stop
while pgrep -u $UID -x wireplumber >/dev/null; do sleep 1; done
while pgrep -u $UID -x pipewire >/dev/null; do sleep 1; done
while pgrep -u $UID -x pipewire-pulse >/dev/null; do sleep 1; done

# Wait for xdg-desktop-portal to start
until pgrep -u $UID -f /usr/lib/xdg-desktop-portal >/dev/null; do sleep 1; done

# Launch pipewire
echo "---" | tee -a /tmp/{wireplumber.log,pipewire.log,pipewire-pulse.log}
/usr/bin/wireplumber 2>&1 | tee -a /tmp/wireplumber.log & disown
/usr/bin/pipewire 2>&1 | tee -a /tmp/pipewire.log & disown
/usr/bin/pipewire-pulse 2>&1 | tee -a /tmp/pipewire-pulse.log & disown

