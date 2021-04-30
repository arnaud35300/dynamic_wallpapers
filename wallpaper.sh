#!bin/sh

# You can specify your own directory.
path="/home/arnaud/Documents/shell_script/dynamic_wallpapers"
target_dir="file://${path}/wallpapers/"
export $(cat /proc/$(pgrep -u `whoami` ^gnome-shell$)/environ | grep -z DBUS_SESSION_BUS_ADDRESS)
gsettings set org.gnome.desktop.background picture-uri "${target_dir}${1}"
