" function! neomake#makers#ft#javascript#eslint()
" return {
" let g:neomake_javascript_eslint_maker = {
"   \ 'args': ['-f', 'compact'],
"   \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
"   \ '%W%f: line %l\, col %c\, Warning - %m'
"   \ }
" endfunction

let g:neomake_markdown_vale_maker = {
\ 'exe': 'vale',
\ 'args': ['--output', 'line'],
\ 'errorformat': '/%f:%l:%c:%s:%m'
\ }
let g:neomake_markdown_enabled_makers = ['vale']

let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']

" Prefer local eslint over global
" (https://github.com/benjie/neomake-local-eslint.vim)
" let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
" let b:neomake_javascript_eslint_exe = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
" Use local eslint if available, global otherwise
" This is so plugins locally installed work
function! NeomakeESlintChecker()
  let l:npm_bin = ''
  let l:eslint = 'eslint'

  if executable('npm')
    let l:npm_bin = split(system('npm bin'), '\n')[0]
  endif

  if strlen(l:npm_bin) && executable(l:npm_bin . '/eslint')
    let l:eslint = l:npm_bin . '/eslint'
  endif

  let b:neomake_javascript_eslint_exe = l:eslint
  let b:neomake_javascript_eslint_args = ['-f', 'compact', '--fix']
endfunction
augroup neomake_lint
  autocmd FileType javascript :call NeomakeESlintChecker()
  autocmd BufWritePost,BufReadPost * Neomake
augroup END

nmap <F2> :lfirst<cr>
