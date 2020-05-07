#!/bin/bash
#
# Various bash aliases, prefernces and settings
# Needs to be sourced from .bashrc or similar
#


# PATH
export PATH=$PATH
export PROJECTS="$HOME/repos"
export PYTHONPATH="$HOME/repos/lib_python"
# ---



# MATPLOTLIBRC
export MATPLOTLIBRC="$HOME/scripts/matplotlibrc"
# ---



# GIT COMPLETION
source ~/.git-completion.sh
# ---



# ALIAS
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias cl='clear'
alias xx='exit'

alias ll='ls -lthX -Isnap -IDesktop --color --group-directories-first'
alias la='ls -lthXa -Isnap -IDesktop --color --group-directories-first'

alias m='more'
alias xx='exit'

alias myrc='nano ~/scripts/myrc.sh && source ~/scripts/myrc.sh'

alias vi='vim'
alias rmoe='rm *.out *.err'

alias qme='squeue -u msaller'
alias qus='squeue -p eitan'

alias nstat="python $HOME/scripts/nstatus.py"
# ---



# PS1
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# PS1 Colors
Color_Off="\[\033[0m\]"       # Text Reset
Green="\[\033[0;32m\]"        # Green
Symbol="\[\033[01;33m\]"      # Symbol color
BPurple="\[\033[1;35m\]"      # Purple
UBlue="\[\033[4;34m\]"        # Blue
UPurple="\[\033[4;35m\]"      # Purple

# Various variables you might want for your PS1 prompt instead
Time24h="\A"
PathShort="\w"
NewLine="\n"
Username="\u"
Hostname="\H"

if [ "$color_prompt" = yes ]; then
    source /etc/bash_completion.d/git
    PS1=$NewLine$Symbol"┌──["$BPurple$Username$Symbol"]──["$UPurple$Hostname$Color_Off$Symbol"]"$Green'$(__git_ps1)'$NewLine$Color_Off$Symbol"│:"$PathShort$NewLine$Symbol"└──<"$Time24h">──$ "$Color_Off
else
    PS1='\u@\h:\w\$ '
fi
# ---



# LS_COLORS
#
# Bold          01
# Underline     04
# Black         30
# Red           31
# Green         32
# Orange        33
# Blue          34
# Purple        35
# Cyan          36
# Grey          37

LS_COLORS="di=01:ex=31:*.py=33"
export LS_COLORS


# MODULES
module load intel/18.0.3
module load python3.7-anaconda/2019.10
# ---
