#!bin/sh

path=""
export $(cat /proc/$(pgrep -u `whoami` ^gnome-shell$)/environ | grep -z DBUS_SESSION_BUS_ADDRESS)
gsettings set org.gnome.desktop.background picture-uri "file://${path}/wallpapers/${1}"
