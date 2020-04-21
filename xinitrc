# ----------------------------------------------------------------------
#  $Id$
#
#  ~/.xinitrc is executed by xinit, usually invoked by startx. It starts
#  the GUI part of the session, typically some GUI-related settings (key
#  bindings, X resources, etc.), and launches a window (or session)
#  manager.
# ----------------------------------------------------------------------

# Set the default colorscheme and X resources
if ! colman set solarized-dark; then
        xrdb -load -I${HOME} ~/.Xresources
fi

# Set keyboard layout, setxkbmap -option caps:none
setxkbmap -layout it,us -option grp:shift_caps_toggle -option caps:none

# Enable h/v scrolling for touchpad
#synclient VertEdgeScroll=1
#synclient HorizEdgeScroll=1
#synclient TapButton1="1"

# Grant local root user access to X server
xhost +si:localuser:root

# Root window background color (solarized theme)
#hsetroot -add '#073642' -add '#586E75' -gradient 0
xsetroot -solid rgb:58/6E/75

# Local fonts path
xset fp+ /usr/local/share/fonts/terminus
xset fp+ /usr/local/share/fonts/cantarell
xset fp+ ~/.fonts/stlarch
xset fp rehash

# Reduce kbd repeat rate to 10 repeat/s (default: 25) (solves some slow
# scroll issues in Vim, when the whole screen redraw is involved)
#xset r rate 660 16

# Disable DPMS (Energy Star) features
xset -dpms
xset s off

# Turn off the bell
xset b off

# Clean-up user's tmp directory
rm -rf ${HOME}/tmp
mkdir -m 1777 ${HOME}/tmp

# Start a session bus instance of dbus-daemon
if [ -x /usr/local/bin/dbus-launch -a -z "${DBUS_SESSION_BUS_ADDRESS}" ]; then
        eval `dbus-launch --sh-syntax --exit-with-x11`
fi

# Console log (launched again to match fonts and colorscheme)
# xconsole -geometry 480x130-0-0 -daemon -notify -verbose -exitOnFail &
pkill xconsole

# Remind daemon
if ! pgrep -x remind; then
        #remind -z -k'xmessage -center -title "Remind" -buttons "Ok" %s &' ~/.reminders &
        remind -z -k'remind-notify %s' ~/.reminders &
fi

# Screen locker
xautolock -time 10 -locker slock &

# xidle daemon (corner locking virtually disabled, no timeout,
# activated by SIGUSR1)
if ! pgrep -u $UID -x xidle > /dev/null 2>&1; then
        xidle -delay 86400 -program ${HOME}/bin/xsession-lock &
fi

# Launch "Today's reminders" daemon
remind-today &

# Reload the gpg-agent (reset cached GnuPG credentials)
gpg-connect-agent reloadagent /bye

# Start IMAP IDLE connections and new msg notifications
pkill -KILL -fl imap-watcher
pkill -KILL -fl imap-idle.pl
imap-watcher &

pkill -KILL inotifywait
dir-watch -c notify-new-msg -d ~/mail/sandro.delaurenzis-gmail/INBOX/new &
dir-watch -c notify-new-msg -d ~/mail/just22-atlantide/INBOX/new &
dir-watch -c notify-new-msg -d ~/mail/just22-atlantide/lists/OpenBSD/bugs/new &
dir-watch -c notify-new-msg -d ~/mail/just22-atlantide/lists/OpenBSD/misc/new &
dir-watch -c notify-new-msg -d ~/mail/just22-atlantide/lists/OpenBSD/ports/new &
dir-watch -c notify-new-msg -d ~/mail/just22-atlantide/lists/OpenBSD/tech/new &

# ...and finally start the X-Session!
[ -x ~/.start-xsession ] && exec ~/.start-xsession || exec twm

