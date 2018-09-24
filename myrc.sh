#!/bin/bash
#
# Various bash aliases, prefernces and settings
# Needs to be sourced from .bashrc or similar
#


# PATH
export PATH=$PATH
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

alias ll='ls -lthX --color --group-directories-first'
alias la='ls -lthXa --color --group-directories-first'

alias up='~/scripts/up.sh'
alias xx='exit'
alias reup='~/scripts/up.sh; sudo reboot'

alias atom='sudo atom'

alias myrc='source ~/scripts/myrc.sh'

alias eth='ssh -X max@pc-richardson2.ethz.ch'
alias euler='ssh sallerm@euler.ethz.ch'

alias vi='vim'
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
    source /etc/bash_completion.d/git-prompt
    PS1=$NewLine$Symbol"┌──["$BPurple$Username$Symbol"]──["$UPurple$Hostname$Color_Off$Symbol"]"$Green'$(__git_ps1)'$NewLine$Color_Off$Symbol"│:"$PathShort$NewLine$Symbol"└──<"$Time24h">──$ "$Color_Off
else
    PS1='\u@\h:\w\$ '
fi
# ---



# LS_COLORS
LS_Bold="01"
LS_Underline="04"
LS_Black="30"	
LS_Red="31"	
LS_Green="32"	
LS_Orange="33"	
LS_Blue="34"	
LS_Purple="35"	
LS_Cyan="36"	
LS_Grey="37"	

LS_COLORS="di=${LS_Bold}:ex=${LS_Red}"
export LS_COLORS


