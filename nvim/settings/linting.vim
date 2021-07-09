" function! neomake#makers#ft#javascript#eslint()
" return {
" let g:neomake_javascript_eslint_maker = {
"   \ 'args': ['-f', 'compact'],
"   \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
"   \ '%W%f: line %l\, col %c\, Warning - %m'
"   \ }
" endfunction


let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']

" Prefer local eslint over global
" (https://github.com/benjie/neomake-local-eslint.vim)
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
  " Making eslint fix problems live is problematic while coding
  " let b:neomake_javascript_eslint_args = ['-f', 'compact', '--fix']
endfunction

augroup neomake_lint
  autocmd FileType javascript :call NeomakeESlintChecker()
  call neomake#configure#automake('w')
augroup END

nmap <F2> :lfirst<cr>

" disable linter for typescript not to conflict with nvim-typescript and spawning two tsserver
let g:ale_linters = {
  \ 'clojure': ['clj-kondo', 'joker'],
  \ 'typescript': [],
  \ 'typescriptreact': [],
\}
  " \ 'typescript': ['tslint'],
  " \ 'typescriptreact': ['prettier', 'tslint'],

" " TODO: Remove prettier plugin as ALE can handle it
" let g:ale_fixers = {
"   \ 'clojure': ['clj-kondo', 'joker'],
"   \ 'typescript': ['prettier','tslint'],
"   \ 'typescriptreact': ['prettier', 'tslint'],
" \}
"
" let g:ale_fix_on_save = 1
au BufRead,BufNewFile *.ipynb set filetype=json
