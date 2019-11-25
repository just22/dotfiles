#!/bin/sh

# ----------------------------------------------------------------------
#  $Id$
#
#  Non-postscript files converter using a2ps
#  Put it in /etc/foomatic/direct/ and make the following hard links:
#  - a2ps-foomatic-rip-draft-color
#  - a2ps-foomatic-rip-draft-gray
#  - a2ps-foomatic-rip-hq-color
#  - a2ps-foomatic-rip-hq-gray
#  - a2ps-foomatic-rip-normal-color
#  - a2ps-foomatic-rip-normal-gray
# ----------------------------------------------------------------------

case "$0" in
*draft-gray)
	prn_m=Draft.Gray
	;;
*normal-gray)
	prn_m=Normal.Gray
	;;
*hq-gray)
	prn_m=High.Gray
	;;
*draft-color)
	prn_m=Draft
	;;
*normal-color)
	prn_m=Normal
	;;
*hq-color)
	prn_m=High
	;;
*)
	prn_m=Draft.Gray
	;;
esac

/usr/local/bin/a2ps -BRq --columns=1 -o - |
/usr/local/bin/foomatic-rip \
	-P hp-deskjet_1510_series-hpijs \
        -o PageSize=A4 \
	-o PrintoutMode="$prn_m"

