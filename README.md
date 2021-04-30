# Easy dynamic wallpaper manager

A script to manage a wallpaper list as a function of time. 

![alt text](https://i.imgur.com/fjmo9jB.jpg)
![alt text](https://i.imgur.com/64LW4vg.jpg)
## How it works?

If you don't want to keep the wallpapers provided by default, you can define your wallpaper list in the config.txt file:
(The new wallpapers must be in the `wallpapers` folder).

![alt text](https://i.imgur.com/MUViRaz.png)

After checking that the syntax was correct in the config.txt file, run the next command in the project folder:

`bash setup.sh`

Then you can check if your cron tasks have been created by running:

`crontab -l`

That's all, do the same again each time you modify the config.txt file.
