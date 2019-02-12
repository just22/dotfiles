----------------------------------------------------------------------
#  $Id$
#
#  ~/.xinitrc is executed by xinit, usually invoked by
#  startx. It starts the GUI part of the session, typically
#  some GUI-related settings (key bindings, X resources,
#  etc.), and launches a window (or session) manager.
# ----------------------------------------------------------------------

# Set the default colorscheme and X resources
if ! colman set solarized-dark; then
        xrdb -load -I${HOME} ~/.Xresources
fi

# Set keyboard layout
setxkbmap it

# Make Caps Lock an additional ESC
setxkbmap -option caps:escape

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

# Reduce kbd repeat rate to 10 repeat/s (default: 25)
# (solves some slow scroll issues in Vim, when the
# whole screen redraw is involved)
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

# Put display in a known state
case "$(xrandr -q | grep -E "[0-9]+x[0-9]+\+[0-9]+\+[0-9]+" | head -n 1 | cut -d" " -f1)" in
LVDS*) dmenu-xrandr Off ;;
VGA*)  dmenu-xrandr Only ;;
esac

# Console log (launched again to match fonts and colorscheme)
xconsole -geometry 480x130-0-0 -daemon -notify -verbose -exitOnFail &

# Select the X session to start
DEFAULT_XSESSION_CMD=${DEFAULT_XSESSION_CMD-startfluxbox}
#SELECT_XSESSION=1

[ x$SELECT_XSESSION != "x" ] &&
if [ -e /usr/local/bin/Xdialog ]; then
        XSESSION_CMD=`Xdialog --buttons-style text                \
                              --no-close                          \
                              --no-cancel                         \
                              --no-tags                           \
                              --screen-center                     \
                              --stdout                            \
                              --menubox                           \
                                  "Select the X session"          \
                                  195x133                         \
                                  3                               \
                                  "startfluxbox"        "fluxbox" \
                                  "dwm-session"         "dwm"     \
                                  "twm"                 "twm"`
fi || XSESSION_CMD="$DEFAULT_XSESSION_CMD"

# Just to play it safe...
export XSESSION_CMD=${XSESSION_CMD:-twm}

# Remind daemon
if ! pgrep -x remind; then
        #remind -z -k'xmessage -center -title "Remind" -buttons "Ok" %s &' ~/.reminders &
        remind -z -k'remind-notify %s' ~/.reminders &
fi

# OfflineIMAP
force-mailbox-sync -q

# Set the root window background
xsetroot -solid rgb:58/6E/75

# Xscreensaver
#xscreensaver &

# Screen locker
xautolock -time 10 -locker slock &

# xidle daemon (corner locking virtually disabled, no timeout,
# activated by SIGUSR1)
if ! pgrep -u $UID -x xidle > /dev/null 2>&1; then
        xidle -delay 86400 -program ${HOME}/bin/xsession-lock &
fi

# Launch "Today's reminders" daemon
remind-today &

# Start any other required daemons, then the selected X session
case "$XSESSION_CMD" in
cwm|twm)

        # Status bar
        pkill -x dstat; (sleep 2; dstat trunk0 | dzen2-cust) &

        # Wallpaper setting
        [ -x ~/.fehbg ] && ~/.fehbg

        ;;

*)
        ;;

esac

# ...and finally start the X-Session!
exec $XSESSION_CMD
