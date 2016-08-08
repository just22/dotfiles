# ----------------------------------------------------------------------
#  $Id$
#
#  ~/.xinitrc is executed by xinit, usually invoked by
#  startx. It starts the GUI part of the session, typically
#  some GUI-related settings (key bindings, X resources,
#  etc.), and launches a window (or session) manager.
# ----------------------------------------------------------------------

# X apps default settings
xrdb -load -I${HOME} ~/.Xresources

# Set keyboard layout
setxkbmap it

# Enable h/v scrolling for touchpad
synclient VertEdgeScroll=1
synclient HorizEdgeScroll=1
synclient TapButton1="1"

# Grant local root user access to X server
xhost +si:localuser:root

# Root window background color (solarized theme)
#hsetroot -add '#073642' -add '#586E75' -gradient 0
xsetroot -solid rgb:58/6E/75

# Local fonts path
xset fp+ /usr/local/share/fonts/terminus
xset fp+ /usr/local/share/fonts/cantarell
xset fp+ /usr/local/share/fonts/Droid
xset fp+ /usr/local/share/ghostscript/fonts
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
    eval `dbus-launch --sh-syntax --exit-with-session`
fi

# Console log (launched again to match colorscheme)
#xconsole -geometry 480x130-0-0 -daemon -notify -verbose -exitOnFail &

# Select the X session to start
#DEFAULT_XSESSION_CMD="startxfce4 --with-ck-launch"
#DEFAULT_XSESSION_CMD="cwm"
DEFAULT_XSESSION_CMD="startfluxbox"
#DEFAULT_XSESSION_CMD="openbox-session"
#SELECT_XSESSION=1
[ x$SELECT_XSESSION != "x" ] &&
if [ -e /usr/local/bin/Xdialog ]; then
    XSESSION_CMD=`Xdialog \
                --buttons-style text \
                --no-close \
                --no-cancel \
                --no-tags \
                --screen-center \
                --stdout \
                --menubox \
                    "Select the X session" \
                    190x115 \
                    3 \
                    "startxfce4 --with-ck-launch"       "Xfce" \
                    "openbox-session"                   "Openbox" \
                    "cwm"                               "cwm"`
fi ||
XSESSION_CMD="$DEFAULT_XSESSION_CMD"

# System log
#pkill xconsole
xterm -title "System log" -e "tail -f /var/log/messages" &

# Process monitor
xterm -title "Process monitor" -e top &

# System statistics
xterm -title "System stats" -e systat &

# X screen reset and lock daemon (activated by SIGUSR1)
xscreen-reset &

# Reminder
if ! pgrep -x remind; then
        remind -z -k'xmessage -title "Remind" -buttons "Ok" %s &' ~/.reminders &
fi

# Start some useful tray apps
#/usr/local/libexec/tray-app/sound -i &

# Start any other required daemons, then the selected X session
case "$XSESSION_CMD" in
cwm)

        # xlock through xidle
        #xidle -delay 2 -nw -timeout 600 -program "xlock -mousemotion" &

        # Xscreensaver
        xscreensaver &

        # Compositor manager
        #xcompmgr &

        # Battery status check daemon
        check-batt-status &

        # Status bar
        statusbar &

        # Systray
        sleep 1; stalonetray &

        # HPLIP GUI
        hp-systray &

        ;;

"")
        XSESSION_CMD=twm
        ;;

esac

exec $XSESSION_CMD
