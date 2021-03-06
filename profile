# sh/ksh initialization

# ~/.profile: executed by the command interpreter for login shells.
#
# User profile settings. This file is sourced from .xsession (which is in
# turn sourced by XDM and login shells) and should contain stuff that
# applies to your whole session, such as (non-graphycal) programs that must
# be executed after login and environment variable definitions

# Clear screen on logout
trap "clear" 0

# R/X permissions to group members, none to others
# Note: too problematic... Temporarely switching to default
#umask 027
umask 022

# Set PATH so it includes user's private bin if it exists
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/games:/usr/local/bin:/usr/local/sbin:/usr/local/jre-1.7.0/bin
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ "${USER}" != root ]; then
    PATH="${PATH}:."
fi
export PATH

# Maximum number of processes that make may have running
export MAKEFLAGS=-j3

# In console, colors and auto-logout
if [ "${TERM}" == "vt220" ]; then
    export TERM=wsvt25
    console-logout &
fi

# Locale settings
export LANG=en_GB.UTF-8
export LC_CTYPE=en_GB.UTF-8


# Note: Default pager/editor/browser definitions moved here because
#       there are applications launched from X using them

# Default pager
export PAGER=less
#LESS="--no-init --quit-if-one-screen --RAW-CONTROL-CHARS"
#LESS="--no-init --RAW-CONTROL-CHARS"
export LESS="-M -i -X -F -R"
[ -x /usr/bin/lesspipe ] && export LESSOPEN="|lesspipe.sh %s"

# Default editor
export EDITOR=vim
export VISUAL=vim

# Default browser
export BROWSER=surf-launcher

# Interactive shells startup file
case $SHELL in
*ksh*)
        [ -e $HOME/.kshrc ] && export ENV=$HOME/.kshrc
        ;;
*bash*)
        [ -e $HOME/.bashrc ] && source $HOME/.bashrc
        ;;
*)
        ;;
esac

# CPAN local modules config
export PERL_MB_OPT="--install_base \"/home/just22/perl5\""
export PERL_MM_OPT="INSTALL_BASE=/home/just22/perl5"
export PERL5LIB="${HOME}/perl5/lib/perl5:${HOME}/.fvwm/perllib:${PERL5LIB}"

# Autotools version env variables
export AUTOMAKE_VERSION=1.14
export AUTOCONF_VERSION=2.69

# Custom libraries
export PKG_CONFIG_PATH=${HOME}/lib/pkgconfig

# Proxy settings
export http_proxy="http://argo.atlantide.net:8118"
