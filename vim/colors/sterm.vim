" ----------------------------------------------------------------------------
"  Simplified Vim terminal colorscheme (adapted from base16-solarized)
" ----------------------------------------------------------------------------

" Terminal ANSI color definitions
let s:black     = "00"
let s:red       = "01"
let s:green     = "02"
let s:yellow    = "03"
let s:blue      = "04"
let s:magenta   = "05"
let s:cyan      = "06"
let s:lgrey     = "07"
let s:dgrey     = "08"
let s:white     = "15"

let s:black        = "00"     " Darker
let s:cterm01        = "10"     "   |
let s:cterm02        = "11"     "   |
let s:dgrey        = "08"     "   |
let s:cterm04        = "12"     "   !
let s:lgrey        = "07"     "   |
let s:cterm06        = "13"     "   v
let s:white        = "15"     " Lighter

let s:red        = "01"     " Red
let s:cterm09        = "09"     " Orange
let s:cterm0A        = "03"     " Yellow
let s:cterm0B        = "02"     " Green
let s:cterm0C        = "06"     " Cyan
let s:cterm0D        = "04"     " Blue
let s:cterm0E        = "05"     " Violet
let s:cterm0F        = "14"     " Magenta

" Theme setup
hi clear
syntax reset
let g:colors_name = "sterm"

function <sid>hi(group, ctermfg, ctermbg, ...)
        let l:attr = get(a:, 1)

        if a:ctermfg != ""
                exec "hi " . a:group . " ctermfg=" . a:ctermfg
        endif

        if a:ctermbg != ""
                exec "hi " . a:group . " ctermbg=" . a:ctermbg
        endif

        if l:attr != ""
                exec "hi " . a:group . " cterm=" . l:attr
        endif
endfunction

" Vim editor colors
call <sid>hi("Normal",        s:lgrey, s:black, "")

call <sid>hi("CursorLine",    "",  "", "underline")
call <sid>hi("CursorLineNr",  s:white,      s:dgrey,      "none")

call <sid>hi("ColorColumn",   "",        s:cterm01, "none")
call <sid>hi("CursorColumn",  "",        s:cterm01, "none")

call <sid>hi("LineNr",        s:dgrey, s:black, "")

call <sid>hi("Search",        s:cterm01, s:cterm0A, "")
call <sid>hi("CurSearch",     s:cterm01, s:cterm09, "none")
call <sid>hi("IncSearch",     s:cterm01, s:cterm09, "none")

call <sid>hi("Folded",        s:cterm02, s:black, "")
call <sid>hi("MatchParen",    s:cterm09, s:cterm04, "")
call <sid>hi("StatusLine",    s:cterm04, s:cterm01, "none")
call <sid>hi("StatusLineNC",  s:dgrey, s:cterm01, "none")
call <sid>hi("Visual",        s:lgrey, s:cterm02, "")

" Standard syntax
call <sid>hi("Boolean",       "none",    "",        "")
call <sid>hi("Character",     "none",    "",        "")
call <sid>hi("Comment",       "03", "",        "none")
call <sid>hi("Conditional",   s:cterm0E, "",        "")
call <sid>hi("Constant",      "none",    "",        "")
call <sid>hi("Define",        s:cterm0E, "",        "none")
call <sid>hi("Delimiter",     "none",    "",        "")
call <sid>hi("Float",         "none",    "",        "")
call <sid>hi("Function",      "none",    "",        "")
call <sid>hi("Identifier",    "none",    "",        "none")
call <sid>hi("Include",       s:cterm0E, "",        "")
call <sid>hi("Keyword",       s:cterm0E, "",        "")
call <sid>hi("Label",         s:cterm0E, "",        "")
call <sid>hi("Number",        "none",    "",        "")
call <sid>hi("Operator",      s:cterm0E,    "",        "none")
call <sid>hi("PreProc",       "none",    "",        "")
call <sid>hi("Repeat",        s:cterm0E, "",        "")
call <sid>hi("Special",       "none",    "",        "")
call <sid>hi("SpecialChar",   "none",    "",        "")
call <sid>hi("Statement",     s:cterm0E, "",        "")
call <sid>hi("StorageClass",  "none",    "",        "")
call <sid>hi("String",        s:cterm0B, "",        "")
call <sid>hi("Structure",     s:cterm0E, "",        "")
call <sid>hi("Tag",           "none",    "",        "")
call <sid>hi("Todo",          "none",    "none",    "")
call <sid>hi("Type",          s:cterm0E, "",        "none")
call <sid>hi("Typedef",       s:cterm0E, "",        "")

" Standard highlights to be used by plugins
call <sid>hi("Deprecated",    "",        "",        "strikethrough")
call <sid>hi("SearchMatch",   s:cterm0C, "",        "")

call <sid>hi("GitAddSign",          "none", "", "")
call <sid>hi("GitChangeSign",       "none", "", "")
call <sid>hi("GitDeleteSign",       "none", "", "")
call <sid>hi("GitChangeDeleteSign", "none", "", "")
call <sid>hi("GitCommitSummary",    "none", "", "")

call <sid>hi("ErrorSign",     s:red, "",        "")
call <sid>hi("WarningSign",   s:cterm09, "",        "")
call <sid>hi("InfoSign",      s:cterm0D, "",        "")
call <sid>hi("HintSign",      s:cterm0C, "",        "")

call <sid>hi("ErrorFloat",    s:red, s:cterm01, "")
call <sid>hi("WarningFloat",  s:cterm09, s:cterm01, "")
call <sid>hi("InfoFloat",     s:cterm0D, s:cterm01, "")
call <sid>hi("HintFloat",     s:cterm0C, s:cterm01, "")

call <sid>hi("ErrorHighlight",   s:black, s:red, "underline")
call <sid>hi("WarningHighlight", s:black, s:cterm09, "underline")
call <sid>hi("InfoHighlight",    s:black, s:cterm0D, "underline")
call <sid>hi("HintHighlight",    s:black, s:cterm0C, "underline")

call <sid>hi("SpellBad",      s:black, s:red, "undercurl")
call <sid>hi("SpellLocal",    s:black, s:cterm0C, "undercurl")
call <sid>hi("SpellCap",      s:black, s:cterm0D, "undercurl")
call <sid>hi("SpellRare",     s:black, s:cterm0E, "undercurl")

call <sid>hi("ReferenceText",  s:cterm01, s:cterm0A, "")
call <sid>hi("ReferenceRead",  s:cterm01, s:cterm0B, "")
call <sid>hi("ReferenceWrite", s:cterm01, s:red, "")

" Diff
call <sid>hi("DiffAdd",       s:cterm0B, s:cterm01, "")
call <sid>hi("DiffChange",    s:lgrey, s:cterm01, "")
call <sid>hi("DiffDelete",    s:cterm02, s:cterm01, "")
call <sid>hi("DiffText",      s:cterm0C, s:cterm01, "reverse")
call <sid>hi("DiffAdded",     s:cterm0B, s:cterm01, "")
call <sid>hi("DiffFile",      s:red, s:cterm01, "")
call <sid>hi("DiffNewFile",   s:cterm0B, s:cterm01, "")
call <sid>hi("DiffLine",      s:cterm0D, s:cterm01, "")
call <sid>hi("DiffRemoved",   s:red, s:cterm01, "")

" HTML
call <sid>hi("htmlBold",      s:cterm0A, "",        "bold")
call <sid>hi("htmlItalic",    s:cterm0E, "",        "italic")

" Mail
call <sid>hi("mailQuoted1",   s:cterm0A, "",        "")
call <sid>hi("mailQuoted2",   s:cterm0B, "",        "")
call <sid>hi("mailQuoted3",   s:cterm0E, "",        "")
call <sid>hi("mailQuoted4",   s:cterm0C, "",        "")
call <sid>hi("mailQuoted5",   s:cterm0D, "",        "")
call <sid>hi("mailQuoted6",   s:cterm0A, "",        "")
call <sid>hi("mailURL",       s:cterm0D, "",        "")
call <sid>hi("mailEmail",     s:cterm0D, "",        "")

" Markdown
call <sid>hi("markdownCode",  s:cterm0B, "",        "")
call <sid>hi("markdownError", s:lgrey, s:black, "")

" Remove functions
delfunction <sid>hi

" Remove color variables
unlet s:black s:cterm01 s:cterm02 s:dgrey
    \ s:cterm04 s:lgrey s:cterm06 s:white
    \ s:red s:cterm09 s:cterm0A s:cterm0B
    \ s:cterm0C s:cterm0D s:cterm0E s:cterm0F

