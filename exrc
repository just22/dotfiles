" vi config file
" Based on exrc by Dave W. CAPELLA
"
"
" Allow reading any .exrc files found in the current directory
set exrc
"
" Handy for email and programming
set autoindent
"
" Reduce the confusion
"set modeline
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
" Number of spaces to use for each step of (auto)indent
set shiftwidth=4
"
" Show (partial) command in the last line of the screen
"set showcmd
"
" When a bracket is inserted, briefly jump to the matching one
set showmatch
"
" If in Insert or Replace mode put a message on the last line
set showmode
"
" Number of spaces that a <Tab> in the file counts for
set tabstop=4
"
" Dir name for the swap file
set directory=/tmp
"
abbr _me <a href="mailto://just22.adl@gmail.com">just22.adl@gmail.com</a>
abbr _AdL Alessandro DE LAURENZIS
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
" Open line above current one
map \O O
"
" Open line below current one
map \o o
"
" New script (sh)
map \t 1GO#/bin/sh# :r!ls %kJA - # # dave@foo.edu - :r !datekJo# 60a#Ypo# EOF: :r!ls %kJ1G$
"
" Shebang line
map \1 1Gi#/bin/sh# k
"
" Copyright line
map \2  o# copyright (c) 2001,2002   A. De Laurenzis    All Rights Reserved
"
" Warranty line
map \w  o## May be freely distributed and used as long as this header is retained.# All modifications must be clearly indicated.## The author makes no promise of technical support. However, bug reports,# suggestions, questions, and comments are welcome. All will be answered# via electronic mail as time allows.## NO WARRANTY OF ANY KIND EXPRESSED OR IMPLIED. USE AT YOUR OWN RISK.#
"
" Comment out current line
map \x I#
"
" Shell function
map \f ofuntion mja () {}`ja
"
" Shell if;then;fi construct
map \i oif [ mja ]; thenfi`ja
"
" For email
map \. o....................<snip>....................
"
"
ab ppp #####################################
ab sif  if  [  $# -lt 1 ]^Mthen^M  echo "filename must be provided"^Mexit 1^Mfi
ab vsl ^[:set list
ab vsn ^[:set number
ab vnn ^[:set nonumber
ab vsl ^[:set list
ab vnl ^[:set nolist
ab chm ^[:!chmod 755 %
ab  fna  date +'%y %d %m %M'^V| read YY DN MN MM ^Mprog=`basename $0`;
"
" eof: .exrc
