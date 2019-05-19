#!/bin/sh
#
# Author:   A. DE LAURENZIS (adapted from Eric Gebhart's original code)
#
# Purpose:  To be called by mutt as indicated by .mailcap to handle mail
#           attachments.
#
# Function: Copy the given file to a temporary directory so mutt
#           won't delete it before it is read by the application;
#           finally use  the appropriate app to open the file
#
# Arguments:
#     $1 is "open with" app
#     $2 is the file
#
# Examples: These are typical .mailcap entries which use this program.
#
#     Image/JPEG; ${HOME}/.mutt/view_attachment.sh gpicview %s
#     Image/PNG; ${HOME}/.mutt/view_attachment gpicview %s
#     Image/GIF; ${HOME}/.mutt/view_attachment gpicview %s
#     Application/PDF; ${HOME}/.mutt/view_attachment xpdf %s
#     text/html; {HOME}/.mutt/view_attachment chrome %s
#
# Debugging:
#           If you have problems set debug to 'yes'.  That will cause
#           a debug file be written to /tmp/mutt_attach/debug so you can
#           see what is going on
#

if [ $# != 2 ]; then
    echo "Usage: view_attachment.sh <openWithApp> <file>"
    exit 1
fi

# Tmp directory
tmpdir="${HOME}/.mutt/tmp/view_attachment.workdir"

# Name of the debug file if debugging is turned on
debug_file=${tmpdir}/view_attachment.debug

# Set debug to yes for debugging
debug="no"
#debug="yes"

open_with="$1"
file="$2"

# Make sure the tmpdir
mkdir -p ${tmpdir}

# Clean it out.  Remove this if you want the directory
# to accumulate attachment files
rm -f ${tmpdir}/*

# This gets the basic filename from the full pathname
filename="${2##*/}"

if [ $debug = "yes" ]; then
    echo "Open with: " ${open_with} > ${debug_file}
    echo "File: " ${file} >> ${debug_file}
    echo "Filename: "$filename >> ${debug_file}
    echo "===========================" >> $debug_file
fi

# Copy the file to our new spot so mutt can't delete it
# before the app has a chance to view it
cp ${file} ${tmpdir}/${filename}.html

# Open the attachment
${open_with} ${tmpdir}/${filename}.html &
