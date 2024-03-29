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

# ----------------------------------------------------------------------
# Append last command to history file
#
PROMPT_COMMAND="history -a"

# ----------------------------------------------------------------------
# Aliases/functions definition
#
[ -f ~/.sh_aliases ]   && source ~/.sh_aliases
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# ----------------------------------------------------------------------
# Addenda to ~/.bashrc specific for machine/site
#
[ -f ~/.shrc_local ] && source ~/.shrc_local
[ -f ~/.bashrc_local ] && source ~/.bashrc_local

# ----------------------------------------------------------------------
# Print a random, hopefully interesting, adage
#
if which fortune > /dev/null 2>&1; then
        if which cowthink > /dev/null 2>&1; then
                fortune -as | cowthink
        else
                fortune -as
        fi
fi

# ----------------------------------------------------------------------
# Debug
#
#echo "~/.bashrc sourced"
