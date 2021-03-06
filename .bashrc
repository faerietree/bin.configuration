# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return
#[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# avoid duplicates:
#export HISTCONTROL=ignoredups:erasedups


# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=  #1000000
export HISTFILESIZE=  #2000000 #changed: multiplied times 100
export HISTFILE=~/.bash_eternal_history
export HISTTIMEFORMAT="[%F %T] "

export HISTIGNORE='&:ls:cd ~:cd ..:exit:h:history:fg:jobs:top'

# append history entries not only at terminal exit to prevent command loss:
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"  #shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set the title to user@host: dir
PS1='[\u@\h \W]\$ '
case "$TERM" in
xterm*|rxvt*)
    #PS1="\[\e]0;\u@\h: \w\a\]\w\$ "
    ;;
screen*)
    PS1='\u@\h \W\$ '
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi


#LaTeX Live
#export PATH="$PATH:$HOME/texlive/bin"

#tex4ht
#export PATH="$PATH:$HOME/part_db_eclipse/tex4ht/bin"



# JAVA CONFIGURATION AFTER LOGON
#export JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64
# SWITCH BETWEEN DIFFEREN JAVA VERSIONS USING SYMBOLIC LINKS:
# e.g. to use java-7 execute: $   ln -s /usr/lib/jvm/java-7-openjdk-amd64 ~/lib/jdk
#export JAVA_HOME=~/lib/jdk_
#export CLASSPATH="/usr/local/tomcat/bin/startup.sh;/usr/local/tomcat/common/lib/servlet-api.jar"


# Start tomcat by default
#sh /usr/local/tomcat/bin/startup.sh
# now done per /etc/init.d/tomcat ... see this file for more info
# use
#/usr/local/tomcat/bin/shutdown.sh
#/usr/local/tomcat/bin/startup.sh
# For eclipse local server debugging tomcat needs to be stopped or the server startup will fail.

#sudo chmod +x /usr/bin/*.sh
#sudo chmod +x /usr/local/tomcat/bin/*.sh




# GDB + PYCLEWN + VIM + CLANG CODE COMPLETION + CSCOPE for resolving function calls and much more.

export VISUAL=vim
export EDITOR=$VISUAL


# IF LOCATED IN THE HOME DIRECTORY.
#source $HOME/OpenFOAM/OpenFOAM-2.3.1/etc/bashrc
# OR
#export FOAM_INST_DIR=/data/app/OpenFOAM
#foamDotFile=$FOAM_INST_DIR/OpenFOAM-2.3.1/etc/bashrc
#[ -f $foamDotFile ] && . $foamDotFile
# OR soft link.

eval `dircolors`
#
# ~/.bashrc
#

[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[[ -f ~/.extend.bashrc ]] && . ~/.extend.bashrc

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

sudo rmmod pcspkr
#sudo echo "blacklist pcskr" > /etc/modprobe.d/nobeep.conf
