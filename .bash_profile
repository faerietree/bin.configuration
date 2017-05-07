# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

# OPAM configuration
. $HOME/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# Automatically startx on logon on virtual terminal: (Used with Openbox window manager.)
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDB_VTNR" -eq 1 ]; then
	exec startx
fi
# To only kill Xorg on the current virtual terminal:
#pkill -15 -t tty"$XDG_VTNR" Xorg

