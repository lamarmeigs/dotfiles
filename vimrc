" Load pathogen
execute pathogen#infect()
execute pathogen#helptags()

" Configure ALE linter
let g:ale_virtualtext_cursor = 'disabled'
let g:ale_linters_ignore = {'terraform': ['tfsec'], 'python': ['pylint']}
nnoremap <silent> <C-a> <Cmd>ALEDetail<CR>

" Configure vim-markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_no_default_key_mappings=1

" Configure vim-terraform
let g:terraform_fmt_on_save=1
let g:terraform_align=1
let g:hcl_align=1

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
