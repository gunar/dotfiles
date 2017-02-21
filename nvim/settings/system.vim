source ~/.local.vim
" Neovim Settings
if (has("termguicolors"))
  set termguicolors
endif
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let $NEOVIM_JS_DEBUG='~/.nvimjsdebug'
set clipboard+=unnamedplus
" Currently needed for neovim paste issue
set pastetoggle=<f6>
" Let airline tell me my status
set noshowmode
set noswapfile
filetype on
set relativenumber number
set tabstop=2 shiftwidth=2 expandtab
set conceallevel=0
" block select not limited by shortest line
set virtualedit=
set wildmenu
set laststatus=2
"set colorcolumn=100
set wrap linebreak nolist
set wildmode=full
" leader is ,
let mapleader = ','
set undofile
set undodir="$HOME/.VIM_UNDO_FILES"
" incremental replace
set inccommand=split " nosplit
" Remember cursor position between vim sessions
autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif
" center buffer around cursor when opening files
autocmd BufRead * normal zz

let g:jsx_ext_required = 0
set complete=.,w,b,u,t,k
let g:gitgutter_max_signs = 1000  " default value

" Auto CD to current file's directory
" autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
" autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)

let g:lua_complete_omni = 1

let g:indentLine_char='│'
" enable deoplete
let g:deoplete#enable_at_startup = 1

let g:auto_save = 1
let g:auto_save_in_insert_mode = 0


" visual-at https://github.com/stoeffel/.dotfiles/blob/master/vim/visual-at.vim<Paste>
" allows you to select multiple lines and run a macro on each
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" add margin to the view
set scrolloff=5

" type writer sound
function! PlaySound()
  call jobstart('aplay ~/.config/nvim/settings/typewriter.wav')
endfunction
function! TypeWriter()
  augroup TypeWriter
    autocmd!
    autocmd CursorMovedI * call PlaySound()
  augroup END
endfunction
