" Load pathogen
execute pathogen#infect()
execute pathogen#helptags()

" Configure syntastic linters
let g:syntastic_python_checkers = ['flake8', 'pydocstyle', 'py3kwarn']
let g:syntastic_python_flake8_args = "--max-line-length 99"
let g:syntastic_bash_checkers = ['shellcheck']
let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1

" Configure vim-markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_no_default_key_mappings=1

" Enable syntax highlighting
syntax on

" Default tabs & indentation is 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent

" Case-insensitive, highlighted search
set ignorecase
set hlsearch
hi Search ctermfg=black ctermbg=LightBlue

" Configure viminfo file
set viminfo='20,<100,s10

" Display line info
set ruler

" Press F2 to switch between paste and nopaste (bypasses autoindent)
set pastetoggle=<F2>

" Add colored columns to guide coding standards (python only)
highlight ColorColumn ctermbg=235 guibg=#2c2d27
set colorcolumn=80,100,120

" When opening a file, return the cursor to its last known position
au BufWinEnter * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Activate filetype-specific plugins
filetype plugin on
filetype plugin indent on
