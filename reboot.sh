#!bin/sh

path=""
date_list=($(grep -v '^#' $path/config.txt | awk -F ' ' '{print $1*3600+$2*60}' | sort -n))
current_date=$(date +%H:%M | awk -F ':' '{print $1*3600+$2*60}')
last_date=-1
for date in "${date_list[@]}"
do
	if [ "$date" -le "$current_date" ]
	then
		last_date=$date
	fi
done
if [ "$last_date" -eq "-1" ]
then
	last_date=date_list[-1]
fi
export $(cat /proc/$(pgrep -u `whoami` ^gnome-shell$)/environ | grep -z DBUS_SESSION_BUS_ADDRESS)
gsettings set org.gnome.desktop.background picture-uri "file://${path}/wallpapers/$(grep "^$(date -d@$last_date -u +%H:%M | tr ':' ' ')" $path/config.txt | cut -d' ' -f3)"
