# ----------------------------------------------------------------------
#  $Id$
#
#  ~/.xsession is invoked by XDM (and by other display manager when
#  "custom" session is selected)
# ----------------------------------------------------------------------

# Source custom profile
[ -f ~/.profile ] && . ~/.profile

# Source .xinitrc (or launch twm)
[ -f ~/.xinitrc ] && . ~/.xinitrc || exec twm
