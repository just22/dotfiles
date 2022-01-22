" ----------------------------------------------------------------------
"  $Id$
"
"  vi configuration file
" ----------------------------------------------------------------------
"
"
" ----------------------------------------------------------------------
"  SET OPTIONS (AND CORRESPONDING MAPPINGS)
"
" Automatically indent new lines
set autoindent
"
" Use TAB to edit the colon command-line history
set cedit=\	
"
" Use extended regular expressions (EREs)
set extended
"
" Use spaces instead of tab chars
set expandtab
"
" Use TAB to perform file path completion on the colon command-line
set filec=\	
"
" Case-insensitive RE, except if upper-case letters appear in search string
set iclower
"
" Left-right scrolling (unwrap long lines)
set leftright
map 	sw :set leftright
map 	sW :set noleftright
"
" Precede each line with its ordinal number
set number
map 	sn :set number
map 	sN :set nonumber
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
" When a bracket is inserted, briefly jump to the matching one
set showmatch
"
" Display the current editor mode and a "modified" flag
set showmode
"
" Number of spaces that a <Tab> in the file counts for
set tabstop=8
"
" Display a message for every error
set verbose
"
"
" ----------------------------------------------------------------------
"  MAPS
"
" Accept macros within macros
set remap
"
" Easier access to "go to mark" command for non-US kbd
map ' `
"
" Edit .exrc
map 	e :e $HOME/.exrc
"
" Source .exrc
map 	r :so $HOME/.exrc
"
" Move effectively among open files
map 	l :args
map 	b :prev
map 	f :next
map 	g :e#
"
" Move to the beginning of file
map gg :0
"
" Display lines in an unambiguous fashion
map 	sl :set list
map 	sL :set nolist
"
" Format current paragraph/file
map 	p {!}fmt -w 72
map 	P 1G!Gfmt -w 72
"
" Spell checker
map 	E :w:!aspell -l en check %:e!
map 	I :w:!aspell -l it check %:e!
"
" Duplicate line, comment original
map 	dd YI#p
"
" Insert an empty line above/below current one
map 	O O
map 	o o
"
" Attribution line: author, date
map 	ia o# AdL, :r !date +\%Y-\%m-\%dkJ$
"
" Insert note
map 	in o# AdL: 
"
" Insert file header
map 	ih 1GO#/bin/sh# 70a-o#  $$#  # 70a-kA
"
" Copyright
map 	ic O# (C) :r !date +\%YkJA Alessandro De Laurenzis <just22.adl@gmail.com>
"
" 3-clausole BSD license
map 	il O# (C) :r !date +\%YkJA Alessandro De Laurenzis <just22.adl@gmail.com># All Rights Reserved## Redistribution and use in source and binary forms, with or without# modification, are permitted provided that the following conditions# are met:## 1. Redistributions of source code must retain the above copyright#    notice, this list of conditions and the following disclaimer.## 2. Redistributions in binary form must reproduce the above copyright#    notice, this list of conditions and the following disclaimer in the#    documentation and/or other materials provided with the distribution.## 3. Neither the name of the copyright holder nor the names of its#    contributors may be used to endorse or promote products derived#    from this software without specific prior written permission.## THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
"
" New section
map 	- o# 70a-o##kA  
"
" Comment/uncomment current line
map 	c 0i#
map 	C :s/^#//
"
" On-line help
map #1 :viusage
"
" Move current line up or down
map 	OA :m -2
map 	OB :m +1
"
" Number incr/dec
map + #+
map - #-
"
" Snip line
map 	is o[...]
map 	iS o....................<snip>....................
"
" Search for word at cursor position
map * 
"
" Edit the file at cursor position
map gf :e%dWPo:e! p"fdd@f
"
" Place current line in the center of the screen
map  z.
map!  mpz.`pa
"
" Kill the current file's content
map 	k :w! /tmp/$USER.vi.killed:%dZZ
"
" Copy from clipboard
map 	p :r! xclip -o
"
" Switch to previous current file
map 	g :e#
"
" Show the argument list
map 	l :args
"
" Switch to next/previous file in argument list
map 	f :next
map 	b :prev
"
"
" ----------------------------------------------------------------------
"  ABBREVIATIONS
"
" Signatures
abbr _AdL Alessandro DE LAURENZIS <just22.adl@gmail.com>
abbr _mail [mailto://just22.adl@gmail.com">just22.adl@gmail.com]
"
" Multi-line comment/uncomment
abbr _c s/^/\#/
abbr _C s/^\#//
"
" Multi-line duplication
abbr _d !awk 'BEGIN {b=""} {b=b$0"\n"; sub("^", "\#"); print} END {printf "\%s", b}'
"
" Settings for specific file types
abbr _vi source ~/.exrc.d/cchar_dquotes.exrc
abbr _v source ~/.exrc.d/cchar_dslash.exrc
"
" Copy/paste between sessions
abbr _y w! /tmp/$USER.vi.yank
abbr _p r /tmp/$USER.vi.yank
"
"
" eof: .exrc
