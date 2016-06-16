" Load pathogen
execute pathogen#infect()
execute pathogen#helptags()

" Configure syntastic linters
let g:syntastic_python_checkers = ['flake8', 'mypy', 'pep257', 'py3kwarn', 'python']
let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1

" Configure vim-markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_no_default_key_mappings=1

" Custom
" needs review; may be obsolete and non-functional
syntax on

" configure indentation and tabs to be 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent

" wrap text at 120 columns
set textwidth=119

" case-insensitive, highlighted search
set ignorecase
set hlsearch
hi Search	cterm=NONE ctermfg=black ctermbg=LightBlue

" ???
set viminfo='20,<1000

" Display line info
set ruler

" Press F2 to switch between paste and nopaste
set pastetoggle=<F2>

" Add colored columns to guide coding standards (python only)
highlight ColorColumn ctermbg=235 guibg=#2c2d27
set colorcolumn=80,120

" When opening a file, return the cursor to its last known position
function! ResCur()
    if line ("'\"") > 1 && line("'\"") <= line("$")
        normal! g`"
    endif
endfunction
augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

" Filetype-specific configurations
filetype plugin on
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
