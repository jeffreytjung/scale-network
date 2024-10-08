# Pi gold image instructions

Instructions heavily influenced by https://youtu.be/T9AtKld8USU

# Create bootable SDCARD:

1. Download the current specified Raspbian image from https://www.raspberrypi.org/downloads/raspbian/
   a. As of 2020-02-24 the specified image is `2019-09-26-raspbian-buster-lite.img`

2. Write to an SD Card using [Etcher](https://www.balena.io/etcher/)

# Boot and setup system:

1. Boot up

2. Log in as pi/raspberry

3. sudo adduser admin (set password)

4. sudo usermod -aG sudo admin

5. sudo apt-get update; sudo apt-get upgrade -y

6. sudo reboot

7. Log in as pi

8. sudo apt-get install lightdm -y

9. sudo raspi-config

	-- 2. Network Options

	---- N1. Hostname

	------ set name to kiosk (you cannot change this later without great effort, chromium's lock depends on hostname)
	
	-- 3. Boot Options

	---- B1. Desktop / CLI

	------ Select Console no auto login

	-- 4. Localization Options
	
	---- I2. Change Timezone

	------ America > Los Angeles

	-- 4. Localization Options

	---- I3. Change Keyboard Layout

	------ Generic 104-key PC > Other > English (US) > English (US) > The default for the keyboard layout > No compose key > No

	-- 7. Advanced Options

	---- A2. Overscan

	------ No > Ok

	-- 7. Advanced Options

	---- A3. Memory Split

	------ Enter 256

	-- Finish

	---- Yes to Reboot

10. After reboot hit CTRL+ALT+F2 to get a terminal

11. Login as admin

12. sudo apt-get install plymouth plymouth-themes pix-plym-splash -y

13. wget https://linuxjournal.com/sites/default/files/nodeimage/story/ScaleLogo.jpg

14. sudo mv ScaleLogo.jpg /usr/share/plymouth/themes/pix/splash.jpg

15. sudo vi /boot/config.txt

	-- add a line that says disable_splash=1 to the end

	-- save file

16. sudo vi /usr/share/plymouth/themes/pix/pix.script

	-- change theme_image to splash.jpg

	-- remove the two lines that have message_sprite at the beginning

	-- remove the line that starts with my-image within the message_callback function

	-- remove the line that starts with message_sprite within the message_callback function

	-- save file

17. sudo vi /boot/cmdline.txt

	-- replace tty1 with tty3

	-- at the end add splash quiet plymouth.ignore-serial-consoles logo.nologo vt.global_cursor_default=0

	-- save file

18. sudo apt-get install --no-install-recommends xserver-xorg x11-xserver-utils xinit openbox chromium-browser -y

19. sudo vi /etc/xdg/openbox/autostart

	-- replace the contents of the file with the following:

```
#!/bin/bash

xset s off
xset s noblank
xset dpms 0 0 0
xset -dpms

if [ -e /sys/class/input/mouse0 ]
then
	while true; do
		/usr/bin/reg.py
        done
else
	while true; do
		/usr/bin/web.py
	done
fi
```

-- save file

20. sudo vi /etc/rc.local

	-- before the exit 0 at the bottom add the following
startx &

21. copy the two files [web.py](./scripts/web.py) and [reg.py](./scripts/reg.py) from the scripts `scripts` directory to /usr/bin/ on the pi using scp or a thumb drive.

	-- make sure they are executable

22. sudo apt-get install python-gtk2 python-webkit unclutter zabbix-agent -y

23. sudo vi /etc/xdg/openbox/rc.xml

	-- remove everything in the keyboard section

	-- remove everything except for <doubleClickTime> in the mouse section

24. sudo vi /etc/group

	-- remove pi from the sudo group

25. sudo rm /etc/sudoers.d/010_pi-nopasswd

26. sudo mv /etc/rc3.d/K01ssh /etc/rc3.d/S99ssh

27. change the password for pi and admin, save for sharing with team

28. reboot, test with a mouse and without one
