" ----------------------------------------------------------------------------
"  Simplified Vim terminal colorscheme (adapted from base16-solarized)
" ----------------------------------------------------------------------------

" Terminal color definitions
let s:cterm00        = "00"     " Darker
let s:cterm01        = "10"     "   |
let s:cterm02        = "11"     "   |
let s:cterm03        = "08"     "   |
let s:cterm04        = "12"     "   !
let s:cterm05        = "07"     "   |
let s:cterm06        = "13"     "   v
let s:cterm07        = "15"     " Lighter

let s:cterm08        = "01"     " Red
let s:cterm09        = "09"     " Orange
let s:cterm0A        = "03"     " Yellow
let s:cterm0B        = "02"     " Green
let s:cterm0C        = "06"     " Cyan
let s:cterm0D        = "04"     " Blue
let s:cterm0E        = "05"     " Violet
let s:cterm0F        = "14"     " Magenta

" Theme setup
" hi clear
" syntax reset
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
call <sid>hi("Normal",        s:cterm05, s:cterm00, "")
call <sid>hi("Bold",          "",        "",        "bold")
call <sid>hi("Debug",         s:cterm08, "",        "")
call <sid>hi("Directory",     s:cterm0D, "",        "")
call <sid>hi("Error",         s:cterm00, s:cterm08, "")
call <sid>hi("ErrorMsg",      s:cterm08, s:cterm00, "")
call <sid>hi("Exception",     s:cterm08, "",        "")
call <sid>hi("FoldColumn",    s:cterm03, s:cterm00, "")
call <sid>hi("Folded",        s:cterm02, s:cterm00, "")
call <sid>hi("Italic",        "",        "",        "italic")
call <sid>hi("Macro",         s:cterm08, "",        "")
call <sid>hi("MatchParen",    s:cterm09, s:cterm04, "")
call <sid>hi("ModeMsg",       s:cterm08, "",        "")
call <sid>hi("MoreMsg",       s:cterm0B, "",        "")
call <sid>hi("Question",      s:cterm0D, "",        "")
call <sid>hi("IncSearch",     s:cterm01, s:cterm09, "none")
call <sid>hi("CurSearch",     s:cterm01, s:cterm09, "none")
call <sid>hi("Search",        s:cterm01, s:cterm0A, "")
call <sid>hi("Substitute",    s:cterm01, s:cterm0A, "none")
call <sid>hi("SpecialKey",    s:cterm03, "",        "")
call <sid>hi("TooLong",       s:cterm08, "",        "")
call <sid>hi("Underlined",    s:cterm08, "",        "")
call <sid>hi("Visual",        s:cterm05, s:cterm02, "")
call <sid>hi("VisualNOS",     s:cterm08, "",        "")
call <sid>hi("WarningMsg",    s:cterm08, "",        "")
call <sid>hi("WildMenu",      s:cterm00, s:cterm05, "")
call <sid>hi("Title",         s:cterm0D, "",        "none")
call <sid>hi("Conceal",       s:cterm0D, s:cterm00, "")
call <sid>hi("Cursor",        "",        "",        "inverse")
call <sid>hi("NonText",       s:cterm03, "",        "")
call <sid>hi("Whitespace",    s:cterm03, "",        "")
call <sid>hi("LineNr",        s:cterm03, s:cterm00, "")
call <sid>hi("SignColumn",    s:cterm03, s:cterm00, "")
call <sid>hi("StatusLine",    s:cterm04, s:cterm01, "none")
call <sid>hi("StatusLineNC",  s:cterm03, s:cterm01, "none")
call <sid>hi("VertSplit",     s:cterm01, s:cterm00, "none")
call <sid>hi("ColorColumn",   "",        s:cterm01, "none")
call <sid>hi("CursorColumn",  "",        s:cterm01, "none")
call <sid>hi("CursorLine",    "",        s:cterm01, "none")
call <sid>hi("CursorLineNr",  s:cterm05, s:cterm01, "bold")
call <sid>hi("QuickFixLine",  "",        s:cterm01, "none")
call <sid>hi("PMenu",         s:cterm06, s:cterm01, "none")
call <sid>hi("PMenuSel",      s:cterm06, s:cterm02, "")
call <sid>hi("PMenuSbar",     "",        s:cterm03, "")
call <sid>hi("PMenuThumb",    "",        s:cterm04, "")
call <sid>hi("TabLine",       s:cterm03, s:cterm01, "none")
call <sid>hi("TabLineFill",   s:cterm03, s:cterm01, "none")
call <sid>hi("TabLineSel",    s:cterm0B, s:cterm01, "none")

" Standard syntax
call <sid>hi("Boolean",       "none",    "",        "")
call <sid>hi("Character",     "none",    "",        "")
call <sid>hi("Comment",       s:cterm03, "",        "")
call <sid>hi("Conditional",   s:cterm0E,    "",        "")
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

call <sid>hi("ErrorSign",     s:cterm08, "",        "")
call <sid>hi("WarningSign",   s:cterm09, "",        "")
call <sid>hi("InfoSign",      s:cterm0D, "",        "")
call <sid>hi("HintSign",      s:cterm0C, "",        "")

call <sid>hi("ErrorFloat",    s:cterm08, s:cterm01, "")
call <sid>hi("WarningFloat",  s:cterm09, s:cterm01, "")
call <sid>hi("InfoFloat",     s:cterm0D, s:cterm01, "")
call <sid>hi("HintFloat",     s:cterm0C, s:cterm01, "")

call <sid>hi("ErrorHighlight",   s:cterm00, s:cterm08, "underline")
call <sid>hi("WarningHighlight", s:cterm00, s:cterm09, "underline")
call <sid>hi("InfoHighlight",    s:cterm00, s:cterm0D, "underline")
call <sid>hi("HintHighlight",    s:cterm00, s:cterm0C, "underline")

call <sid>hi("SpellBad",      s:cterm00, s:cterm08, "undercurl")
call <sid>hi("SpellLocal",    s:cterm00, s:cterm0C, "undercurl")
call <sid>hi("SpellCap",      s:cterm00, s:cterm0D, "undercurl")
call <sid>hi("SpellRare",     s:cterm00, s:cterm0E, "undercurl")

call <sid>hi("ReferenceText",  s:cterm01, s:cterm0A, "")
call <sid>hi("ReferenceRead",  s:cterm01, s:cterm0B, "")
call <sid>hi("ReferenceWrite", s:cterm01, s:cterm08, "")

" Diff
call <sid>hi("DiffAdd",       s:cterm0B, s:cterm01, "")
call <sid>hi("DiffChange",    s:cterm05, s:cterm01, "")
call <sid>hi("DiffDelete",    s:cterm02, s:cterm01, "")
call <sid>hi("DiffText",      s:cterm0C, s:cterm01, "reverse")
call <sid>hi("DiffAdded",     s:cterm0B, s:cterm01, "")
call <sid>hi("DiffFile",      s:cterm08, s:cterm01, "")
call <sid>hi("DiffNewFile",   s:cterm0B, s:cterm01, "")
call <sid>hi("DiffLine",      s:cterm0D, s:cterm01, "")
call <sid>hi("DiffRemoved",   s:cterm08, s:cterm01, "")

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
call <sid>hi("markdownError", s:cterm05, s:cterm00, "")

" Remove functions
delfunction <sid>hi

" Remove color variables
unlet s:cterm00 s:cterm01 s:cterm02 s:cterm03
    \ s:cterm04 s:cterm05 s:cterm06 s:cterm07
    \ s:cterm08 s:cterm09 s:cterm0A s:cterm0B
    \ s:cterm0C s:cterm0D s:cterm0E s:cterm0F

