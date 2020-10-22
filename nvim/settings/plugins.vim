" If Dein is not installed, install it first
let bundleExists = 1
let pluginsExist = 1
if (!isdirectory(expand("$HOME/.cache/dein")))
  call system(expand("curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/installer.sh"))
  call system(expand("sh /tmp/installer.sh $HOME/.cache/dein"))
  let bundleExists = 0
endif
if 0 | endif

if &compatible
  set nocompatible " Be iMproved
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  " Autocompletion {{{
    call dein#add('ncm2/float-preview.nvim')
  " }}}


  " Denite: Generic Fuzzy Finder
  call dein#add('Shougo/denite.nvim')

  " TypeScript --- {{{
  call dein#add('HerringtonDarkholme/yats.vim') " REQUIRED: Add a syntax file. YATS is the best
  call dein#add('mhartington/nvim-typescript', {'build': './install.sh'})
  " Deoplete for async completion
  " Denite for generic fuzzy finder

  " --- }}}
  " Machine Learning auto-complete https://tabnine.com
  "     I'm concerned this might conflict with other autocompletes I have
  call dein#add('tbodt/deoplete-tabnine', {'build': './install.sh'})

  " Clojure {{{
  "  Syntax Indent Completion
  " call dein#add('guns/vim-clojure-static')
  call dein#add('kien/rainbow_parentheses.vim')
  " call dein#add('tpope/vim-fireplace')
  call dein#add('Olical/conjure', {'tag': 'v3.4.0'})
  call dein#add('jiangmiao/auto-pairs', { 'tag': 'v2.0.0' })
  call dein#add('w0rp/ale')
  " TODO:
  "   - https://oli.me.uk/getting-started-with-clojure-neovim-and-conjure-in-minutes/
  "   - https://github.com/guns/vim-sexp
  "   - https://github.com/tpope/vim-sexp-mappings-for-regular-people
  "  }}}

  " moving around --- {{{
  call dein#add('easymotion/vim-easymotion')
  " }}}

  " javascript --- {{{
  " testing
  call dein#add('janko-m/vim-test')
  call dein#add('juanpabloaj/vim-istanbul')

  " syntax
  " call dein#add('jelera/vim-javascript-syntax' " deprecated by yajs)
  call dein#add('pangloss/vim-javascript')
  call dein#add('mxw/vim-jsx')
  call dein#add('alunny/pegjs-vim')
  " call dein#add('ternjs/tern_for_vim')
  " call dein#add('carlitux/deoplete-ternjs', { 'build': { 'unix': 'yarn global add tern' }})

  call dein#add('othree/yajs.vim')
  call dein#add('othree/es.next.syntax.vim')

  call dein#add('1995eaton/vim-better-javascript-completion')
  call dein#add('moll/vim-node') " makes `gf` work on node_modules

  " call dein#add('hail2u/vim-css3-syntax')
  " " call dein#add('vim-scripts/SyntaxComplete')
  " call dein#add('othree/javascript-libraries-syntax.vim')
  " NeoBundleLazy 'elzr/vim-json', {'autoload':{'filetypes':['json']}}
  " --- }}}

  " markdown {{{
  call dein#add('junegunn/goyo.vim') " :Goyo for distraction free writing
  call dein#add('godlygeek/tabular')
  call dein#add('plasticboy/vim-markdown')
  call dein#add('nelstrom/vim-markdown-folding') "Use :FoldToggle for nested folding
  " }}}


  " postgres {{{
  call dein#add('vim-scripts/dbext.vim')
  " }}}
  call dein#add('prettier/vim-prettier', { 'build': 'yarn install' })

  " colorscheme & syntax highlighting
  " Theme
  call dein#add('mhartington/oceanic-next')
  " call dein#add('Yggdroot/indentLine')
  " call dein#add('myhere/vim-nodejs-complete')
  " call dein#add('Raimondi/delimitMate')
  " call dein#add('valloric/MatchTagAlways')

  "  Git helpers
  call dein#add('tpope/vim-fugitive')
  " call dein#add('jreybert/vimagit')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('Xuyuanp/nerdtree-git-plugin')
  " call dein#add('https://github.com/jaxbot/github-issues.vim')

  " Linting --- {{{
  call dein#add('neomake/neomake')
  " --- }}}

  " utils
  call dein#add('907th/vim-auto-save')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('scrooloose/nerdtree')
  " call dein#add('AndrewRadev/switch.vim')
  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('tmux-plugins/vim-tmux')
  call dein#add('tmux-plugins/vim-tmux-focus-events')
  call dein#add('vim-airline/vim-airline')
  call dein#add('tpope/vim-surround')
  call dein#add('tomtom/tcomment_vim')
  " call dein#add('mattn/emmet-vim')
  " call dein#add('Chiel92/vim-autoformat')
  " call dein#add('gorodinskiy/vim-coloresque')
  " " Shougo
  " call dein#add('Shougo/unite-outline')
  " call dein#add('ujihisa/unite-colorscheme')
  call dein#add('Shougo/defx.nvim')
  " call dein#add('Shougo/vimfiler.vim')
  " call dein#add('Shougo/vimproc.vim', {)
  "       \ 'build' : {
  "       \     'windows' : 'tools\\update-dll-mingw',
  "       \     'cygwin' : 'make -f make_cygwin.mak',
  "       \     'mac' : 'make -f make_mac.mak',
  "       \     'linux' : 'make',
  "       \     'unix' : 'gmake',
  "       \    },
  "       \ }
  " call dein#add('Shougo/neco-vim')
  " call dein#add('Shougo/neoinclude.vim')
  " NeoBundleLazy 'ujihisa/neco-look',{'autoload':{'filetypes':['markdown']}}
  call dein#add('Shougo/neosnippet.vim')
  " Not using the default snippets
  call dein#add('Shougo/neosnippet-snippets')

  call dein#add('junegunn/fzf', { 'dir': '~/.fzf', 'hook_post_update': 'call fzf#install()' })
  call dein#add('junegunn/fzf.vim')
  " call dein#add('ashisha/image.vim')
  " call dein#add('mhinz/vim-sayonara')
  " call dein#add('vim-lua-ftplugin', {'depends': 'xolox/vim-misc'})
  " call dein#add('mattn/gist-vim', {'depends': 'mattn/webapi-vim'})
  " call dein#add('rhysd/github-complete.vim')
  " call dein#add('junegunn/limelight.vim')
  " call dein#add('https://github.com/danielmiessler/VimBlog')
  " call dein#add('vim-scripts/SyntaxRange')
  " call dein#add('vim-scripts/ingo-library')
  " " call dein#add('vim-scripts/XML-Folding')
  " call dein#add('ruanyl/vim-fixmyjs')

  " call dein#add('ryanoasis/vim-devicons')

  call dein#add('qpkorr/vim-bufkill')


  call dein#add('terryma/vim-expand-region') " Adds + and _ to expand and reduce region
  call dein#add('vim-scripts/argtextobj.vim') " Adds 'a' motion for function arguments

  call dein#end()
  call dein#save_state()
endif

" TODO this doesn't seem to be working
if bundleExists == 0
  call dein#install()
endif

filetype plugin indent on
syntax enable

