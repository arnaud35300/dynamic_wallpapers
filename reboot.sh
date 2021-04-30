#!bin/sh

path="/home/arnaud/Documents/shell_script/dynamic_wallpapers"
date_list=($(grep -v '^#' $path/config.txt | awk -F ' ' '{print $1*3600+$2*60}'))
current_date=$(date +%H:%M | awk -F ':' '{print $1*3600+$2*60}')
last_date=-1
for date in $(printf '%s\n' "${date_list[@]}" | sort -n)
do
	if [ "$date" -le "$current_date" ]
	then
		last_date=$date
	fi
done
if [ "$last_date" -eq "-1" ]
then
	last_date=$(printf '%s\n' "${date_list[@]}" | sort -nr | awk 'NR==1{print}')
fi
export $(cat /proc/$(pgrep -u `whoami` ^gnome-shell$)/environ | grep -z DBUS_SESSION_BUS_ADDRESS)
gsettings set org.gnome.desktop.background picture-uri "file://${path}/wallpapers/$(grep "^$(echo $last_date | awk '{printf("%02d %02d",$1/3600,$1%3600/60)}')" $path/config.txt | cut -d' ' -f3)" 2> $path/debug.txt
