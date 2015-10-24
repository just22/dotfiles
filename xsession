# X apps default settings
xrdb -load  ~/.Xresources
xrdb -merge ~/.Xresources.defaultColorScheme

# Set keyboard layout
setxkbmap it

# Enable h/v scrolling for touchpad
synclient VertEdgeScroll=1
synclient HorizEdgeScroll=1
synclient TapButton1="1"

# Grant local root user access to X server
xhost +si:localuser:root

# Root window background color (solarized theme)
#xsetroot -solid rgb:07/36/42
xsetroot -solid rgb:58/6E/75
#hsetroot -add '#073642' -add '#586E75' -gradient 0


# Local fonts path
xset fp+ /usr/local/share/fonts/terminus
xset fp+ /usr/local/share/fonts/cantarell
xset fp+ /usr/local/share/ghostscript/fonts
xset fp+ ~/.fonts
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


# Source custom profile
. ~/.profile

# Start a session bus instance of dbus-daemon
if [ -x /usr/local/bin/dbus-launch -a -z "${DBUS_SESSION_BUS_ADDRESS}" ]; then
    eval `dbus-launch --sh-syntax --exit-with-session`
fi

# Console log
xconsole -geometry 480x130-0-0 -daemon -notify -verbose -exitOnFail &


# Select the X session to start
if [ -e /usr/local/bin/Xdialog ]; then
    XSESSION=`Xdialog \
                --buttons-style text \
                --no-close \
                --no-cancel \
                --no-tags \
                --screen-center \
                --stdout \
                --menubox \
                    "Select the X session" \
                    190x105 \
                    2 \
                    "openbox"  "Openbox" \
                    "cwm"      "cwm"`
fi

# Process monitor
#xterm -title "Process monitor" -e top &

# System log
pkill xconsole
#xterm -title "System log" -e tail -f /var/log/messages &

# Start xlock through xidle
#xidle -delay 2 -nw -timeout 600 -program "xlock -mousemotion" &

# Xscreensaver daemon
xscreensaver &

# X screen reset and lock daemon (activated by SIGUSR1)
xscreen-reset &
XSCREEN_RESET_PID=$!

# Battery status check daemon
~/bin/check-bat-status &
CHECK_BAT_STATUS_PID=$!

# Pop-up reminders daemon
remind -z -k'xmessage -title "Reminder" -buttons "Ok" %s &' ~/.reminders &
REMIND_PID=$!

# Bittorrent protocol daemon
#btpd --bw-in 400 --bw-out 50  --max-peers 25 --max-uploads 5 --port 6881

# Start some useful tray apps
/usr/local/libexec/tray-app/sound -i &

# Start the compositor manager
#xcompmgr &
#compton &

# Start the selected X session
case "$XSESSION" in
    openbox)
        openbox-session
        ;;
    cwm)
        cwm
        ;;
    *)
        twm
        ;;
esac

# Kill all background precesses
kill -KILL $XSCREEN_RESET_PID
kill -KILL $CHECK_BAT_STATUS_PID
kill -KILL $REMIND_PID
