# ----------------------------------------------------------------------
#  $Id$
#
#  ~/.profile: sh/ksh initialization
#  Executed by the command interpreter for login shells.
#
#  User profile settings. This file is sourced from .xsession (which
#  is in turn sourced by XDM and login shells) and should contain
#  stuff that applies to your whole session, such as (non-graphycal)
#  programs that must be executed after login and environment variable
#  definitions.
# ----------------------------------------------------------------------

PATH="/usr/local/bin:/usr/local/sbin"
PATH="$PATH:/bin:/sbin:/usr/X11R6/bin:/usr/bin:/usr/sbin:/usr/games"

# Set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
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

# Localization (in X, always enable UTF-8 encoding)
if [ -n "$DISPLAY" ]; then
        export LC_CTYPE="en_US.UTF-8"
        export LC_NUMERIC="en_GB.UTF-8"
        export LC_TIME="en_GB.UTF-8"
        export LC_COLLATE="en_GB.UTF-8"
        export LC_MONETARY="en_GB.UTF-8"
        export LC_MESSAGES="en_GB.UTF-8"
        export LC_PAPER="en_GB.UTF-8"
        export LC_NAME="en_GB.UTF-8"
        export LC_ADDRESS="en_GB.UTF-8"
        export LC_TELEPHONE="en_GB.UTF-8"
        export LC_MEASUREMENT="en_GB.UTF-8"
        export LC_IDENTIFICATION="en_GB.UTF-8"
        export LC_ALL=
fi

# Note: Default pager/editor/browser definitions moved here because
#       there are applications launched from X using them

# Default pager
PAGER=less
LESS="-M -i -X -R -c"
export PAGER LESS
[ -x /usr/bin/lesspipe ] && export LESSOPEN="|lesspipe.sh %s"

# Default editor
export EDITOR=vi
export VISUAL=vi

# Default browser and mail client
if [ -n "$DISPLAY" ]; then
        BROWSER=x-web-browser
        MAILER=x-email-client
else
        BROWSER=web-browser
        MAILER=email-client
fi
export BROWSER MAILER

# Default printer
export PRINTER=HP_Deskjet_1510

# Interactive shells startup file
[ "${SHELL%/ksh}" != "$SHELL" ] || [ -n "$KSH_VERSION" ] &&
        export ENV="$HOME/.kshrc"

# CPAN local modules config
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"

# par(1) settings
export PARINIT="rTbgqR B=.,?_A_a Q=_s>|"

# Autotools version env variables
export AUTOMAKE_VERSION=1.14
export AUTOCONF_VERSION=2.69

# Custom libraries
export PKG_CONFIG_PATH=${HOME}/lib/pkgconfig

# Append custom man paths to the standard ones
export MANPATH=~/share/man:/usr/local/man:~/perl5/man:

# Proxy settings
#export http_proxy="http://argo.atlantide.priv:8118"
#export no_proxy="http://argo.atlantide.priv:8118"

# ----------------------------------------------------------------------
# Addenda to ~/.profile specific for machine/site
#
[ -f ~/.profile_local ] && . ~/.profile_local

