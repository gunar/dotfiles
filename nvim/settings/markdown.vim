au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md  set ft=markdown

augroup neomake_lint_md
  autocmd FileType markdown setlocal conceallevel=2
  autocmd FileType markdown :Neomake
  call neomake#configure#automake('w')
augroup END

" " turn on spelling for markdown files
" augroup spelling
"   autocmd!
"   autocmd BufRead,BufNewFile *.md setlocal spell complete+=kspell
" augroup END
"
