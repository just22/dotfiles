" ----------------------------------------------------------------------
"  $Id$
"
"  vi configuration file - Comment char: "
" ----------------------------------------------------------------------
"
"
" ----------------------------------------------------------------------
"  MAPS
"
" Duplicate line, comment original
map \d YI"p
"
" Attribution line: author, date
map \ia o" AdL, :r !date +\%Y-\%m-\%dkJ
"
" Insert note
map \in o" AdL: 
"
" Insert file header
map \ih 1GO"/bin/sh" 70a-o"  $Id$"  " 70a-kA
"
" Copyright
map \ic O" (C) :r !date +\%YkJA Alessandro De Laurenzis <just22.adl@gmail.com>
"
" 3-clausole BSD license
map \il O" (C) :r !date +\%YkJA Alessandro De Laurenzis <just22.adl@gmail.com>" All Rights Reserved"" Redistribution and use in source and binary forms, with or without" modification, are permitted provided that the following conditions" are met:"" 1. Redistributions of source code must retain the above copyright"    notice, this list of conditions and the following disclaimer."" 2. Redistributions in binary form must reproduce the above copyright"    notice, this list of conditions and the following disclaimer in the"    documentation and/or other materials provided with the distribution."" 3. Neither the name of the copyright holder nor the names of its"    contributors may be used to endorse or promote products derived"    from this software without specific prior written permission."" THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS" "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT" LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR" A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT" HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL," SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT" LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE," DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY" THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT" (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE" OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
"
" New section
map \- o" 70a-o""kA  
"
" Comment/uncomment current line
map \c 0i"
map \\c :s/^"//
"
"
" ----------------------------------------------------------------------
"  ABBREVIATIONS
"
" Multi-line comment/uncomment
abbr _c s/^/\"/
abbr _C s/^\"//
"
" Multi-line duplication
abbr _d !awk 'BEGIN {b=""} {b=b$0"\n"; sub("^", "\""); print} END {printf "\%s", b}'
"
"
" eof: cchar_dquotes.exrc
