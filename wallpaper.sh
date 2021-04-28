#!bin/sh

PID=$(pgrep gnome-session | tail -n1)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)
# You can specify your own directory.
path=""
target_dir="file://${path}/wallpapers/"
gsettings set org.gnome.desktop.background picture-uri "${target_dir}${1}"
