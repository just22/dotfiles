#!/bin/sh

# ----------------------------------------------------------------------
#  $Id$
#
# Extract sender email address from current message and append it to
# alias file (it works better than built-in create_alias command in some
# corner cases
# ----------------------------------------------------------------------

FROM=$(grep -i "^from: ")
ADDR=$(echo $FROM | egrep -io "[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}")

# Personal name, when present, is the string in between the "From: " string
# and the address
NAME=$(echo $FROM | awk -v addr="$ADDR" '{sub (/[Ff]rom: /, "", $0); sub (addr, "", $0); print $0}')

# Sanitize name, removing "<>" chars and leading/trailing spaces
NAME=$(echo $NAME | sed -E -e "s/[<>]//g; s/^ {1,}//; s/ {1,}$//")

# When no name is specified, guess it from first part of the email address
[ "$NAME" == "" ] && NAME=$(echo $ADDR | sed -e "s/@.*//")
echo "/$NAME/"

# Alias is derived from personal name, applying a stricter sanitization
ALIAS=$(echo $NAME | sed -E -e "s/[ -,.]/_/g" | tr -s "_" | tr '[:upper:]' '[:lower:]')
ALIAS=$(echo $ALIAS | iconv -f UTF-8 -t ASCII//TRANSLIT | tr -d "\"\'\`")

if grep " $ALIAS " ~/.mutt/aliases >/dev/null 2>&1; then
        echo "You already have an alias defined as \"$ALIAS\""
        exit 1
else
        ALIAS_LINE="alias $ALIAS $NAME <$ADDR>"
        echo -n "Accept \"$ALIAS_LINE\"? [Y/n] "
        read sel < /dev/tty
        case "$sel" in
        n|no|N|NO|No)
                ;;
        *)
                echo "$ALIAS_LINE" >> ~/.mutt/aliases
                ;;
        esac
fi

exit 0
