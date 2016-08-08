# ----------------------------------------------------------------------
#  $RCSfile$
#
#  Sourced by bash when it's invoked as login shell
#
#  $Id$
#

# ----------------------------------------------------------------------
# Source a sane default
#
if [ -f ~/.profile ]; then
    . ~/.profile
fi

# ----------------------------------------------------------------------
# Same config for login and non-login shells
#
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# ----------------------------------------------------------------------
# Debug
#
#echo "~/.bash_profile sourced"
