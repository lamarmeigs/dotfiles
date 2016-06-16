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
syntax on
set expandtab
set textwidth=119
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set ignorecase
set viminfo='20,<1000
set ruler
set hlsearch
set pastetoggle=<F2>

highlight ColorColumn ctermbg=235 guibg=#2c2d27
set colorcolumn=80,120

function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END
hi Search	cterm=NONE ctermfg=black ctermbg=yellow

autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType handlebars setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
