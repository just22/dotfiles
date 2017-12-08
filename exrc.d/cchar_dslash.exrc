" ----------------------------------------------------------------------
"  $Id$
"
"  vi configuration file - Comment char: //
" ----------------------------------------------------------------------
"
"
" ----------------------------------------------------------------------
"  MAPS
"
" Duplicate line, comment original
map \d YI//p
"
" Attribution line: author, date
map \ia o// AdL, :r !date +\%Y-\%m-\%dkJ
"
" Insert note
map \in o// AdL: 
"
" Insert file header
map \ih 1GO///bin/sh
"
" Copyright
map \ic O// (C) :r !date +\%Y
"
" 3-clausole BSD license
map \il O// (C) :r !date +\%Y
"
" New section
map \- o// 70a-o//
"
" Comment/uncomment current line
map \c 0i//
map \\c :s*^//**
"
"
" ----------------------------------------------------------------------
"  ABBREVIATIONS
"
" Multi-line comment/uncomment
abbr _c s*^*//*
abbr _C s*^//**
"
" Multi-line duplication
abbr _d !awk 'BEGIN {b=""} {b=b$0"\n"; sub("^", "//"); print} END {printf "\%s", b}'
"
"
" eof: cchar_dquotes.exrc