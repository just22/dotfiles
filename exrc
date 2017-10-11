" ----------------------------------------------------------------------
"  $Id$
"
"  vi configuration file
" ----------------------------------------------------------------------
"
"
" ----------------------------------------------------------------------
"  SET OPTIONS
"
" Automatically indent new lines
set autoindent
"
" Use extended regular expressions (EREs)
set extended
"
" Use TAB to perform file path completion on the colon command-line
set filec=\	
"
" Case-insensitive RE, except if upper-case letters appear in search string
set iclower
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
" When a bracket is inserted, briefly jump to the matching one
set showmatch
"
" Display the current editor mode and a "modified" flag
set showmode
"
" Number of spaces that a <Tab> in the file counts for
set tabstop=8
"
" Display an error message for every error
set verbose
"
"
" ----------------------------------------------------------------------
"  MAPS
"
" Edit .exrc
map \e :e $HOME/.exrc
"
" Source .exrc
map \r :so $HOME/.exrc
"
" Move effectively among open files
map \l :args
map \b :prev
map \f :next
map \g :e#
"
" Format current paragraph/file
map \p {!}fmt -w 72
map \P 1G!Gfmt -w 72
"
" Spell checker
map \E :w:!aspell -l en check %:e!
map \I :w:!aspell -l it check %:e!
"
" Attribution line: author, date
map \a o# AdL, :r !date +\%Y-\%m-\%dkJ
"
" Insert note
map \n o# AdL: 
"
" Duplicate line, comment original
map \d YI#p
"
" Empty line above/below current one
map \O O
map \o o
"
" New script header
map \0 1GO#/bin/sh# 70a-o#  $Id$#  # 70a-kA
"
" Copyright
map \R O# (C) :r !date +\%YkJA Alessandro De Laurenzis <just22.adl@gmail.com>
"
" 3-clausole BSD license
map \L O# (C) :r !date +\%YkJA Alessandro De Laurenzis <just22.adl@gmail.com># All Rights Reserved## Redistribution and use in source and binary forms, with or without# modification, are permitted provided that the following conditions# are met:## 1. Redistributions of source code must retain the above copyright#    notice, this list of conditions and the following disclaimer.## 2. Redistributions in binary form must reproduce the above copyright#    notice, this list of conditions and the following disclaimer in the#    documentation and/or other materials provided with the distribution.## 3. Neither the name of the copyright holder nor the names of its#    contributors may be used to endorse or promote products derived#    from this software without specific prior written permission.## THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
"
" New section
map \- o# 70a-o##kA  
"
" (Un)comment out current line
map \c 0i#
map \C :s/^#//
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
" Snip line
map \s o[...]
map \S o....................<snip>....................
"
" Search for word under the cursor
map * dePo/\<pA\>"wdd@w
"
"
" ----------------------------------------------------------------------
"  ABBREVIATIONS
"
" Signatures
abbr _AdL Alessandro DE LAURENZIS <just22.adl@gmail.com>
abbr _mail [mailto://just22.adl@gmail.com">just22.adl@gmail.com]
"
"
" eof: .exrc
