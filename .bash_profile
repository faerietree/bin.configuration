# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

# Automatically startx on logon on virtual terminal: (Used with Openbox window manager.)
#if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDB_VTNR" -eq 1 ]; then
if [ -z "$DISPLAY" ]; then  # && [ -n "$XDG_VTNR" ] && [ "$XDB_VTNR" -eq 1 ]; then
	exec startx
fi
# To only kill Xorg on the current virtual terminal:
#pkill -15 -t tty"$XDG_VTNR" Xorg
# else
#killall Xorg

EDITOR=vim
