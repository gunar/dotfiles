" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/dotfiles/nvim/snippets'
let g:neosnippet#enable_auto_clear_markers=0

" remove markers
augroup remove_markers
  autocmd!
  autocmd InsertLeave * NeoSnippetClearMarkers
augroup END
