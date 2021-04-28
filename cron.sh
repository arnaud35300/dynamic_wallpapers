#!bin/sh

P=$(pwd)
sed -i 's|path=".*"|path="'"$(pwd)"'"|g' wallpaper.sh
crontab -l | grep -v 'wallpaper.sh' | crontab -
crontab -l > mycron
grep -v '^#' config.txt | awk -v P=$P -F ' ' '{print $2,$1,"* * * bash",P"/wallpaper.sh",$3}' >> mycron
crontab mycron
rm mycron
