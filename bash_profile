# ----------------------------------------------------------------------
# Source a sane default
#
#
if [ -e ~/.profile ]; then
    source ~/.profile
fi

# ----------------------------------------------------------------------
# Same config for login and non-login shells
#
#
if [ -e ~/.bashrc ]; then
    source ~/.bashrc
fi

# ----------------------------------------------------------------------
# Debug
#
#
#echo "~/.bash_profile sourced"
