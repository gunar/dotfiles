" The default keybinding for this plugin is <Leader><Leader>
" The keybindings below do not replace it. They only add new ones.

" TODO:
" - Add further enhancements proposed in the repo
"   https://github.com/easymotion/vim-easymotion#integration-with-incsearchvim

" " <Leader>f{char} to move to {char}
" map  <Leader>f <Plug>(easymotion-bd-f)
" nmap <Leader>f <Plug>(easymotion-overwin-f)
" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
