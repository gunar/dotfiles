" based on  : https://github.com/mhartington/dotfiles/

" Setup NeoBundle  ----------------------------------------------------------{{{
" If vundle is not installed, do it first
  let bundleExists = 1
  if (!isdirectory(expand("$HOME/.nvim/bundle/neobundle.vim")))
     call system(expand("mkdir -p $HOME/.nvim/bundle"))
     call system(expand("git clone https://github.com/Shougo/neobundle.vim ~/.nvim/bundle/neobundle.vim"))
     let bundleExists = 0
  endif
  if 0 | endif

  if has('vim_starting')
    if &compatible
      " Be iMproved
      set nocompatible
    endif

" Required:
    set runtimepath+=~/.nvim/bundle/neobundle.vim/
  endif

" Required:
  call neobundle#begin(expand('~/.nvim/bundle/'))
  let pluginsExist = 1
" Let NeoBundle manage NeoBundle
" Required:
  NeoBundleFetch 'Shougo/neobundle.vim'

" syntax
  " NeoBundle 'pangloss/vim-javascript'
  " NeoBundle 'jelera/vim-javascript-syntax'
  " NeoBundle 'mxw/vim-jsx'
 NeoBundle 'othree/yajs.vim'
  " NeoBundle 'othree/es.next.syntax.vim'

  " NeoBundle '1995eaton/vim-better-javascript-completion'
  " NeoBundle 'hail2u/vim-css3-syntax'
  " NeoBundle 'moll/vim-node'
  " " NeoBundle 'vim-scripts/SyntaxComplete'
  " NeoBundle 'othree/javascript-libraries-syntax.vim'
  " NeoBundleLazy 'elzr/vim-json', {'autoload':{'filetypes':['json']}}
  " NeoBundle 'tpope/vim-markdown'
  " NeoBundle 'suan/vim-instant-markdown'
" colorscheme & syntax highlighting
  NeoBundle 'mhartington/oceanic-next'
  " NeoBundle 'Yggdroot/indentLine'
  " NeoBundle 'myhere/vim-nodejs-complete'
  " NeoBundle 'Raimondi/delimitMate'
  " NeoBundle 'valloric/MatchTagAlways'
 ""  Git helpers
  " NeoBundle 'tpope/vim-fugitive'
  " NeoBundle 'jreybert/vimagit'
  " NeoBundle 'airblade/vim-gitgutter'
  " NeoBundle 'Xuyuanp/nerdtree-git-plugin'
  " NeoBundle 'https://github.com/jaxbot/github-issues.vim'
" " untils
  " NeoBundle 'benekastah/neomake'
  " NeoBundle 'editorconfig/editorconfig-vim'
  " NeoBundle 'scrooloose/nerdtree'
  " NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'tmux-plugins/vim-tmux'
NeoBundle 'tmux-plugins/vim-tmux-focus-events'
  " NeoBundle 'vim-airline/vim-airline'
  " NeoBundle 'tpope/vim-surround'
  " NeoBundle 'tomtom/tcomment_vim'
  " NeoBundle 'mattn/emmet-vim'
  " NeoBundle 'Chiel92/vim-autoformat'
  " NeoBundle 'gorodinskiy/vim-coloresque'
" " Shougo
 NeoBundle 'Shougo/unite.vim'
 NeoBundle 'Shougo/unite-outline'
 NeoBundle 'ujihisa/unite-colorscheme'
  " NeoBundle 'Shougo/vimfiler.vim'
  " NeoBundle 'Shougo/vimproc.vim', {
  "       \ 'build' : {
  "       \     'windows' : 'tools\\update-dll-mingw',
  "       \     'cygwin' : 'make -f make_cygwin.mak',
  "       \     'mac' : 'make -f make_mac.mak',
  "       \     'linux' : 'make',
  "       \     'unix' : 'gmake',
  "       \    },
  "       \ }
  " NeoBundle 'Shougo/deoplete.nvim'
  " NeoBundle 'Shougo/neco-vim'
  " NeoBundle 'Shougo/neoinclude.vim'
  " NeoBundleLazy 'ujihisa/neco-look',{'autoload':{'filetypes':['markdown']}}
  " NeoBundle 'Shougo/neosnippet.vim'
  " NeoBundle 'Shougo/neosnippet-snippets'
  " NeoBundle 'honza/vim-snippets'

  " NeoBundle 'junegunn/fzf', { 'dir': '~/.fzf' }
  " NeoBundle 'junegunn/fzf.vim'
  " NeoBundle 'ashisha/image.vim'
  " NeoBundle 'mhinz/vim-sayonara'
  " NeoBundle 'vim-lua-ftplugin', {'depends': 'xolox/vim-misc'}
  " NeoBundle 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'}
  " NeoBundle 'terryma/vim-multiple-cursors'
  " NeoBundle 'rhysd/github-complete.vim'
  " NeoBundle 'junegunn/goyo.vim'
  " NeoBundle 'junegunn/limelight.vim'
  " NeoBundle 'https://github.com/danielmiessler/VimBlog'
  " NeoBundle 'https://github.com/neovim/node-host'
  " NeoBundle 'vim-scripts/SyntaxRange'
  " NeoBundle 'vim-scripts/ingo-library'
  " NeoBundle 'vim-scripts/CSApprox'
  " " NeoBundle 'vim-scripts/XML-Folding'
  " NeoBundle 'ruanyl/vim-fixmyjs'

  " NeoBundle 'ryanoasis/vim-devicons'
  call neobundle#end()

" Required:
  filetype plugin indent on
  let pluginsExist=1
  NeoBundleCheck
" }}}

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

" " NERDTree ------------------------------------------------------------------{{{
" 
"   map <C-\> :NERDTreeToggle<CR>
"   autocmd StdinReadPre * let s:std_in=1
"   " autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"   let NERDTreeShowHidden=1
"   let g:NERDTreeWinSize=45
"   let g:NERDTreeAutoDeleteBuffer=1
" " NERDTress File highlighting
"   function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
"   exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
"   exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
"   endfunction
" 
"   call NERDTreeHighlightFile('jade', 'green', 'none', 'green', 'none')
"   call NERDTreeHighlightFile('md', 'blue', 'none', '#6699CC', 'none')
"   call NERDTreeHighlightFile('config', 'yellow', 'none', '#d8a235', 'none')
"   call NERDTreeHighlightFile('conf', 'yellow', 'none', '#d8a235', 'none')
"   call NERDTreeHighlightFile('json', 'green', 'none', '#d8a235', 'none')
"   call NERDTreeHighlightFile('html', 'yellow', 'none', '#d8a235', 'none')
"   call NERDTreeHighlightFile('css', 'cyan', 'none', '#5486C0', 'none')
"   call NERDTreeHighlightFile('scss', 'cyan', 'none', '#5486C0', 'none')
"   call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', 'none')
"   call NERDTreeHighlightFile('ts', 'Blue', 'none', '#6699cc', 'none')
"   call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', 'none')
"   call NERDTreeHighlightFile('gitconfig', 'black', 'none', '#686868', 'none')
"   call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#7F7F7F', 'none')
" "}}}
" 
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
" " unite ---------------------------------------------------------------------{{{
" "
"   let g:unite_data_directory='~/.nvim/.cache/unite'
"   let g:unite_source_history_yank_enable=1
"   let g:unite_prompt='» '
"   let g:unite_source_rec_async_command =['ag', '--follow', '--nocolor', '--nogroup','--hidden', '-g', '', '--ignore', '.git', '--ignore', '*.png', '--ignore', 'lib']
" 
"   nnoremap <silent> <c-p> :Unite -auto-resize -start-insert -direction=botright file_rec/neovim2<CR>
"   nnoremap <silent> <leader>c :Unite -auto-resize -start-insert -direction=botright colorscheme<CR>
"   nnoremap <silent> <leader>u :Unite neobundle/update<CR>
" 
" " Custom mappings for the unite buffer
"   autocmd FileType unite call s:unite_settings()
" 
"   function! s:unite_settings() "{{{
"     " Enable navigation with control-j and control-k in insert mode
"     imap <buffer> <C-j>   <Plug>(unite_select_next_line)
"     imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
"   endfunction "}}}
" 
" " Git from unite...ERMERGERD ------------------------------------------------{{{
" let g:unite_source_menu_menus = {} " Useful when building interfaces at appropriate places
" let g:unite_source_menu_menus.git = {
"     \ 'description' : 'Fugitive interface',
"     \}
"   let g:unite_source_menu_menus.git.command_candidates = [
"     \[' git status', 'Gstatus'],
"     \[' git diff', 'Gvdiff'],
"     \[' git commit', 'Gcommit'],
"     \[' git stage/add', 'Gwrite'],
"     \[' git checkout', 'Gread'],
"     \[' git rm', 'Gremove'],
"     \[' git cd', 'Gcd'],
"     \[' git push', 'exe "Git! push " input("remote/branch: ")'],
"     \[' git pull', 'exe "Git! pull " input("remote/branch: ")'],
"     \[' git pull rebase', 'exe "Git! pull --rebase " input("branch: ")'],
"     \[' git checkout branch', 'exe "Git! checkout " input("branch: ")'],
"     \[' git fetch', 'Gfetch'],
"     \[' git merge', 'Gmerge'],
"     \[' git browse', 'Gbrowse'],
"     \[' git head', 'Gedit HEAD^'],
"     \[' git parent', 'edit %:h'],
"     \[' git log commit buffers', 'Glog --'],
"     \[' git log current file', 'Glog -- %'],
"     \[' git log last n commits', 'exe "Glog -" input("num: ")'],
"     \[' git log first n commits', 'exe "Glog --reverse -" input("num: ")'],
"     \[' git log until date', 'exe "Glog --until=" input("day: ")'],
"     \[' git log grep commits',  'exe "Glog --grep= " input("string: ")'],
"     \[' git log pickaxe',  'exe "Glog -S" input("string: ")'],
"     \[' git index', 'exe "Gedit " input("branchname\:filename: ")'],
"     \[' git mv', 'exe "Gmove " input("destination: ")'],
"     \[' git grep',  'exe "Ggrep " input("string: ")'],
"     \[' git prompt', 'exe "Git! " input("command: ")'],
"     \] " Append ' --' after log to get commit info commit buffers
"   nnoremap <silent> <Leader>g :Unite -direction=botright -silent -buffer-name=git -start-insert menu:git<CR>
" "}}}
" " Custom :FZF function
" " Brew install fzf
"   " map <c-p> :FZF<CR>
" "   tmap <c-p> <c-\><c-n>:FZF<CR>
"   map <leader>a :Ag<CR>
" "   tmap <leader>a <c-\><c-n>:Ag<CR>
" "
" "   vmap <leader>aw y:Ag <C-r>0<CR>
" " " nmap <leader>aw :Ag <C-r><C-w>
" "   map <leader>h :History<CR>
" "   tmap <leader>h <c-\><c-n>:History<CR>
" "   map <leader>l :Lines<CR>
" "}}}
" 
" " vim-airline ---------------------------------------------------------------{{{
"   let g:airline#extensions#tabline#enabled = 1
"   set hidden
"   let g:airline#extensions#tabline#fnamemod = ':t'
"   let g:airline#extensions#tabline#show_tab_nr = 1
"   let g:airline_powerline_fonts = 1
"   let g:airline_theme='oceanicnext'
"   cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == 'x' ? 'Sayonara' : 'x'
"   tmap <leader>x <c-\><c-n>:bp! <BAR> bd! #<CR>
"   nmap <leader>t :term<cr>
"   nmap <leader>, :bnext<CR>
"   tmap <leader>, <C-\><C-n>:bnext<cr>
"   nmap <leader>. :bprevious<CR>
"   tmap <leader>. <C-\><C-n>:bprevious<CR>
"   let g:airline#extensions#tabline#buffer_idx_mode = 1
"   tmap <leader>1  <C-\><C-n><Plug>AirlineSelectTab1
"   tmap <leader>2  <C-\><C-n><Plug>AirlineSelectTab2
"   tmap <leader>3  <C-\><C-n><Plug>AirlineSelectTab3
"   tmap <leader>4  <C-\><C-n><Plug>AirlineSelectTab4
"   tmap <leader>5  <C-\><C-n><Plug>AirlineSelectTab5
"   tmap <leader>6  <C-\><C-n><Plug>AirlineSelectTab6
"   tmap <leader>7  <C-\><C-n><Plug>AirlineSelectTab7
"   tmap <leader>8  <C-\><C-n><Plug>AirlineSelectTab8
"   tmap <leader>9  <C-\><C-n><Plug>AirlineSelectTab9
"   nmap <leader>1 <Plug>AirlineSelectTab1
"   nmap <leader>2 <Plug>AirlineSelectTab2
"   nmap <leader>3 <Plug>AirlineSelectTab3
"   nmap <leader>4 <Plug>AirlineSelectTab4
"   nmap <leader>5 <Plug>AirlineSelectTab5
"   nmap <leader>6 <Plug>AirlineSelectTab6
"   nmap <leader>7 <Plug>AirlineSelectTab7
"   nmap <leader>8 <Plug>AirlineSelectTab8
"   nmap <leader>9 <Plug>AirlineSelectTab9
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
let vimsettings = '~/.config/nvim/settings'
for fpath in split(globpath(vimsettings, '*.vim'), '\n')
  exe 'source' fpath
endfor

endif
