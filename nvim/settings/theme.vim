" Theme
syntax enable
colorscheme OceanicNext
set background=dark
highlight Search guifg='black'
" highlightt the current line number
hi CursorLineNR guifg=#ffffff
" no need to fold things in markdown all the time
let g:vim_markdown_folding_disabled = 1
" highlight bad words in red
hi SpellBad guibg=#882929 guifg=#ffffff" ctermbg=224
" hi SpellBad guibg=#ff2929 guifg=#ffffff" ctermbg=224
" disable markdown auto-preview. Gets annoying
let g:instant_markdown_autostart = 0
" Keep my termo window open when I navigate away
augroup term_open
  autocmd!
  autocmd TermOpen * set bufhidden=hide
augroup END

" transparent background
hi Normal guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE

if &term =~ '256color'
    set t_ut=
endif
