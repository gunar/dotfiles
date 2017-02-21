" Theme
syntax enable
colorscheme OceanicNext
set background=dark
" highlightt the current line number
hi CursorLineNR guifg=#ffffff
" no need to fold things in markdown all the time
let g:vim_markdown_folding_disabled = 1
" turn on spelling for markdown files
augroup spelling
  autocmd!
  autocmd BufRead,BufNewFile *.md setlocal spell complete+=kspell
augroup END
" highlight bad words in red
hi SpellBad guibg=#ff2929 guifg=#ffffff" ctermbg=224
" disable markdown auto-preview. Gets annoying
let g:instant_markdown_autostart = 0
" Keep my termo window open when I navigate away
augroup term_open
  autocmd!
  autocmd TermOpen * set bufhidden=hide
augroup END
