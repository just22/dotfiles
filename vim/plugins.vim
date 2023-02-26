" ----------------------------------------------------------------------------
"  Plugins config section (using Vundle)
" ----------------------------------------------------------------------------

" Vundle set-up:
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundles/vundle
"
filetype off
set rtp+=~/.vim/bundles/vundle/
call vundle#rc("~/.vim/bundles")

call vundle#begin()

" Required {
Plugin 'gmarik/vundle'
" }

Plugin 'https://github.com/wincent/terminus'

Plugin 'https://github.com/jpalardy/vim-slime'

Plugin 'https://github.com/sk1418/QFGrep'

Plugin 'https://github.com/AndrewRadev/linediff.vim'

Plugin 'https://github.com/chrisbra/csv.vim'

" { vimwiki
Plugin 'https://github.com/mattn/calendar-vim'
Plugin 'https://github.com/vimwiki/vimwiki'
" }

Plugin 'https://github.com/godlygeek/tabular'

Plugin 'VisIncr'

Plugin 'https://github.com/ervandew/supertab'

Plugin 'https://github.com/christoomey/vim-tmux-navigator'

Plugin 'https://github.com/mbbill/undotree'

Plugin 'https://github.com/tpope/vim-commentary'

Plugin 'https://github.com/hrj/vim-drawit'

Plugin 'https://github.com/lervag/vimtex'

Plugin 'https://github.com/junegunn/fzf.vim'

" { vim-snipmate
Plugin 'https://github.com/tomtom/tlib_vim'
Plugin 'https://github.com/MarcWeber/vim-addon-mw-utils'
Plugin 'https://github.com/garbas/vim-snipmate'
Plugin 'https://github.com/honza/vim-snippets'
" }

call vundle#end()

" Enable extended % matching
runtime macros/matchit.vim

" Enable file type detection and load indent files, to automatically do
" language-dependent indenting
"filetype plugin indent on
filetype plugin on

" terminus
let g:TerminusMouse = 0
let g:TerminusCursorShape=0

" vim-slime
if exists("$TMUX")
let g:slime_target = "tmux"
let g:slime_paste_file = "/tmp/$USER.vim-slime.paste"
let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": ":.right"}
let g:slime_dont_ask_default = 1
let g:slime_no_mappings = 1
endif

" vim-notes
let g:notes_directories = ['$HOME/notes']
let g:notes_suffix = ".txt"
let g:notes_unicode_enabled = 0

" supertab (+ completion popup menu adjustment)
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabLongestHighlight = 1
let g:SuperTabMappingForward = "<F1>"
let g:SuperTabMappingBackward = "<S-F1>"
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
nmap <silent> <Esc>[1;5A :TmuxNavigateUp<CR>
nmap <silent> <Esc>[1;5B :TmuxNavigateDown<CR>
nmap <silent> <Esc>[1;5C :TmuxNavigateRight<CR>
nmap <silent> <Esc>[1;5D :TmuxNavigateLeft<CR>
nmap <silent> <Esc>[A    :TmuxNavigateUp<CR>
nmap <silent> <Esc>[B    :TmuxNavigateDown<CR>
nmap <silent> <Esc>[C    :TmuxNavigateRight<CR>
nmap <silent> <Esc>[D    :TmuxNavigateLeft<CR>
nmap <silent> <C-\>      :TmuxNavigatePrevious<CR>

" netrw (see http://ivanbrennan.nyc/blog/2014/01/16/rigging-vims-netrw)
let g:netrw_liststyle = 3         " 0: thin view; 3: tree view
let g:netrw_banner = 0            " No banner

" vimwiki
" let g:vimwiki_list = [{'path': '~/notes/',
"                      \ 'syntax': 'markdown', 'ext': '.md'}]
" let g:vimwiki_global_ext = 0

let g:vimwiki_list = [{'path': '~/notes/'}]

let g:vimwiki_listsyms = ' .X'

function! VimwikiLinkHandler(link)
" Use Vim to open external files with the 'file:' scheme.  E.g.:
let link = a:link
if link =~# '^file:'
        let link_infos = vimwiki#base#resolve_link(link)
        if link_infos.filename == ''
                echomsg 'Vimwiki Error: Unable to resolve link!'
                return 0
        else
                exe 'edit ' . fnameescape(link_infos.filename)
                return 1
        endif
else
        return 0
endif
endfunction

let g:tex_flavor = 'latex'
let g:vimtex_quickfix_ignore_filters = [
\ 'Overfull',
\ 'Underfull',
\ 'setting the option has no effect',
\ 'functionality may be reduced/unavailable',
\ 'Token not allowed in a PDF string',
\ 'references',
\ 'Empty bibliography',
\ 'Please (re)run BibTeX on the file(s)',
\]
let g:Tex_MultipleCompileFormats = 'pdf,bibtex,pdf'
let g:vimtex_quickfix_autoclose_after_keystrokes = 1
let g:vimtex_view_method = 'mupdf'

" calendar-vim
let g:calendar_monday = 1
let g:calendar_weeknm = 1

" vim-snipmate
let g:snipMate = { 'snippet_version' : 1 }

