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

PATH=/usr/local/bin:/usr/local/sbin
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/games
MANPATH=~/share/man:/usr/local/man:

# Include user's bin dir in PATH
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/bin.override" ] && PATH="$HOME/bin.override:$PATH"

# Include current dir in PATH (except for root user)
[ "${USER}" != root ] && PATH="${PATH}:."

export PATH MANPATH

# Maximum number of processes that make may have running
export MAKEFLAGS=-j3

# In console, colors and auto-logout
if [ "${TERM}" == "vt220" ]; then
    export TERM=pccon0
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

# par(1) settings
export PARINIT="rTbgqR B=.,?_A_a Q=_s>|"

# Autotools version env variables
export AUTOMAKE_VERSION=1.14
export AUTOCONF_VERSION=2.69

# Custom libraries
export PKG_CONFIG_PATH=${HOME}/lib/pkgconfig

# ----------------------------------------------------------------------
# Addenda to ~/.profile specific for machine/site
#
[ -f ~/.profile_local ] && . ~/.profile_local

