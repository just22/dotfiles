" base16-vim (https://github.com/chriskempson/base16-vim)
" by Chris Kempson (http://chriskempson.com)
" (with a bunch of modifications...)

" GUI color definitions
source ${HOME}/.vim/colors/base16_gui.def

" Terminal color definitions
let s:cterm00        = "00"
let s:cterm03        = "08"
let s:cterm05        = "07"
let s:cterm07        = "15"
let s:cterm08        = "01"
let s:cterm0A        = "03"
let s:cterm0B        = "02"
let s:cterm0C        = "06"
let s:cterm0D        = "04"
let s:cterm0E        = "05"
let s:cterm01        = "10"
let s:cterm02        = "11"
let s:cterm04        = "12"
let s:cterm06        = "13"
let s:cterm09        = "09"
let s:cterm0F        = "14"

" Theme setup
hi clear
syntax reset

" Highlighting function
function! g:Base16hi(group, guifg, guibg, ctermfg, ctermbg, attr, guisp)
  if a:guifg != ""
    exec "hi " . a:group . " guifg=#" . a:guifg
  endif
  if a:guibg != ""
    exec "hi " . a:group . " guibg=#" . a:guibg
  endif
  if a:ctermfg != ""
    exec "hi " . a:group . " ctermfg=" . a:ctermfg
  endif
  if a:ctermbg != ""
    exec "hi " . a:group . " ctermbg=" . a:ctermbg
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif
  if a:guisp != ""
    exec "hi " . a:group . " guisp=#" . a:guisp
  endif
endfunction


fun <sid>hi(group, guifg, guibg, ctermfg, ctermbg, attr, guisp)
  call Base16hi(a:group, a:guifg, a:guibg, a:ctermfg, a:ctermbg, a:attr, a:guisp)
endfun

" Vim editor colors
call <sid>hi("Normal",        g:gui05, g:gui00, s:cterm05, s:cterm00, "", "")
call <sid>hi("Bold",          "", "", "", "", "bold", "")
call <sid>hi("Debug",         g:gui08, "", s:cterm08, "", "", "")
call <sid>hi("Directory",     g:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("Error",         g:gui08, g:gui00, s:cterm08, s:cterm00, "reverse", "")
call <sid>hi("ErrorMsg",      g:gui08, g:gui00, s:cterm08, s:cterm00, "", "")
call <sid>hi("Exception",     g:gui08, "", s:cterm08, "", "", "")
call <sid>hi("FoldColumn",    g:gui0C, g:gui01, s:cterm0C, s:cterm01, "", "")
call <sid>hi("Folded",        g:gui03, g:gui01, s:cterm03, s:cterm01, "", "")
call <sid>hi("IncSearch",     g:gui01, g:gui09, s:cterm01, s:cterm09, "none", "")
call <sid>hi("Italic",        "", "", "", "", "none", "")
call <sid>hi("Macro",         g:gui08, "", s:cterm08, "", "", "")
call <sid>hi("MatchParen",    g:gui00, g:gui03, s:cterm00, s:cterm03,  "", "")
call <sid>hi("ModeMsg",       g:gui00, g:gui08, s:cterm00, s:cterm08, "", "")
call <sid>hi("MoreMsg",       g:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("Question",      g:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("Search",        g:gui01, g:gui0A, s:cterm01, s:cterm0A,  "", "")
call <sid>hi("Substitute",    g:gui03, g:gui0A, s:cterm03, s:cterm0A, "none", "")
call <sid>hi("SpecialKey",    g:gui08, "", s:cterm08, "", "", "")
call <sid>hi("TooLong",       g:gui08, "", s:cterm08, "", "", "")
call <sid>hi("Underlined",    g:gui08, "", s:cterm08, "", "", "")
call <sid>hi("Visual",        g:gui00, g:gui03, s:cterm00, s:cterm03, "", "")
call <sid>hi("VisualNOS",     g:gui08, "", s:cterm08, "", "", "")
call <sid>hi("WarningMsg",    g:gui08, "", s:cterm08, "", "", "")
call <sid>hi("WildMenu",      g:gui08, g:gui0A, s:cterm08, "", "", "")
call <sid>hi("Title",         g:gui0D, "", s:cterm0D, "", "none", "")
call <sid>hi("Conceal",       g:gui0D, g:gui00, s:cterm0D, s:cterm00, "", "")
call <sid>hi("Cursor",        g:gui00, g:gui05, s:cterm00, s:cterm05, "", "")
call <sid>hi("NonText",       g:gui03, "", s:cterm03, "", "", "")
call <sid>hi("LineNr",        g:gui03, g:gui01, s:cterm03, s:cterm01, "", "")
call <sid>hi("SignColumn",    g:gui03, g:gui01, s:cterm03, s:cterm01, "", "")
call <sid>hi("StatusLine",    g:gui00, g:gui0B, s:cterm00, s:cterm0B, "none", "")
call <sid>hi("StatusLineNC",  g:gui00, g:gui02, s:cterm00, s:cterm02, "none", "")
call <sid>hi("VertSplit",     g:gui02, g:gui02, s:cterm02, s:cterm02, "none", "")
call <sid>hi("ColorColumn",   "", g:gui01, "", s:cterm01, "none", "")
call <sid>hi("CursorColumn",  "", g:gui01, "", s:cterm01, "none", "")
call <sid>hi("CursorLine",    "", g:gui01, "", s:cterm01, "none", "")
call <sid>hi("CursorLineNr",  g:gui04, g:gui01, s:cterm05, s:cterm01, "", "")
call <sid>hi("QuickFixLine",  "", g:gui01, "", s:cterm01, "none", "")
call <sid>hi("PMenu",         g:gui05, g:gui01, s:cterm05, s:cterm01, "none", "")
call <sid>hi("PMenuSel",      g:gui01, g:gui05, s:cterm01, s:cterm05, "", "")
call <sid>hi("TabLine",       g:gui03, g:gui01, s:cterm03, s:cterm01, "none", "")
call <sid>hi("TabLineFill",   g:gui03, g:gui01, s:cterm03, s:cterm01, "none", "")
call <sid>hi("TabLineSel",    g:gui0B, g:gui01, s:cterm0B, s:cterm01, "none", "")

" Standard syntax highlighting
call <sid>hi("Boolean",          g:gui09, "", s:cterm09, "", "", "")
call <sid>hi("Character",        g:gui08, "", s:cterm08, "", "", "")
call <sid>hi("Comment",          g:gui03, "", s:cterm03, "", "", "")
call <sid>hi("LineComment",      g:gui03, "", s:cterm03, "", "", "")
call <sid>hi("VimLineComment",   g:gui03, "", s:cterm03, "", "", "")
call <sid>hi("vimCommentTitle",  g:gui03, "", s:cterm03, "", "", "")
call <sid>hi("vimCommentString", g:gui03, "", s:cterm03, "", "", "")
call <sid>hi("Conditional",      g:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("Constant",         g:gui09, "", s:cterm09, "", "", "")
call <sid>hi("Define",           g:gui0E, "", s:cterm0E, "", "none", "")
call <sid>hi("Delimiter",        g:gui0F, "", s:cterm0F, "", "", "")
call <sid>hi("Float",            g:gui09, "", s:cterm09, "", "", "")
call <sid>hi("Function",         g:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("Identifier",       g:gui08, "", s:cterm08, "", "none", "")
call <sid>hi("Include",          g:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("Keyword",          g:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("Label",            g:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("Number",           g:gui09, "", s:cterm09, "", "", "")
call <sid>hi("Operator",         g:gui05, "", s:cterm05, "", "none", "")
call <sid>hi("PreProc",          g:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("Repeat",           g:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("Special",          g:gui0C, "", s:cterm0C, "", "", "")
call <sid>hi("SpecialChar",      g:gui0F, "", s:cterm0F, "", "", "")
call <sid>hi("Statement",        g:gui08, "", s:cterm08, "", "", "")
call <sid>hi("StorageClass",     g:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("String",           g:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("Structure",        g:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("Tag",              g:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("Todo",             g:gui0A, g:gui01, s:cterm0A, s:cterm01, "", "")
call <sid>hi("Type",             g:gui0A, "", s:cterm0A, "", "none", "")
call <sid>hi("Typedef",          g:gui0A, "", s:cterm0A, "", "", "")

" C highlighting
call <sid>hi("cOperator",   g:gui0C, "", s:cterm0C, "", "", "")
call <sid>hi("cPreCondit",  g:gui0E, "", s:cterm0E, "", "", "")

" C# highlighting
call <sid>hi("csClass",                 g:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("csAttribute",             g:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("csModifier",              g:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("csType",                  g:gui08, "", s:cterm08, "", "", "")
call <sid>hi("csUnspecifiedStatement",  g:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("csContextualStatement",   g:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("csNewDecleration",        g:gui08, "", s:cterm08, "", "", "")

" CSS highlighting
call <sid>hi("cssBraces",      g:gui05, "", s:cterm05, "", "", "")
call <sid>hi("cssClassName",   g:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("cssColor",       g:gui0C, "", s:cterm0C, "", "", "")

" Diff highlighting
call <sid>hi("DiffAdd",      g:gui0B, g:gui01,  s:cterm0B, s:cterm01, "reverse", "")
call <sid>hi("DiffChange",   g:gui03, g:gui01,  s:cterm03, s:cterm01, "reverse", "")
call <sid>hi("DiffDelete",   g:gui08, g:gui01,  s:cterm08, s:cterm01, "reverse", "")
call <sid>hi("DiffText",     g:gui0D, g:gui01,  s:cterm0D, s:cterm01, "reverse", "")
call <sid>hi("DiffAdded",    g:gui0B, g:gui00,  s:cterm0B, s:cterm00, "", "")
call <sid>hi("DiffFile",     g:gui08, g:gui00,  s:cterm08, s:cterm00, "", "")
call <sid>hi("DiffNewFile",  g:gui0B, g:gui00,  s:cterm0B, s:cterm00, "", "")
call <sid>hi("DiffLine",     g:gui0D, g:gui00,  s:cterm0D, s:cterm00, "", "")
call <sid>hi("DiffRemoved",  g:gui08, g:gui00,  s:cterm08, s:cterm00, "", "")

" Git highlighting
call <sid>hi("gitcommitOverflow",       g:gui08, "", s:cterm08, "", "", "")
call <sid>hi("gitcommitSummary",        g:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("gitcommitComment",        g:gui03, "", s:cterm03, "", "", "")
call <sid>hi("gitcommitUntracked",      g:gui03, "", s:cterm03, "", "", "")
call <sid>hi("gitcommitDiscarded",      g:gui03, "", s:cterm03, "", "", "")
call <sid>hi("gitcommitSelected",       g:gui03, "", s:cterm03, "", "", "")
call <sid>hi("gitcommitHeader",         g:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("gitcommitSelectedType",   g:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("gitcommitUnmergedType",   g:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("gitcommitDiscardedType",  g:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("gitcommitBranch",         g:gui09, "", s:cterm09, "", "bold", "")
call <sid>hi("gitcommitUntrackedFile",  g:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("gitcommitUnmergedFile",   g:gui08, "", s:cterm08, "", "bold", "")
call <sid>hi("gitcommitDiscardedFile",  g:gui08, "", s:cterm08, "", "bold", "")
call <sid>hi("gitcommitSelectedFile",   g:gui0B, "", s:cterm0B, "", "bold", "")

" GitGutter highlighting
call <sid>hi("GitGutterAdd",     g:gui0B, g:gui01, s:cterm0B, s:cterm01, "", "")
call <sid>hi("GitGutterChange",  g:gui0D, g:gui01, s:cterm0D, s:cterm01, "", "")
call <sid>hi("GitGutterDelete",  g:gui08, g:gui01, s:cterm08, s:cterm01, "", "")
call <sid>hi("GitGutterChangeDelete",  g:gui0E, g:gui01, s:cterm0E, s:cterm01, "", "")

" HTML highlighting
call <sid>hi("htmlBold",    g:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("htmlItalic",  g:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("htmlEndTag",  g:gui05, "", s:cterm05, "", "", "")
call <sid>hi("htmlTag",     g:gui05, "", s:cterm05, "", "", "")

" JavaScript highlighting
call <sid>hi("javaScript",        g:gui05, "", s:cterm05, "", "", "")
call <sid>hi("javaScriptBraces",  g:gui05, "", s:cterm05, "", "", "")
call <sid>hi("javaScriptNumber",  g:gui09, "", s:cterm09, "", "", "")
" pangloss/vim-javascript highlighting
call <sid>hi("jsOperator",          g:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("jsStatement",         g:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("jsReturn",            g:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("jsThis",              g:gui08, "", s:cterm08, "", "", "")
call <sid>hi("jsClassDefinition",   g:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("jsFunction",          g:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("jsFuncName",          g:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("jsFuncCall",          g:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("jsClassFuncName",     g:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("jsClassMethodType",   g:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("jsRegexpString",      g:gui0C, "", s:cterm0C, "", "", "")
call <sid>hi("jsGlobalObjects",     g:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("jsGlobalNodeObjects", g:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("jsExceptions",        g:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("jsBuiltins",          g:gui0A, "", s:cterm0A, "", "", "")

" Mail highlighting
call <sid>hi("mailQuoted1",  g:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("mailQuoted2",  g:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("mailQuoted3",  g:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("mailQuoted4",  g:gui0C, "", s:cterm0C, "", "", "")
call <sid>hi("mailQuoted5",  g:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("mailQuoted6",  g:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("mailURL",      g:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("mailEmail",    g:gui0D, "", s:cterm0D, "", "", "")

" Markdown highlighting
call <sid>hi("markdownCode",              g:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("markdownError",             g:gui05, g:gui00, s:cterm05, s:cterm00, "", "")
call <sid>hi("markdownCodeBlock",         g:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("markdownHeadingDelimiter",  g:gui0D, "", s:cterm0D, "", "", "")

" NERDTree highlighting
call <sid>hi("NERDTreeDirSlash",  g:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("NERDTreeExecFile",  g:gui05, "", s:cterm05, "", "", "")

" PHP highlighting
call <sid>hi("phpMemberSelector",  g:gui05, "", s:cterm05, "", "", "")
call <sid>hi("phpComparison",      g:gui05, "", s:cterm05, "", "", "")
call <sid>hi("phpParent",          g:gui05, "", s:cterm05, "", "", "")

" Python highlighting
call <sid>hi("pythonOperator",  g:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("pythonRepeat",    g:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("pythonInclude",   g:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("pythonStatement", g:gui0E, "", s:cterm0E, "", "", "")

" Ruby highlighting
call <sid>hi("rubyAttribute",               g:gui0D, "", s:cterm0D, "", "", "")
call <sid>hi("rubyConstant",                g:gui0A, "", s:cterm0A, "", "", "")
call <sid>hi("rubyInterpolationDelimiter",  g:gui0F, "", s:cterm0F, "", "", "")
call <sid>hi("rubyRegexp",                  g:gui0C, "", s:cterm0C, "", "", "")
call <sid>hi("rubySymbol",                  g:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("rubyStringDelimiter",         g:gui0B, "", s:cterm0B, "", "", "")

" SASS highlighting
call <sid>hi("sassidChar",     g:gui08, "", s:cterm08, "", "", "")
call <sid>hi("sassClassChar",  g:gui09, "", s:cterm09, "", "", "")
call <sid>hi("sassInclude",    g:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("sassMixing",     g:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("sassMixinName",  g:gui0D, "", s:cterm0D, "", "", "")

" Signify highlighting
call <sid>hi("SignifySignAdd",     g:gui0B, g:gui01, s:cterm0B, s:cterm01, "", "")
call <sid>hi("SignifySignChange",  g:gui0D, g:gui01, s:cterm0D, s:cterm01, "", "")
call <sid>hi("SignifySignDelete",  g:gui08, g:gui01, s:cterm08, s:cterm01, "", "")

" Spelling highlighting
call <sid>hi("SpellBad",     g:gui08, g:gui05, s:cterm08, s:cterm05, "reverse", "")
call <sid>hi("SpellLocal",   g:gui09, g:gui05, s:cterm09, s:cterm05, "reverse", "")
call <sid>hi("SpellCap",     g:gui0A, g:gui05, s:cterm0A, s:cterm05, "reverse", "")
call <sid>hi("SpellRare",    g:gui0B, g:gui05, s:cterm0B, s:cterm05, "reverse", "")

" Startify highlighting
call <sid>hi("StartifyBracket",  g:gui03, "", s:cterm03, "", "", "")
call <sid>hi("StartifyFile",     g:gui07, "", s:cterm07, "", "", "")
call <sid>hi("StartifyFooter",   g:gui03, "", s:cterm03, "", "", "")
call <sid>hi("StartifyHeader",   g:gui0B, "", s:cterm0B, "", "", "")
call <sid>hi("StartifyNumber",   g:gui09, "", s:cterm09, "", "", "")
call <sid>hi("StartifyPath",     g:gui03, "", s:cterm03, "", "", "")
call <sid>hi("StartifySection",  g:gui0E, "", s:cterm0E, "", "", "")
call <sid>hi("StartifySelect",   g:gui0C, "", s:cterm0C, "", "", "")
call <sid>hi("StartifySlash",    g:gui03, "", s:cterm03, "", "", "")
call <sid>hi("StartifySpecial",  g:gui03, "", s:cterm03, "", "", "")

" Remove functions
delf <sid>hi
delf g:Base16hi

" Remove color variables
unlet g:gui00 g:gui01 g:gui02 g:gui03  g:gui04  g:gui05  g:gui06  g:gui07  g:gui08  g:gui09 g:gui0A  g:gui0B  g:gui0C  g:gui0D  g:gui0E  g:gui0F
