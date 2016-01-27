" based on  : https://github.com/mhartington/dotfiles/

let vimsettings = '~/.config/nvim/settings'

exe 'source' vimsettings . '/plugins.vim'

if pluginsExist
" System Settings  ----------------------------------------------------------{{{

  source ~/.local.vim
" Neovim Settings
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
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
  autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
  autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
  let g:lua_complete_omni = 1

  let g:indentLine_char='│'
  " enable deoplete
  let g:deoplete#enable_at_startup = 1

" }}}

" " Snipppets -----------------------------------------------------------------{{{
" 
" " Enable snipMate compatibility feature.
"   let g:neosnippet#enable_snipmate_compatibility = 1
"   imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"   smap <C-k>     <Plug>(neosnippet_expand_or_jump)
"   xmap <C-k>     <Plug>(neosnippet_expand_target)
" " Tell Neosnippet about the other snippets
"   let g:neosnippet#snippets_directory='~/.vim/bundle/neosnippet-snippets/neosnippets'
" 
" " SuperTab like snippets behavior.
"   imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"   \ "\<Plug>(neosnippet_expand_or_jump)"
"   \: pumvisible() ? "\<C-n>" : "\<TAB>"
"   smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"   \ "\<Plug>(neosnippet_expand_or_jump)"
"   \: "\<TAB>"
" 
" "}}}
" 
" " Javscript omni complete --------------------------------------{{{
"   let g:vimjs#casesensistive = 1
"   let g:vimjs#smartcomplete = 1
"   set completeopt-=preview
"   let g:tsuquyomi_disable_quickfix = 1
"   let g:vim_json_syntax_conceal = 0
"   let g:deoplete#omni_patterns = {}
" "}}}
" 
" " Emmet customization -------------------------------------------------------{{{
" " Enable Emmet in all modes
"   let g:user_emmet_mode='a'
" " Remapping <C-y>, just doesn't cut it.
"   function! s:expand_html_tab()
" " try to determine if we're within quotes or tags.
" " if so, assume we're in an emmet fill area.
"    let line = getline('.')
"    if col('.') < len(line)
"      let line = matchstr(line, '[">][^<"]*\%'.col('.').'c[^>"]*[<"]')
"      if len(line) >= 2
"         return "\<C-n>"
"      endif
"    endif
" " expand anything emmet thinks is expandable.
"   if emmet#isExpandable()
"     return "\<C-y>,"
"   endif
" " return a regular tab character
"    return "\<tab>"
"    endfunction
"    autocmd FileType html,markdown imap <buffer><expr><tab> <sid>expand_html_tab()
" 
"    let g:use_emmet_complete_tag = 1
"    let g:user_emmet_install_global = 0
"    autocmd FileType html,css,ejs EmmetInstall
" "}}}
" 
" " Linting -------------------------------------------------------------------{{{
" 
" 
"   function! neomake#makers#ft#javascript#eslint()
"       return {
"           \ 'args': ['-f', 'compact'],
"           \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
"           \ '%W%f: line %l\, col %c\, Warning - %m'
"           \ }
"   endfunction
"   let g:neomake_javascript_enabled_makers = ['eslint']
"   autocmd! BufWritePost * Neomake
"   function! JscsFix()
"       let l:winview = winsaveview()
"       % ! jscs -x
"       call winrestview(l:winview)
"   endfunction
"   command JscsFix :call JscsFix()
"   noremap <leader>j :JscsFix<CR>
" "}}}


" Settings
" Based on https://github.com/skwp/dotfiles/blob/master/vim/settings.vim
for fpath in split(globpath(vimsettings, '*.vim'), '\n')
  exe 'source' fpath
endfor

endif
