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

# from solarized/xresources  and arch linux X_resources wiki:
[ -f ~/.Xresources ] && xrdb -merge -I$HOME ~/.Xresources  # never background it to have it terminate before apps launch

# custom mapping of input devices' keycode, keysym:
# e.g. to swap mouse left (1), right (3) buttons
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
exec openbox-session

