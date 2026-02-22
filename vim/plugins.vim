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
" }

" tmux integration {
    Plug 'https://github.com/christoomey/vim-tmux-navigator'
    let g:tmux_navigator_no_mappings = 1
    nmap <silent> <Esc>[1;5A :TmuxNavigateUp<CR>
    nmap <silent> <Esc>[1;5B :TmuxNavigateDown<CR>
    nmap <silent> <Esc>[1;5C :TmuxNavigateRight<CR>
    nmap <silent> <Esc>[1;5D :TmuxNavigateLeft<CR>
    nmap <silent> <C-\>      :TmuxNavigatePrevious<CR>

    Plug 'https://github.com/jpalardy/vim-slime'
    if exists("$TMUX")
    let g:slime_target = "tmux"
    let g:slime_paste_file = "/tmp/$USER.vim-slime.paste"
    let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": ":.right"}
    let g:slime_dont_ask_default = 1
    let g:slime_no_mappings = 1
    endif
" }

" Filter entries in quickfix window
Plug 'https://github.com/sk1418/QFGrep'

" Comment stuff out
Plug 'https://github.com/tpope/vim-commentary'

" Make columns of increasing or decreasing numbers, dates, or daynames
Plug 'https://github.com/vim-scripts/VisIncr'

" fzf {
    Plug 'https://github.com/junegunn/fzf'
    Plug 'https://github.com/junegunn/fzf.vim'
    let g:fzf_preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-/']
    let g:fzf_layout =
        \ {'window': {'width': 1.0, 'height': 0.25, 'xoffset': -1.0, 'yoffset': 1.0}}
" }

" vim-snipmate {
Plug 'https://github.com/tomtom/tlib_vim'
Plug 'https://github.com/MarcWeber/vim-addon-mw-utils'

Plug '~/.vim/unmanaged_plugins/rcsvers'
let g:rvSaveDirectoryType = 1
let g:rvSaveDirectoryName = '~/.vim/RCSfiles/'
let g:rvRlogOptions = '-zLT'
nmap <silent> <leader>t  <leader>rlog
nmap <silent> <leader>tp <leader>older
nmap <silent> <leader>tn <leader>newer

" Initialize plugin system
" (Automatically executes `filetype plugin indent on` and `syntax enable`)
call plug#end()

" vim-commentary: no space. please!
autocmd VimEnter *
    \ :let b:commentary_format = substitute(&commentstring, ' ', '', '')


" ----------------------------------------------------------------------------
" The following plugins are part of the default Vim installation:
"

" Enable extended % matching
runtime macros/matchit.vim

" Enable the :Man command
runtime ftplugin/man.vim

" netrw
let g:netrw_liststyle = 3         " Tree view
let g:netrw_banner = 1            " Enable banner
let g:netrw_fastbrowse = 0        " Never re-uses directory listings

augroup netrwAutoCmd
    autocmd!
    autocmd FileType netrw setlocal bufhidden=wipe
    autocmd BufLeave,WinLeave *
        \  if getbufvar(winbufnr(winnr()), "&filetype") == "netrw"
        \|     bwipeout!
        \| endif
augroup END

