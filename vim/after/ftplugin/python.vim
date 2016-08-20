setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4
setlocal textwidth=119
setlocal autoindent

" Remove trailing whitespace
autocmd BufWritePre *.py %s/\s\+$//e
