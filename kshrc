# ----------------------------------------------------------------------
#  $Id$
#
#  This file is sourced by all *interactive* ksh on startup,
#  including some apparently interactive shells such as scp and rcp
#  that can't tolerate any output.  So make sure this doesn't display
#  anything or bad things will happen!
#  It should contain stuff that applies only to ksh itself, such
#  as alias and function definitions, shell options and prompt settings
# ----------------------------------------------------------------------

# ----------------------------------------------------------------------
# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
#
if [[ $- != *i* ]]; then
        # Shell is non-interactive.  Be done now!
        return
fi

# ----------------------------------------------------------------------
# Enable a subset of csh-style history editing using the `!' character
#
set -o csh-history

# ----------------------------------------------------------------------
# Make history permanent
#
HISTFILE=${HOME}/.sh_history

# ----------------------------------------------------------------------
# Colored prompt, if the terminal has the capability
#

# Color support can be forced off setting NO_COLORS (to any values)
# This will influence file listing aliases' behavior too
#NO_COLORS=""

escseq() {
          ESC="\e"
         CODE="$1"
         printf "%s[%sm" $ESC $CODE
}

if [ -z ${NO_COLORS+x} ] && [ $(tput colors) -ge 8 ]; then
        COLOR_SUPPORT=1

        # ANSI escape sequences for graphics mode
        # Color codes:
        # 0 -> Black
        # 1 -> Red
        # 2 -> Green
        # 3 -> Yellow
        # 4 -> Blue
        # 5 -> Magenta
        # 6 -> Cyan
        # 7 -> White

        # Text attributes
             RSTCOL="$(escseq  0)"
               BOLD="$(escseq  1)"
          UNDERLINE="$(escseq  4)"
              BLINK="$(escseq  5)"
            REVERSE="$(escseq  7)"
          CONCEALED="$(escseq  8)"

        # Foreground colors
           FG_BLACK="$(escseq 30)"
             FG_RED="$(escseq 31)"
           FG_GREEN="$(escseq 32)"
          FG_YELLOW="$(escseq 33)"
            FG_BLUE="$(escseq 34)"
         FG_MAGENTA="$(escseq 35)"
            FG_CYAN="$(escseq 36)"
           FG_WHITE="$(escseq 37)"

        # Background colors
           BG_BLACK="$(escseq 40)"
             BG_RED="$(escseq 41)"
           BG_GREEN="$(escseq 42)"
          BG_YELLOW="$(escseq 43)"
            BG_BLUE="$(escseq 44)"
         BG_MAGENTA="$(escseq 45)"
            BG_CYAN="$(escseq 46)"
           BG_WHITE="$(escseq 47)"
else
        COLOR_SUPPORT=0
fi

if [ "$COLOR_SUPPORT" == 1 ]; then
        HICOL="$FG_YELLOW"
        NORMCOL="$FG_BLUE"
        [ $USER == root ] && USRCOL="$FG_RED" || USRCOL="$HICOL"
fi


PS1="${USRCOL}\u${NORMCOL}@\h:[\W]> ${RSTCOL}"

# ----------------------------------------------------------------------
# If this is an xterm, set the title to user@host:dir
#
case "$TERM" in
xterm*|screen*)
    PS1="\[\e]0;\u@\h:[\w]\a\]$PS1"
    ;;
*)
    ;;
esac

# ----------------------------------------------------------------------
# The editor used by fc
#
export FCEDIT="vim"

# ----------------------------------------------------------------------
# Aliases/functions definition
#
[ -e ~/.sh_aliases ] && . ~/.sh_aliases
