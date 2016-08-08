# ----------------------------------------------------------------------
#  File:        $RCSfile$
#  Purpose:     ~/.xsession is invoked by XDM (and by other display
#               manager when the "custom" session is selected).
#  Revision:    $Id$
# ----------------------------------------------------------------------

# Source custom profile
[ -f ~/.profile] && . ~/.profile

# Source .xinitrc (or launch twm)
[ -f ~/.xinitrc ] && . ~/.xinitrc || exec twm
