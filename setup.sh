#!bin/sh

path=$(pwd)
sed -i 's|path=".*"|path="'"${path}"'"|g' wallpaper.sh
sed -i 's|path=".*"|path="'"${path}"'"|g' reboot.sh
crontab -l | grep -v 'wallpaper.sh\|reboot.sh\|DISPLAY=:0' | crontab -
crontab -l > mycron
grep -v '^#' config.txt | awk -v path=$path -F ' ' '{print $2,$1,"* * * bash",path"/wallpaper.sh",$3}' >> mycron
echo -e "DISPLAY=:0\n@reboot dbus-launch bash ${path}/reboot.sh" >> mycron
crontab mycron
rm mycron

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
gsettings set org.gnome.desktop.background picture-uri "file://${path}/wallpapers/$(grep "^$(date -d@$last_date -u +%H:%M | tr ':' ' ')" $path/config.txt | cut -d' ' -f3)"

