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

NeoBundle 'Shougo/deoplete.nvim'

" Clojure
"  Syntax Indent Completion
NeoBundle 'guns/vim-clojure-static'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle 'tpope/vim-fireplace'

" javascript --- {{{
" testing
NeoBundle 'janko-m/vim-test'
NeoBundle 'juanpabloaj/vim-istanbul'

" syntax
" NeoBundle 'jelera/vim-javascript-syntax' " deprecated by yajs
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'alunny/pegjs-vim'
NeoBundle 'ternjs/tern_for_vim'
NeoBundle 'carlitux/deoplete-ternjs', { 'build': { 'unix': 'yarn global add tern' }}

NeoBundle 'othree/yajs.vim'
NeoBundle 'othree/es.next.syntax.vim'

NeoBundle '1995eaton/vim-better-javascript-completion'
NeoBundle 'moll/vim-node' " makes `gf` work on node_modules

" interactive scratchpad instant evaluation
NeoBundle 'metakirby5/codi.vim'

" NeoBundle 'hail2u/vim-css3-syntax'
" " NeoBundle 'vim-scripts/SyntaxComplete'
" NeoBundle 'othree/javascript-libraries-syntax.vim'
" NeoBundleLazy 'elzr/vim-json', {'autoload':{'filetypes':['json']}}
" --- }}}

" markdown {{{
NeoBundle 'junegunn/goyo.vim' " :Goyo for distraction free writing
NeoBundle 'godlygeek/tabular'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'nelstrom/vim-markdown-folding' "Use :FoldToggle for nested folding
" }}}

" colorscheme & syntax highlighting
" Theme
NeoBundle 'mhartington/oceanic-next'
" NeoBundle 'Yggdroot/indentLine'
" NeoBundle 'myhere/vim-nodejs-complete'
" NeoBundle 'Raimondi/delimitMate'
" NeoBundle 'valloric/MatchTagAlways'

"  Git helpers
NeoBundle 'tpope/vim-fugitive'
" NeoBundle 'jreybert/vimagit'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'Xuyuanp/nerdtree-git-plugin'
" NeoBundle 'https://github.com/jaxbot/github-issues.vim'

" Linting --- {{{
NeoBundle 'neomake/neomake'
" --- }}}

" utils
NeoBundle '907th/vim-auto-save'
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'scrooloose/nerdtree'
" NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'tmux-plugins/vim-tmux'
NeoBundle 'tmux-plugins/vim-tmux-focus-events'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tomtom/tcomment_vim'
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
" NeoBundle 'Shougo/neco-vim'
" NeoBundle 'Shougo/neoinclude.vim'
" NeoBundleLazy 'ujihisa/neco-look',{'autoload':{'filetypes':['markdown']}}
NeoBundle 'Shougo/neosnippet.vim'
" Not using the default snippets
NeoBundle 'Shougo/neosnippet-snippets'

NeoBundle 'junegunn/fzf', { 'dir': '~/.fzf' }
NeoBundle 'junegunn/fzf.vim'
" NeoBundle 'ashisha/image.vim'
" NeoBundle 'mhinz/vim-sayonara'
" NeoBundle 'vim-lua-ftplugin', {'depends': 'xolox/vim-misc'}
" NeoBundle 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'}
" NeoBundle 'rhysd/github-complete.vim'
" NeoBundle 'junegunn/limelight.vim'
" NeoBundle 'https://github.com/danielmiessler/VimBlog'
NeoBundle 'https://github.com/neovim/node-host'
" NeoBundle 'vim-scripts/SyntaxRange'
" NeoBundle 'vim-scripts/ingo-library'
" " NeoBundle 'vim-scripts/XML-Folding'
" NeoBundle 'ruanyl/vim-fixmyjs'

" NeoBundle 'ryanoasis/vim-devicons'

NeoBundle 'qpkorr/vim-bufkill'


NeoBundle 'terryma/vim-expand-region' " Adds + and _ to expand and reduce region
NeoBundle 'vim-scripts/argtextobj.vim' " Adds 'a' motion for function arguments

call neobundle#end()

" Required:
filetype plugin indent on
let pluginsExist=1
NeoBundleCheck
