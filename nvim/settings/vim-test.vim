let test#strategy = "neovim"
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>td :TestNearest debug<CR>
nmap <silent> <leader>T :TestFile<CR>

" --- {{{TypeScript
let g:test#javascript#mocha#file_pattern = '\v.*\.spec\.(ts|tsx)$'
function! TypeScriptTransform(cmd) abort
  return substitute(a:cmd, '\v(.*)mocha', 'TS_NODE_FILES=true \1ts-mocha', '')
endfunction
let g:test#custom_transformations = {'typescript': function('TypeScriptTransform')}
let g:test#transformation = 'typescript'
" --- }}}
