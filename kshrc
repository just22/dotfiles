# ----------------------------------------------------------------------
#  $RCSfile$
#
#  This file is sourced by all *interactive* ksh on startup,
#  including some apparently interactive shells such as scp and rcp
#  that can't tolerate any output.  So make sure this doesn't display
#  anything or bad things will happen!
#  It should contain stuff that applies only to ksh itself, such
#  as alias and function definitions, shell options and prompt settings
#
#  $Id$
#

# ----------------------------------------------------------------------
# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
#
if [[ $- != *i* ]]; then
    # Shell is non-interactive.  Be done now!
    return
fi


# ----------------------------------------------------------------------
# Enable a subset of csh-style history editing using the `!' character
#
set -o csh-history


# ----------------------------------------------------------------------
# Make history permanent
#
HISTFILE=${HOME}/.sh_history


# ----------------------------------------------------------------------
# Colored prompt, if the terminal has the capability
#
if [ -z ${NO_COLORS+x} ]; then
        if tput setaf 1 >/dev/null 2>&1; then
                # Assume that color support is compliant with Ecma-48
                # (ISO/IEC-6429); lack of such support is extremely rare, and such
                # a case would tend to support setf rather than setaf
                COLOR_SUPPORT=1

                # Color codes:
                # 0 -> Black
                # 1 -> Red
                # 2 -> Green
                # 3 -> Yellow
                # 4 -> Blue
                # 5 -> Magenta
                # 6 -> Cyan
                # 7 -> White
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

                REVERSE='$(tput rev)'
                BRIGHT='$(tput bold)'
                DEFAULT_COLOR='$(tput sgr0)'

                [ "$USER" == root ] && PS_USER_COLOR="${RED_FG}" || PS_USER_COLOR="$PS_HI_COLOR"
                PS1="\[${PS_USER_COLOR}\]\u\[${PS_NORM_COLOR}\]@\h:[\W]> \[${DEFAULT_COLOR}\]"

        elif tput setaf 1 - - >/dev/null 2>&1; then
                # OpenBSD tput specific requirement?
                # Meaning of 2^ and 3^ parameters?
                COLOR_SUPPORT=1

                BLACK_FG='$(tput setaf 0 - -)'
                RED_FG='$(tput setaf 1 - -)'
                GREEN_FG='$(tput setaf 2 - -)'
                YELLOW_FG='$(tput setaf 3 - -)'
                BLUE_FG='$(tput setaf 4 - -)'
                MAGENTA_FG='$(tput setaf 5 - -)'
                CYAN_FG='$(tput setaf 6 - -)'
                WHITE_FG='$(tput setaf 7 - -)'
                BLACK_BG='$(tput setab 0 - -)'
                RED_BG='$(tput setab 1 - -)'
                GREEN_BG='$(tput setab 2 - -)'
                YELLOW_BG='$(tput setab 3 - -)'
                BLUE_BG='$(tput setab 4 - -)'
                MAGENTA_BG='$(tput setab 5 - -)'
                CYAN_BG='$(tput setab 6 - -)'
                WHITE_BG='$(tput setab 7 - -)'

                REVERSE='$(tput rev)'
                BRIGHT='$(tput bold)'
                DEFAULT_COLOR='$(tput sgr0)'

                PS_HI_COLOR=$YELLOW_FG
                PS_NORM_COLOR=$BLUE_FG

                [ "$USER" == root ] && PS_USER_COLOR="${RED_FG}" || PS_USER_COLOR="$PS_HI_COLOR"
                PS1="\[${PS_USER_COLOR}\]\u\[${PS_NORM_COLOR}\]@\h:[\W]> \[${DEFAULT_COLOR}\]"
        else
                COLOR_SUPPORT=0
                PS1='\u@\h:[\w]\$ '
        fi
else
        COLOR_SUPPORT=0
        PS1='\u@\h:[\w]\$ '
fi


# ----------------------------------------------------------------------
# If this is an xterm, set the title to user@host:dir
#
case "$TERM" in
xterm*|screen*)
    PS1="\[\e]0;\u@\h:[\w]\a\]$PS1"
    ;;
*)
    ;;
esac


# ----------------------------------------------------------------------
# The editor used by fc
#
export FCEDIT="vim"


# ----------------------------------------------------------------------
# Aliases/functions definition
#
[ -e ~/.sh_aliases ] && . ~/.sh_aliases
