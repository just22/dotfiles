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
set -o csh-history

# ----------------------------------------------------------------------
# History settings
#
HISTFILE=${HOME}/.ksh_history
HISTSIZE=500
HISTCONTROL=ignorespace:ignoredups

# ----------------------------------------------------------------------
# The editor used by fc
#
export FCEDIT="vim"

# ----------------------------------------------------------------------
# Colored prompt, if the terminal has the capability
#

# Color support can be forced off setting NO_COLORS (to any values)
# This will influence file listing aliases' behavior too
#NO_COLORS=""

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
[ -f ~/.kshrc_local ] && . ~/.kshrc_local

# ----------------------------------------------------------------------
# Debug
#
#echo "~/.kshrc sourced"
