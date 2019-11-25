# ----------------------------------------------------------------------
#  $Id$
#
#  Aliases (and functions) specific for bash(1)
# ----------------------------------------------------------------------

# Update tmux(1) env variables in current panel
tmux_upenv() {
        if [ -n "$TMUX" ]; then
                while read vline; do
                        case "$vline" in
                        -*)
                                vline="${vline#-}"
                                unset "${vline%=?*}"
                                ;;
                        *)
                                export "$vline"
                        esac
                done < <(tmux show-environment)
        fi
}
