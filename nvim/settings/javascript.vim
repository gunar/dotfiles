" Keymaps
" Sort {} stuff
nnoremap <C-s> vi{=vi{:sort i<cr>
" Sort [] stuff
nnoremap <leader>s vi[=vi[:sort i<cr>
nnoremap <leader>l muyiwgg/lodash?{opA,==vi{=vi{:sort i<cr>'u

" Javscript omni complete
let g:vimjs#casesensistive = 1
let g:vimjs#smartcomplete = 1
let g:tsuquyomi_disable_quickfix = 1
let g:vim_json_syntax_conceal = 0
let g:deoplete#omni_patterns = {}

" Codi
nnoremap <silent> <C-c> :Codi!!<CR>

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

" This would disable the preview window
" set completeopt-=preview
" This to close preview when insert mode leaves
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

let g:tern_request_timeout = 1
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#filter = 0
" let g:tern_show_signature_in_pum = '1'  " This do disable full signature type on autocomplete
"Add extra filetypes
let g:tern#filetypes = [
                \ 'jsx',
                \ ]
" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
" --- }}}
