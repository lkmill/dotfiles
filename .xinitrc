#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
 
# load all settings in .Xresource file (mainly for urxvt terminal)
if [ -s ~/.Xresources ]; then
	xrdb ~/.Xresources
fi

if [ -s ~/.Xcolors/gruvbox ]; then
	xrdb -merge ~/.Xcolors/gruvbox
fi

# update X font locations
xset +fp /usr/share/fonts/local
xset fp rehash

source ~/bin/set-screens

~/.fehbg

echo ".xinitrc" >> ~/.log/xinitrc.log

#xrandr --output HDMI1 --primary --left-of VGA1

#exec tdm --xstart
if [ $WM = "awesome" ]; then #  # -V: verbose
  exec awesome 2> ~/.log/awesome.log
else
  exec i3 -V -c $HOME/.config/i3/config 2> ~/.log/i3.log
fi
