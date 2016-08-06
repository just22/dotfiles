# ~/.bashrc: executed by bash(1) for non-login shells

# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen!

# This file should contain stuff that applies only to bash itself, such
# as alias and function definitions, shell options and prompt settings
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
#
#shopt -s extglob

# ----------------------------------------------------------------------
# Don't exit the shell when EOF (Ctrl-d) is received as line first input
#
#
export IGNOREEOF=1000

# ----------------------------------------------------------------------
# No core dumps
#
#
ulimit -c 0

# ----------------------------------------------------------------------
# No autologout
#
#
TMOUT=0

# ----------------------------------------------------------------------
# Set some UTF8 strings if TERM support it
#
#
case "$TERM" in
    xterm*|screen*|eterm*|linux)
        UTF8_HISTSEPARATOR=" ─› "
        UTF8_PS_1STLINE_HEADER="┌──"
        UTF8_PS_2NDLINE_HEADER="└─────›"
        UTF8_LAST_OK="✓"
        UTF8_LAST_FAILED="✗"
        ;;
    *)
        ;;
esac

# ----------------------------------------------------------------------
# Set history
#
#
shopt -s histappend
#HISTCONTROL=ignoreboth
HISTCONTROL=ignorespace:erasedups
HISTIGNORE="exit:?q"
HISTFILE=~/.bash_history
HISTSIZE=500
HISTFILESIZE=2000
HISTTIMEFORMAT="%d/%m %R${UTF8_HISTSEPARATOR-" -> "}"

# ----------------------------------------------------------------------
# The editor used by the fc command
#
#
export FCEDIT=vim

# ----------------------------------------------------------------------
# Prompt look
# (colored when the terminal has the capability)
#

# Note: Color support can be forced off setting NO_COLORS (to any values)
#       This will influence file listing aliases' behavior too
#NO_COLORS=""

# Count stopped jobs
sj() { jobs -s | wc -l | tr -d " "; }

set_prompt() {
    local LAST_EXIT="$?"

    if [ "$COLOR_SUPPORT" == 1 ]; then
        PS_HI_COLOR=$FG_YELLOW
        PS_NORM_COLOR=$FG_BLUE
        [ $USER == root ] && PS_USER_COLOR="${FG_RED}" || PS_USER_COLOR="$PS_HI_COLOR"
    fi

    #PS1="\[${PS_NORM_COLOR}\]${UTF8_PS_1STLINE_HEADER-"+--"}"                                   # Cosmetic
    #PS1=${PS1}"[\[${PS_USER_COLOR}\]\u\[${PS_NORM_COLOR}\]@\h]-"                                # user@hostname
    ##PS1=${PS1}"$([ -n "$TMUX" ] && echo "[tmux]-")"                                            # tmux session?
    ##PS1=${PS1}"[\s]-"                                                                          # Shell
    #[ -n "$PRJ_REF" ] && PS1=${PS1}"[${PS_HI_COLOR}$PRJ_REF${PS_NORM_COLOR}]-"                  # Is the shell configured for a project?
    ##PS1=${PS1}"[\j]-"                                                                          # No. of managed jobs
    #PS1=${PS1}"[$(sj)]-"                                                                        # No. of stopped jobs
    #[ "$LAST_EXIT" != 0 ] &&
    #    PS1=${PS1}"[${PS_HI_COLOR}${UTF8_LAST_FAILED-x}${PS_NORM_COLOR}]-" ||
    #    PS1=${PS1}"[${UTF8_LAST_OK-v}]-"                                                        # Last command exit status
    #git rev-parse --git-dir > /dev/null 2>&1 &&
    #    PS1=${PS1}"[${PS_HI_COLOR}git${PS_NORM_COLOR}]-"                                        # In a git tree?
    #PS1=${PS1}"[\W]"                                                                            # Basename of current directory
    #PS1=${PS1}"\n\[${PS_NORM_COLOR}\]${UTF8_PS_2NDLINE_HEADER-"+----->"} \[${DEFAULT_COLOR}\]"  # Cosmetic
    PS1="${PS_NORM_COLOR}${UTF8_PS_1STLINE_HEADER-"+--"}"                                       # Cosmetic
    PS1=${PS1}"[${PS_USER_COLOR}\u${PS_NORM_COLOR}@\h]-"                                        # user@hostname
    #PS1=${PS1}"$([ -n "$TMUX" ] && echo "[tmux]-")"                                            # tmux session?
    #PS1=${PS1}"[\s]-"                                                                          # Shell
    [ -n "$PRJ_REF" ] && PS1=${PS1}"[${PS_HI_COLOR}$PRJ_REF${PS_NORM_COLOR}]-"                  # Is the shell configured for a project?
    #PS1=${PS1}"[\j]-"                                                                          # No. of managed jobs
    PS1=${PS1}"[$(sj)]-"                                                                        # No. of stopped jobs
    [ "$LAST_EXIT" != 0 ] &&
        PS1=${PS1}"[${PS_HI_COLOR}${UTF8_LAST_FAILED-x}${PS_NORM_COLOR}]-" ||
        PS1=${PS1}"[${UTF8_LAST_OK-v}]-"                                                        # Last command exit status
    git rev-parse --git-dir > /dev/null 2>&1 &&
        PS1=${PS1}"[${PS_HI_COLOR}git${PS_NORM_COLOR}]-"                                        # In a git tree?
    PS1=${PS1}"[\W]"                                                                            # Basename of current directory
    PS1=${PS1}"\n${PS_NORM_COLOR}${UTF8_PS_2NDLINE_HEADER-"+----->"} ${RESET_COLOR}"            # Cosmetic

    # If this is an xterm, then set the title
    case "$TERM" in
        xterm*|screen*)
            #[${TERM%%-*}]
            PS1="\[\033]0;[\s] [\w] [Last cmd: \"$(history 1 | awk -v HS="${UTF8_HISTSEPARATOR-" -> "}" 'BEGIN{FS=HS} {print $2}')\"]\007\]"$PS1
            ;;
        *)
            ;;
    esac
}

#if [ -z ${NO_COLORS+x} ] && tput setaf 1 >/dev/null 2>&1; then
    # Assume that color support is compliant with Ecma-48
    # (ISO/IEC-6429); lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf

    # Color codes:
    # 0 -> Black
    # 1 -> Red
    # 2 -> Green
    # 3 -> Yellow
    # 4 -> Blue
    # 5 -> Magenta
    # 6 -> Cyan
    # 7 -> White
    #BLACK_FG='$(tput setaf 0)'
    #RED_FG='$(tput setaf 1)'
    #GREEN_FG='$(tput setaf 2)'
    #YELLOW_FG='$(tput setaf 3)'
    #BLUE_FG='$(tput setaf 4)'
    #MAGENTA_FG='$(tput setaf 5)'
    #CYAN_FG='$(tput setaf 6)'
    #WHITE_FG='$(tput setaf 7)'
    #BLACK_BG='$(tput setab 0)'
    #RED_BG='$(tput setab 1)'
    #GREEN_BG='$(tput setab 2)'
    #YELLOW_BG='$(tput setab 3)'
    #BLUE_BG='$(tput setab 4)'
    #MAGENTA_BG='$(tput setab 5)'
    #CYAN_BG='$(tput setab 6)'
    #WHITE_BG='$(tput setab 7)'
    #
    #REVERSE='$(tput rev)'
    #BRIGHT='$(tput bold)'
    #DEFAULT_COLOR='$(tput sgr0)'

# Giving up using tput...
if [ -z ${NO_COLORS+x} ] && [ $(tput color) -ge 8 ]; then
    COLOR_SUPPORT=1

    # ANSI escape sequences for graphics mode
    #
    #Text attributes
    RESET_COLOR="\[$(printf "\e[0m")\]"
    BOLD="\[$(printf "\e[1m")\]"
    UNDERSCORE="\[$(printf "\e[4m")\]"
    BLINK="\[$(printf "\e[5m")\]"
    REVERSE="\[$(printf "\e[7m")\]"
    CONCEALED="\[$(printf "\e[8m")\]"
    #
    #Foreground colors
    FG_BLACK="\[$(printf "\e[30m")\]"
    FG_RED="\[$(printf "\e[31m")\]"
    FG_GREEN="\[$(printf "\e[32m")\]"
    FG_YELLOW="\[$(printf "\e[33m")\]"
    FG_BLUE="\[$(printf "\e[34m")\]"
    FG_MAGENTA="\[$(printf "\e[35m")\]"
    FG_CYAN="\[$(printf "\e[36m")\]"
    FG_WHITE="\[$(printf "\e[37m")\]"
    #
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
#
if [ -f ~/.sh_aliases ]; then
    source ~/.sh_aliases
fi
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# ----------------------------------------------------------------------
# Enable programmable completion features
#
#
if ! shopt -oq posix; then
  if [ -f /etc/profile.d/bash-completion.sh ]; then
    source /etc/profile.d/bash-completion.sh
  fi
fi

# ----------------------------------------------------------------------
# Show the running command in the terminal title:
# http://mg.pov.lt/blog/bash-prompt.html
#
show_command_in_title_bar()
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
                xterm*)
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
trap show_command_in_title_bar DEBUG

# ----------------------------------------------------------------------
# Clear screen on exit
# Note: Commands in ~/.bash_logout are run only by login shells...
#
#trap clear EXIT

# ----------------------------------------------------------------------
# Vi mode, please!
#
#
set -o vi

# ----------------------------------------------------------------------
# Useful keybindings
#
#
bind -m vi-insert "\C-l":clear-screen
bind '\C-w:unix-filename-rubout'

# ----------------------------------------------------------------------
# Make C-w to delete back to the last /
#
#
stty werase undef

# ----------------------------------------------------------------------
# Addenda to ~/.bashrc specific for machine/site
#
#
if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi

# ----------------------------------------------------------------------
# Debug
#
#
#echo "~/.bashrc sourced"
