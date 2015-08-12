# $Id$

# ---------------------------------------------------------------------
#
# ~/.kshrc: sourced by ksh(1) for interactive shells
#
#
# This file is sourced by all *interactive* ksh on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen!
#
# It should contain stuff that applies only to ksh itself, such
# as alias and function definitions, shell options and prompt settings


# ---------------------------------------------------------------------
#
# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
#
#
if [[ $- != *i* ]]; then
    # Shell is non-interactive.  Be done now!
    return
fi


# ---------------------------------------------------------------------
# Enable a subset of csh-style history editing using the `!' character
#
#
set -o csh-history


# ---------------------------------------------------------------------
# Make history permanent
#
#
HISTFILE=${HOME}/.sh_history


# ---------------------------------------------------------------------
# Colored prompt, if the terminal has the capability
#
#
if [ -x /usr/bin/tput ] && tput setaf 1 >/dev/null 2>&1; then
    # Assume that color support is compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    # Color codes:
    # 0 -> Black
    # 1 -> Red
    # 2 -> Green
    # 3 -> Yellow
    # 4 -> Blue
    # 5 -> Magenta
    # 6 -> Cyan
    # 7 -> White
    COLOR_SUPPORT=1
    BLACK_FG='$(tput setaf 0)'
    RED_FG='$(tput setaf 1)'
    GREEN_FG='$(tput setaf 2)'
    YELLOW_FG='$(tput setaf 3)'
    BLUE_FG='$(tput setaf 4)'
    MAGENTA_FG='$(tput setaf 5)'
    CYAN_FG='$(tput setaf 6)'
    WHITE_FG='$(tput setaf 7)'
    BLACK_BG='$(tput setab 0)'
    RED_BG='$(tput setab 1)'
    GREEN_BG='$(tput setab 2)'
    YELLOW_BG='$(tput setab 3)'
    BLUE_BG='$(tput setab 4)'
    MAGENTA_BG='$(tput setab 5)'
    CYAN_BG='$(tput setab 6)'
    WHITE_BG='$(tput setab 7)'
    BRIGHT='$(tput bold)'
    DEFAULT='$(tput sgr0)'
    [[ $USER == root ]] && COLOR="${RED_FG}" || COLOR="${BLUE_FG}"
    PS1="\[${COLOR}\]\u\[${DEFAULT}\]@\h:[\W]> "
else
    COLOR_SUPPORT=0
    PS1='\u@\h:[\w]\$ '
fi


# ---------------------------------------------------------------------
# If this is an xterm, set the title to user@host:dir
#
#
case "$TERM" in
xterm*|screen*)
    PS1="\[\e]0;\u@\h:[\w]\a\]$PS1"
    ;;
*)
    ;;
esac


# ---------------------------------------------------------------------
# The editor used by the fc command
#
#
export FCEDIT="vim"

# ---------------------------------------------------------------------
# Aliases/functions definition
#
#

# Enable color support
if [ "$COLOR_SUPPORT" == 1 ] && [ -x /usr/local/bin/colorls ]; then
    LSCOLORS="exfxcxdxbxgxDxBxGxCbCx"; export LSCOLORS
    alias l='colorls -Gh'
else
    alias l='ls -Fh'
fi

# List files
alias la='l -A'

alias ll='l -l'
llm () { ll "$@" | less; }
alias llt='ll -tr'
lltm () { llt "$@" | less; }
alias lltc='llt -c'
lltcm () { lltc "$@" | less; }

alias lla='ll -A'
llam () { lla "$@" | less; }
alias llat='lla -tr'
llatm () { llat "$@" | less; }
alias llatc='llat -c'
llatcm () { llatc "$@" | less; }

# Safe file operations
alias rmf='/bin/rm -rf'
alias rm='/bin/rm -i'
alias cp='/bin/cp -ip'
alias mv='/bin/mv -i'

# Push dir commands
pd () { pushd "$@" > /dev/null; }
alias lpd='dirs -v'
alias cpd='dirs -c'

# History
alias h='history | sort -k2 -u | sort -n -k1 | tail -25'
alias hgrep='history | egrep'
alias v='fc -e vim'

# Calendar
alias cal='cal -mw'
alias now='date "+%a %d %b %Y %Z (WK%g%V) - %H:%M"'

# Calc
calc (){ echo "scale=3; $@" | bc; }
d2h () { echo "ibase=10; obase=16; $1" | bc; }
d2o () { echo "ibase=10; obase=8;  $1" | bc; }
d2b () { echo "ibase=10; obase=2;  $1" | bc; }
o2h () { echo "ibase=8;  obase=16; $1" | bc; }
o2d () { echo "ibase=8;  obase=10; $1" | bc; }
o2b () { echo "ibase=8;  obase=2;  $1" | bc; }
b2h () { echo "ibase=2;  obase=16; $1" | bc; }
b2o () { echo "ibase=2;  obase=8;  $1" | bc; }
b2d () { echo "ibase=2;  obase=10; $1" | bc; }
h2b () { echo "ibase=16; obase=2;  $1" | bc; }
h2o () { echo "ibase=16; obase=8;  $1" | bc; }
h2d () { echo "ibase=16; obase=10; $1" | bc; }

# Power management (sudo not needed when user is part of the operator group)
alias reboot='/sbin/shutdown -r now'
alias halt='/sbin/shutdown -h now'
alias poweroff='/sbin/shutdown -hp now'

# Various
alias c='clear'
alias se='/usr/bin/sudoedit'
alias cutf='tr -s "\t" " " | sed "s/^ //" | cut -d" " -f'
alias rs='rsync -ah --progress'
alias lk='clear; lock -pn'
alias xcdroast='xcdroast -n -f /dev/rcd0c'
alias xfce4-panel-restart='dbus-send --print-reply --dest=org.xfce.Panel /org/xfce/Panel org.xfce.Panel.Terminate boolean:true'
#elinks () { STY= `which elinks` $*; echo -ne "\\033]0\;\\007"; }
#brokenln () { [ -z "$1" ] && sp="./" || sp="$1"; find -L $sp -maxdepth 1 -type l -ls; unset sp; }

# Disable KVM support for qemu
#alias qemu-kvm='qemu-kvm --no-kvm'
#alias qemu-system-i386='qemu-system-i386 --no-kvm'
#alias qemu-system-x86_64='qemu-system-x86_64 --no-kvm'

# External monitors management
alias vga-left='xrandr --output LVDS1 --auto --output VGA1 --auto --left-of LVDS1'
alias vga-right='xrandr --output LVDS1 --auto --output VGA1 --auto --right-of LVDS1'
alias vga-below='xrandr --output LVDS1 --auto --output VGA1 --auto --below LVDS1'
alias vga-above='xrandr --output LVDS1 --auto --output VGA1 --auto --above LVDS1'
alias vga-only='xrandr --output LVDS1 --off --output VGA1 --auto'
alias lvds-only='xrandr --output LVDS1 --auto --output VGA1 --off'
alias restore-lvds='~/bin/wsswitch 5; xrandr --output LVDS1 --auto --output VGA1 --off'

# Package management
alias pkga='/usr/bin/sudo pkg_add -iv'
alias pkgas='pkg_add -ivs'
alias pkgar='/usr/bin/sudo pkg_add -ivr'
alias pkgau='/usr/bin/sudo pkg_add -ivu'
alias pkgd='/usr/bin/sudo pkg_delete -v'
alias pkgds='pkg_delete -vs'
alias pkgda='/usr/bin/sudo pkg_delete -a'
alias pkgdas='pkg_delete -as'

# FS mounts
alias mount_datavol01='mount -t nfs -o rw,nodev,nosuid,noexec argo:/srv/nfs4/datavol01 ~/media/datavol01'

# Adding local man pages to default search path
alias man='man -m ${HOME}/share/man/'

