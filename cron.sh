#!bin/sh

P=$(pwd)
sed -i 's|path=".*"|path="'"$(pwd)"'"|g' wallpaper.sh
sed -i 's|path=".*"|path="'"$(pwd)"'"|g' reboot.sh
crontab -l | grep -v 'wallpaper.sh\|reboot.sh\|DISPLAY=:0' | crontab -
crontab -l > mycron
grep -v '^#' config.txt | awk -v P=$P -F ' ' '{print $2,$1,"* * * bash",P"/wallpaper.sh",$3}' >> mycron
echo -e "DISPLAY=:0\n@reboot dbus-launch bash ${P}/reboot.sh" >> mycron
crontab mycron
rm mycron
