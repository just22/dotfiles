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
# When running in X and if TERM support it, set some UTF-8 strings
#
[ -n "$DISPLAY" ] && case "$XTERM_LOCALE" in
*UTF-8)
        UTF8_PS1=1
        UTF8_HSEP=" ─› "
        UTF8_PSHEAD_L1="┌──"
        UTF8_PSHEAD_L2="└─────›"
        UTF8_LASTOK="✓"
        UTF8_LASTFAIL="✗"
        ;;
*)
        UTF8_PS1=0
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
HISTTIMEFORMAT="%d/%m %R${UTF8_HSEP-" -> "}"

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
        [ $? -ne 0 ] &&
                LAST_EXIT="${HICOL}${UTF8_LASTFAIL-fail}${NORMCOL}" ||
                LAST_EXIT="${UTF8_LASTOK-ok}"

        if [ "$COLOR_SUPPORT" == 1 ]; then
                HICOL="$FG_YELLOW"
                NORMCOL="$FG_BLUE"
                [ $USER == root ] && USRCOL="$FG_RED" || USRCOL="$HICOL"
        fi

        if [ $UTF8_PS1 ]; then

                PS1="${NORMCOL}${UTF8_PSHEAD_L1}"                       # Cosmetic

                PS1=${PS1}"[${USRCOL}\u${NORMCOL}@\h]-"                 # user@hostname

                [ -n "$PRJ_REF" ] &&
                        PS1=${PS1}"[${HICOL}$PRJ_REF${NORMCOL}]-"       # Prj-ready shell?

                PS1=${PS1}"[$(sj)]-"                                    # No. of stopped jobs

                PS1=${PS1}"[$LAST_EXIT]-"                               # Last command exit status

                git rev-parse --git-dir > /dev/null 2>&1 &&
                        PS1=${PS1}"[${HICOL}git${NORMCOL}]-"            # In a git tree?

                ls ./CVS > /dev/null 2>&1 &&
                        PS1=${PS1}"[${HICOL}cvs${NORMCOL}]-"            # In a CVS tree?

                ls ./.SYNC > /dev/null 2>&1 &&
                        PS1=${PS1}"[${HICOL}dss${NORMCOL}]-"            # In a Synchronicity tree?

                PS1=${PS1}"[\W]"                                        # CWD basename

                PS1=${PS1}"\n${NORMCOL}${UTF8_PSHEAD_L2} ${RSTCOL}"     # Cosmetic

        else
                PS1="${NORMCOL}[${USRCOL}\u${NORMCOL}@\h]-"             # user@hostname
                PS1=${PS1}"[$LAST_EXIT]-"                               # Last command exit status
                PS1=${PS1}"[\W]> ${RSTCOL}"                             # CWD basename
        fi

        # If this is an xterm, then set the title
        [ -n "$DISPLAY" ] && case "$TERM" in
        xterm*|screen*)
                PS1="\[\033]0;[\s] [\w] [Last cmd: \"$(history 1 | awk -v HS="${UTF8_HSEP-" -> "}" 'BEGIN{FS=HS} {print $2}')\"]\007\]"$PS1
                ;;
        *)
                ;;
        esac
}

escseq() {
          ESC="\e"
         CODE="$1"
         printf "\[%s[%sm\]" $ESC $CODE
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

        # Text attributes
             RSTCOL="$(escseq  0)"
               BOLD="$(escseq  1)"
          UNDERLINE="$(escseq  4)"
              BLINK="$(escseq  5)"
            REVERSE="$(escseq  7)"
          CONCEALED="$(escseq  8)"

        # Foreground colors
           FG_BLACK="$(escseq 30)"
             FG_RED="$(escseq 31)"
           FG_GREEN="$(escseq 32)"
          FG_YELLOW="$(escseq 33)"
            FG_BLUE="$(escseq 34)"
         FG_MAGENTA="$(escseq 35)"
            FG_CYAN="$(escseq 36)"
           FG_WHITE="$(escseq 37)"

        # Background colors
           BG_BLACK="$(escseq 40)"
             BG_RED="$(escseq 41)"
           BG_GREEN="$(escseq 42)"
          BG_YELLOW="$(escseq 43)"
            BG_BLUE="$(escseq 44)"
         BG_MAGENTA="$(escseq 45)"
            BG_CYAN="$(escseq 46)"
           BG_WHITE="$(escseq 47)"
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
