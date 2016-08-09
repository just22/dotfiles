# ----------------------------------------------------------------------
#  $Id$
#
#  ~/.bashrc: executed by bash(1) for non-login shells
#
#  This file is sourced by all *interactive* bash shells on startup,
#  including some apparently interactive shells such as scp and rcp
#  that can't tolerate any output.  So make sure this doesn't display
#  anything or bad things will happen!
#
#  It should contain stuff that applies only to bash itself, such
#  as alias and function definitions, shell options and prompt settings
# ----------------------------------------------------------------------

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]]; then
        # Shell is non-interactive.  Be done now!
        return
fi

# ----------------------------------------------------------------------
# Immediate notification when jobs change state
#
set -o notify

# ----------------------------------------------------------------------
# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#
shopt -s checkwinsize

# ----------------------------------------------------------------------
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#
shopt -s globstar

# ----------------------------------------------------------------------
# Enable extended pattern matching features
#
#shopt -s extglob

# ----------------------------------------------------------------------
# Don't exit the shell when EOF (Ctrl-d) is received as line first input
#
export IGNOREEOF=1000

# ----------------------------------------------------------------------
# No core dumps
#
ulimit -c 0

# ----------------------------------------------------------------------
# No autologout
#
TMOUT=0

# ----------------------------------------------------------------------
# Set some UTF8 strings if TERM support it
#
case "$TERM" in
xterm*|rxvt-unicode*|screen*|linux)
        U8_HSEP=" ─› "
        U8_PSHEAD_L1="┌──"
        U8_PSHEAD_L2="└─────›"
        U8_LASTOK="✓"
        U8_LASTFAIL="✗"
        ;;
*)
        ;;
esac

# ----------------------------------------------------------------------
# Set history
#
shopt -s histappend
HISTCONTROL=ignorespace:erasedups
HISTIGNORE="exit:?q"
HISTFILE=~/.bash_history
HISTSIZE=500
HISTFILESIZE=2000
HISTTIMEFORMAT="%d/%m %R${U8_HSEP-" -> "}"

# ----------------------------------------------------------------------
# The editor used by the fc command
#
export FCEDIT=vim

# ----------------------------------------------------------------------
# Prompt look
# (colored when the terminal has the capability)
#

# Color support can be forced off setting NO_COLORS (to any values)
# This will influence file listing aliases' behavior too
#NO_COLORS=""

# Count stopped jobs
sj() { jobs -s | wc -l | tr -d " "; }

set_prompt() {
        local LAST_EXIT="$?"

        if [ "$COLOR_SUPPORT" == 1 ]; then
                HICOL="$FG_YELLOW"
                NORMCOL="$FG_BLUE"
                [ $USER == root ] && USRCOL="$FG_RED" || USRCOL="$HICOL"
        fi

        PS1="${NORMCOL}${U8_PSHEAD_L1-"+--"}"                               # Cosmetic
        PS1=${PS1}"[${USRCOL}\u${NORMCOL}@\h]-"                             # user@hostname
        [ -n "$PRJ_REF" ] && PS1=${PS1}"[${HICOL}$PRJ_REF${NORMCOL}]-"      # Prj-ready shell?
        PS1=${PS1}"[$(sj)]-"                                                # No. of stopped jobs
        [ "$LAST_EXIT" != 0 ] &&
                PS1=${PS1}"[${HICOL}${U8_LASTFAIL-x}${NORMCOL}]-" ||
                PS1=${PS1}"[${U8_LASTOK-v}]-"                               # Last command exit status
        git rev-parse --git-dir > /dev/null 2>&1 &&
                PS1=${PS1}"[${HICOL}git${NORMCOL}]-"                        # In a git tree?
        ls ./CVS > /dev/null 2>&1 &&
                PS1=${PS1}"[${HICOL}cvs${NORMCOL}]-"                        # In a CVS tree?
        PS1=${PS1}"[\W]"                                                    # CWD basename
        PS1=${PS1}"\n${NORMCOL}${U8_PSHEAD_L2-"+----->"} ${RSTCOL}"         # Cosmetic

        # If this is an xterm, then set the title
        case "$TERM" in
        xterm*|rxvt-unicode*|screen*)
                PS1="\[\033]0;[\s] [\w] [Last cmd: \"$(history 1 | awk -v HS="${U8_HSEP-" -> "}" 'BEGIN{FS=HS} {print $2}')\"]\007\]"$PS1
                ;;
        *)
                ;;
        esac
}

if [ -z ${NO_COLORS+x} ] && [ $(tput colors) -ge 8 ]; then
        COLOR_SUPPORT=1

        # ANSI escape sequences for graphics mode
        # Color codes:
        # 0 -> Black
        # 1 -> Red
        # 2 -> Green
        # 3 -> Yellow
        # 4 -> Blue
        # 5 -> Magenta
        # 6 -> Cyan
        # 7 -> White

        #Text attributes
             RSTCOL="\[$(printf "\e[0m")\]"
               BOLD="\[$(printf "\e[1m")\]"
          UNDERLINE="\[$(printf "\e[4m")\]"
              BLINK="\[$(printf "\e[5m")\]"
            REVERSE="\[$(printf "\e[7m")\]"
          CONCEALED="\[$(printf "\e[8m")\]"

        #Foreground colors
          FG_BLACK="\[$(printf "\e[30m")\]"
            FG_RED="\[$(printf "\e[31m")\]"
          FG_GREEN="\[$(printf "\e[32m")\]"
         FG_YELLOW="\[$(printf "\e[33m")\]"
           FG_BLUE="\[$(printf "\e[34m")\]"
        FG_MAGENTA="\[$(printf "\e[35m")\]"
           FG_CYAN="\[$(printf "\e[36m")\]"
          FG_WHITE="\[$(printf "\e[37m")\]"

        #Background colors
          BG_BLACK="\[$(printf "\e[40m")\]"
            BG_RED="\[$(printf "\e[41m")\]"
          BG_GREEN="\[$(printf "\e[42m")\]"
         BG_YELLOW="\[$(printf "\e[43m")\]"
           BG_BLUE="\[$(printf "\e[44m")\]"
        BG_MAGENTA="\[$(printf "\e[45m")\]"
           BG_CYAN="\[$(printf "\e[46m")\]"
          BG_WHITE="\[$(printf "\e[47m")\]"
else
        COLOR_SUPPORT=0
fi

PROMPT_COMMAND=set_prompt

# ----------------------------------------------------------------------
# Aliases/functions definition
#
[ -f ~/.sh_aliases ]   && source ~/.sh_aliases
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# ----------------------------------------------------------------------
# Enable programmable completion features
#
if ! shopt -oq posix; then
        if [ -f /etc/profile.d/bash-completion.sh ]; then
                source /etc/profile.d/bash-completion.sh
        fi
fi

# ----------------------------------------------------------------------
# Show running command in the terminal title:
# http://mg.pov.lt/blog/bash-prompt.html
#
show_cmd_in_titlebar()
{
        case "$BASH_COMMAND" in
        *\033]0*|*\033]1*|*\033]2*)
                # Command is trying to set the title bar/icon name as well;
                # this is most likely the execution of $PROMPT_COMMAND.
                # In any case nested escapes confuse the terminal, so don't
                # output them
                ;;
        fg|set_prompt|exit)
                ;;
        *)
                case "$TERM" in
                xterm*|rxvt-unicode*)
                        printf "\033]0;[%s] [%s] [%s] [Running: \"%s\"]\007" "${TERM%%-*}" "${0##*/}" "$PWD" "$BASH_COMMAND"
                        ;;
                screen*)
                        printf "\033]0;[%s] [%s] [Running: \"%s\"]\007" "${0##*/}" "$PWD" "$BASH_COMMAND"
                        ;;
                *)
                        ;;
                esac
                ;;
        esac
}
trap show_cmd_in_titlebar DEBUG

# ----------------------------------------------------------------------
# Clear screen on exit
# Note: Commands in ~/.bash_logout are run only by login shells...
#
#trap clear EXIT

# ----------------------------------------------------------------------
# Vi mode, please!
#
set -o vi

# ----------------------------------------------------------------------
# Useful keybindings
#
bind -m vi-insert "\C-l":clear-screen
bind '\C-w:unix-filename-rubout'

# ----------------------------------------------------------------------
# Make C-w to delete back to the last /
#
stty werase undef

# ----------------------------------------------------------------------
# Addenda to ~/.bashrc specific for machine/site
#
[ -f ~/.bashrc_local ] && source ~/.bashrc_local

# ----------------------------------------------------------------------
# Debug
#
#echo "~/.bashrc sourced"
