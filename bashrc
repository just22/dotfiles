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
# No core dumps
#
ulimit -c 0

# ----------------------------------------------------------------------
# Vi mode, please!
#
set -o vi

# ----------------------------------------------------------------------
# The editor used by the fc command
#
if vim --version > /dev/null; then
        FCEDIT=vim
else
        FCEDIT=vi
fi
export FCEDIT

# ----------------------------------------------------------------------
# Don't exit the shell when EOF (Ctrl-d) is received as line first input
#
export IGNOREEOF=1000

# ----------------------------------------------------------------------
# No autologout
#
TMOUT=0

# ----------------------------------------------------------------------
# History settings
#
shopt -s histappend
HISTFILE=~/.bash_history
HISTSIZE=-1
HISTFILESIZE=101
HISTCONTROL=ignorespace:ignoredups
HISTIGNORE="exit:\:q"
HISTTIMEFORMAT="%d/%m %R -> "

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
# Enable programmable completion features
#
if ! shopt -oq posix; then
        if [ -f /etc/profile.d/bash-completion.sh ]; then
                source /etc/profile.d/bash-completion.sh
        fi
fi

# ----------------------------------------------------------------------
# Actions to be taken on new command run
#
act_on_cmd()
{
        # Show running command in the terminal title:
        # http://mg.pov.lt/blog/bash-prompt.html
        case "$BASH_COMMAND" in
        *\033]0*|*\033]1*|*\033]2*)
                # Command is trying to set the title bar/icon name as well;
                # this is most likely the execution of $PROMPT_COMMAND.
                # In any case nested escapes confuse the terminal, so don't
                # output them
                ;;
        fg|exit)
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

        # Update $HISTFILE on-the-fly
        history -a
}
trap act_on_cmd DEBUG

# ----------------------------------------------------------------------
# Clean-up /tmp on exit
# Note: Commands in ~/.bash_logout are run only by login shells...
#
trap "rm -f /tmp/*.$$" EXIT

# ----------------------------------------------------------------------
# Color support can be forced off setting NO_COLORS (to any values)
# This will influence prompt and file listing aliases' behavior
#NO_COLORS=
[ -f ~/.sh_colors ] && source ~/.sh_colors

# ----------------------------------------------------------------------
# Prompt look
#
[ -f ~/.sh_prompt ] && source ~/.sh_prompt

# If this is an xterm, then set the title
PS1="${PS1}\[\033]0;[\s-\v] [\w] [Last cmd: \"\$(fc -l | awk 'END{print $2}')\"]\007\]"

# ----------------------------------------------------------------------
# Aliases/functions definition
#
[ -f ~/.sh_aliases ]   && source ~/.sh_aliases
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# ----------------------------------------------------------------------
# Addenda to ~/.bashrc specific for machine/site
#
[ -f ~/.bashrc_local ] && source ~/.bashrc_local

# ----------------------------------------------------------------------
# Debug
#
#echo "~/.bashrc sourced"
