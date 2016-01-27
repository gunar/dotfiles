" function! neomake#makers#ft#javascript#eslint()
" return {
" let g:neomake_javascript_eslint_maker = {
"   \ 'args': ['-f', 'compact'],
"   \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
"   \ '%W%f: line %l\, col %c\, Warning - %m'
"   \ }
" endfunction
let g:neomake_javascript_enabled_makers = ['eslint']

" Prefer local eslint over global
" (https://github.com/benjie/neomake-local-eslint.vim)
let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
let b:neomake_javascript_eslint_exe = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
 
autocmd! BufWritePost,BufReadPost * Neomake

nmap <F2> :lfirst<cr>
