" ----------------------------------------------------------------------
"  $RCSfile$
"
"  Vim settings when called from Mutt
"
"  $Id$
"

" Probably needless, but just to play it safe...
set ft=mail

" 72-char per line max, set en spell checker
set tw=72
setlocal spell spelllang=en

set formatoptions=tcql

" Chars sometime used for quoting
set comments+=n:\|
set comments+=n:%

" ----------------------------------------------------------------------
"  Suppressing quoted signature(s) if any when replying
"  (from http://cedricduval.free.fr/download/mail.vim)
"
function! Mail_Erase_Sig()

        " Search for the signature pattern (takes into account signature delimiters
        " from broken mailers that forget the space after the two dashes)
        let i = 0
        while ((i <= line('$')) && (getline(i) !~ '^> *-- \=$'))
                let i = i + 1
        endwhile

        " If found, then
        if (i != line('$') + 1)
                " Look for author's signature, to avoid deleting it
                let j = i
                while (j < line('$') && (getline(j + 1) !~ '^-- $'))
                        let j = j + 1
                endwhile

                " Search for the last non empty (non sig) line
                while ((i > 0) && (getline(i - 1) =~ '^\(>\s*\)*$'))
                        let i = i - 1
                endwhile

                " Delete those lines plus the signature
                exe ':'.i.','.j.'-1d'
        endif
endfunction

" ----------------------------------------------------------------------
" Replacing empty quoted lines (e.g. "> $") with empty lines
" (convenient to automatically reformat one paragraph)
"
function! Mail_Del_Empty_Quoted()
        exe "normal :%s/^>[[:space:]\%\|\#>]\\+$//e\<CR>"
endfunction

" ----------------------------------------------------------------------
" Moving the cursor at the begining of the mail
"
function! Mail_Begin()
        exe "normal gg"
        if getline (line ('.')) =~ '^From: '
                " When using edit_headers in Mutt, go after the headers
                exe "normal /^$\<CR>"
        endif
endfunction

" ----------------------------------------------------------------------
" Init
"
silent call Mail_Erase_Sig()
"call Mail_Del_Empty_Quoted()
silent call Mail_Begin()
