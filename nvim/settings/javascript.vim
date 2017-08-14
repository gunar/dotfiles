" Javscript omni complete
let g:vimjs#casesensistive = 1
let g:vimjs#smartcomplete = 1
set completeopt-=preview
let g:tsuquyomi_disable_quickfix = 1
let g:vim_json_syntax_conceal = 0
let g:deoplete#omni_patterns = {}

" Remove trailing spaces
autocmd BufWritePre *.js :%s/\s\+$//e

" tern_for_vim --- {{{{
" this fucks up with eslint message
" let g:tern_show_argument_hints='on_move' 
nnoremap <silent> <leader>gd :TernDef<CR>
nnoremap <silent> <leader>gf :TernRefs<CR>
nnoremap <silent> <leader>gr :TernRename<CR>
" --- }}}

" deoplete-ternjs --- {{{
" Use deoplete.
let g:tern_request_timeout = 1
" let g:tern_show_signature_in_pum = '0'  " This do disable full signature type on autocomplete
"Add extra filetypes
let g:tern#filetypes = [
                \ 'jsx',
                \ ]
" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
" --- }}}
