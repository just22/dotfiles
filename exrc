" ----------------------------------------------------------------------
"  $Id$
"
"  vi config file
" ----------------------------------------------------------------------
"
" Automatically indent new lines
set autoindent
"
" Use ESC to edit the colon command-line history
"set cedit=
"
" Use extended regular expressions (EREs)
set extended
"
" Use TAB to perform file path completion on the colon command-line
set filec=\	
"
" Ignore case differences in regular expressions
set ignorecase
"
" Precede each line with its ordinal number
set number
"
" Accept macros within macros
set remap
"
" *Always* show changes that commands make
set report=1
"
" What line/column cursor is on
set ruler
"
" Set n lines for CTRL-d and z
set scroll=15
"
"Makes the / and ? commands incremental
set searchincr
"
" Number of spaces to use for each step of (auto)indent
set shiftwidth=8
"
" Show (partial) command in the last line of the screen
"set showcmd
"
" When a bracket is inserted, briefly jump to the matching one
set showmatch
"
" Display the current editor mode and a “modified” flag
set showmode
"
" Number of spaces that a <Tab> in the file counts for
set tabstop=8
"
" Display an error message for every error
set verbose
"
" Handy abbreviations
abbr _mail <a href="mailto://just22.adl@gmail.com">just22.adl@gmail.com</a>
abbr _AdL Alessandro DE LAURENZIS <just22.adl@gmail.com>
"
" Format current paragraph/buffer
map \f {!}fmt -w 72
map \F 1G!Gfmt -w 72
"
" Spell checker
map \se :w:!aspell -l en check %:e!
map \si :w:!aspell -l it check %:e!
"
" Attribution line: author,date
map \a o# justt2.adl@gmail.com - :r !datekJ
"
" Insert shell comment line
map \c o60i#
"
" Insert AdL comment line
map \d O# AdL
"
" Edit .exrc
map \e :e $HOME/.exrc
"
" Source .exrc
map \r :so $HOME/.exrc
"
" Dupe line, comment original
map \n YPi#
"
" Empty line above current one
map \O O
"
" Empty line below current one
map \o o
"
" New script (sh)
map \t 1GO#/bin/sh# :r!ls %kJA - # # dave@foo.edu - :r !datekJo# 60a#Ypo# EOF: :r!ls %kJ1G$
"
" Shebang line
map \0 1Gi#!/bin/sh
"
" Copyright line
map \C I## (C) 2015   A. DE LAURENZIS <just22.adl@gmail.com>    All Rights Reserved## This code is free software; it may be freely distributed and used as# long as this header is retained.# All modifications must be clearly indicated.## The author makes no promise of technical support. However, bug reports,# suggestions, questions, and comments are welcome.## NO WARRANTY OF ANY KIND EXPRESSED OR IMPLIED. USE AT YOUR OWN RISK.#
"
" New section
map \- o# 70a-o##kA 
"
" Comment out current line
map \c I#
"
" On-line help
map #1 :viusage
"
" Move current line up or down
map #2 :m +1
map #3 :m -2
"
" Number incr/dec
map + #+
map - #-
"
" Shell if;then;fi construct
map \i oif [ mja ]; thenfi`ja
"
" For email
map \. o....................<snip>....................
"
"
" eof: .exrc
