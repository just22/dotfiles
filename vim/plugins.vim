" ----------------------------------------------------------------------------
"  Plugins config section (using vim-plug)
" ----------------------------------------------------------------------------

" vim-plug set-up
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
        silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim
        \       --create-dirs
        \       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Note: Putting customizations in between plug#begin and plug#end means setting
"       them *before* activating the plugins, which is the right thing to do in
"       most of the cases

call plug#begin('~/.vim/plug_dir')

" Colorschemes {
Plug 'https://github.com/alligator/accent.vim'
Plug 'https://github.com/tinted-theming/base16-vim'
" }

Plug 'https://github.com/jpalardy/vim-slime'
if exists("$TMUX")
let g:slime_target = "tmux"
let g:slime_paste_file = "/tmp/$USER.vim-slime.paste"
let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": ":.right"}
let g:slime_dont_ask_default = 1
let g:slime_no_mappings = 1
endif


Plug 'https://github.com/lervag/vimtex'
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
let g:vimtex_view_method = 'general'

Plug 'https://github.com/mbbill/undotree'

Plug 'https://github.com/sk1418/QFGrep'

Plug 'https://github.com/tpope/vim-commentary'

Plug 'https://github.com/vim-scripts/VisIncr'

" { fzf
Plug 'https://github.com/junegunn/fzf'
Plug 'https://github.com/junegunn/fzf.vim'
" }

" tmux integration {
Plug 'https://github.com/wincent/terminus'
Plug 'https://github.com/christoomey/vim-tmux-navigator'
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
" }

" vim-snipmate {
Plug 'https://github.com/tomtom/tlib_vim'
Plug 'https://github.com/MarcWeber/vim-addon-mw-utils'
Plug 'https://github.com/garbas/vim-snipmate'
let g:snipMate = { 'snippet_version' : 1 }
Plug 'https://github.com/honza/vim-snippets'
" }

" Initialize plugin system
" (Automatically executes `filetype plugin indent on` and `syntax enable`)
call plug#end()

" vim-commentary: no space. please!
autocmd FileType * :let b:commentary_format = &commentstring


" The following plugins are part of the default Vim installation:
" ****************************************************************************

" Enable extended % matching
runtime macros/matchit.vim

" netrw
let g:netrw_liststyle = 3         " Tree view
let g:netrw_banner = 1            " Enable banner

" Enable the :Man command
runtime ftplugin/man.vim

