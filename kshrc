# ----------------------------------------------------------------------
#  $Id$
#
#  This file is sourced by all *interactive* ksh on startup,
#  including some apparently interactive shells such as scp and rcp
#  that can't tolerate any output.  So make sure this doesn't display
#  anything or bad things will happen!
#  It should contain stuff that applies only to ksh itself, such
#  as alias and function definitions, shell options and prompt settings
# ----------------------------------------------------------------------

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
[[ "$KSH_VERSION" == *PD* ]] && set -o csh-history

# ----------------------------------------------------------------------
# History settings
#
HISTFILE=${HOME}/.ksh_history
HISTSIZE=500
HISTCONTROL=ignorespace:ignoredups

# ----------------------------------------------------------------------
# Clean-up /tmp on exit
#
trap "rm -f /tmp/*.$$" EXIT

# Color support can be forced off setting NO_COLORS (to any values)
# This will influence prompt and file listing aliases' behavior
#NO_COLORS=""
[ -f ~/.sh_colors ] && . ~/.sh_colors

# ----------------------------------------------------------------------
# Prompt look
#
[ -f ~/.sh_prompt ] && . ~/.sh_prompt

# ----------------------------------------------------------------------
# Aliases/functions definition
#
[ -e ~/.sh_aliases ] && . ~/.sh_aliases
[ -e ~/.ksh_aliases ] && . ~/.ksh_aliases

# ----------------------------------------------------------------------
# Addenda to ~/.kshrc specific for machine/site
#
[ -f ~/.shrc_local ] && . ~/.shrc_local
[ -f ~/.kshrc_local ] && . ~/.kshrc_local

# ------------------------------------------------------------------
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
#echo "~/.kshrc sourced"
