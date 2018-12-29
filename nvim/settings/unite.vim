" let g:denite_data_directory='~/.nvim/.cache/denite'
" let g:denite_source_history_yank_enable=1
" let g:denite_prompt='» '

" nnoremap <silent> <c-p> :Denite -auto-resize -start-insert -direction=botright -ignorecase file_rec/neovim<CR>
nnoremap <silent> <c-p> :Denite -no-split -buffer-name=files -ignorecase file/rec<cr>
" -start-insert -force-redraw
nnoremap <silent> <leader>c :Denite -auto-resize -start-insert -direction=botright colorscheme<CR>


	" Change file/rec command.
	call denite#custom#var('file/rec', 'command',
	\ ['ag', '--follow', '--nocolor', '--nogroup','--hidden', '-g', '', '--ignore', '.git', '--ignore', '*.png', '--ignore', 'node_modules', '--ignore', 'yarn.lock'])

	" Change mappings.
	call denite#custom#map(
	      \ 'insert',
	      \ '<C-j>',
	      \ '<denite:move_to_next_line>',
	      \ 'noremap'
	      \)
	call denite#custom#map(
	      \ 'insert',
	      \ '<C-k>',
	      \ '<denite:move_to_previous_line>',
	      \ 'noremap'
	      \)

	" Change matchers.
	call denite#custom#source(
	\ 'file_mru', 'matchers', ['matcher/fuzzy', 'matcher/project_files'])
	" \ 'file_mru', 'matchers', ['matcher/fuzzy', 'matcher/project_files', 'converter_relative_word'])

	" Change sorters.
	call denite#custom#source(
	\ 'file/rec', 'sorters', ['sorter/sublime'])

	" Add custom menus
	" let s:menus = {}
  "
	" let s:menus.zsh = {
	" 	\ 'description': 'Edit your import zsh configuration'
	" 	\ }
	" let s:menus.zsh.file_candidates = [
	" 	\ ['zshrc', '~/.config/zsh/.zshrc'],
	" 	\ ['zshenv', '~/.zshenv'],
	" 	\ ]
  "
	" let s:menus.my_commands = {
	" 	\ 'description': 'Example commands'
	" 	\ }
	" let s:menus.my_commands.command_candidates = [
	" 	\ ['Split the window', 'vnew'],
	" 	\ ['Open zsh menu', 'Denite menu:zsh'],
	" 	\ ]
  "
	" call denite#custom#var('menu', 'menus', s:menus)

	" Ag command on grep source
	call denite#custom#var('grep', 'command', ['ag'])
	call denite#custom#var('grep', 'default_opts',
			\ ['-i', '--vimgrep'])
	call denite#custom#var('grep', 'recursive_opts', [])
	call denite#custom#var('grep', 'pattern_opt', [])
	call denite#custom#var('grep', 'separator', ['--'])
	call denite#custom#var('grep', 'final_opts', [])

	" Change default prompt
	call denite#custom#option('default', 'prompt', '» ')

	" " Change ignore_globs
	" call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
	"       \ [ '.git/', '.ropeproject/', '__pycache__/',
	"       \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])



" TODO NOT WORKING
" " Custom mappings for the denite buffer
" augroup spelling
"   autocmd!
"   autocmd FileType denite call s:denite_settings()
" augroup END
" function! s:denite_settings() "{{{
"   " enable navigation with control-j and control-k in insert mode
"   " not working
" "   imap <buffer> <c-j>   <plug>(denite:move_to_next_line)
" "   imap <buffer> <c-k>   <plug>(denite:move_to_previous_line)
" endfunction "}}}
" call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
" call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')

" Git from denite...ERMERGERD ------------------------------------------------{{{
let g:denite_source_menu_menus = {} " Useful when building interfaces at appropriate places
let g:denite_source_menu_menus.git = {
      \ 'description' : 'Fugitive interface',
      \}
let g:denite_source_menu_menus.git.command_candidates = [
      \[' git status', 'Gstatus'],
      \[' git diff', 'Gvdiff'],
      \[' git commit', 'Gcommit'],
      \[' git stage/add', 'Gwrite'],
      \[' git checkout', 'Gread'],
      \[' git rm', 'Gremove'],
      \[' git cd', 'Gcd'],
      \[' git push', 'exe "Git! push " input("remote/branch: ")'],
      \[' git pull', 'exe "Git! pull " input("remote/branch: ")'],
      \[' git pull rebase', 'exe "Git! pull --rebase " input("branch: ")'],
      \[' git checkout branch', 'exe "Git! checkout " input("branch: ")'],
      \[' git fetch', 'Gfetch'],
      \[' git merge', 'Gmerge'],
      \[' git browse', 'Gbrowse'],
      \[' git head', 'Gedit HEAD^'],
      \[' git parent', 'edit %:h'],
      \[' git log commit buffers', 'Glog --'],
      \[' git log current file', 'Glog -- %'],
      \[' git log last n commits', 'exe "Glog -" input("num: ")'],
      \[' git log first n commits', 'exe "Glog --reverse -" input("num: ")'],
      \[' git log until date', 'exe "Glog --until=" input("day: ")'],
      \[' git log grep commits',  'exe "Glog --grep= " input("string: ")'],
      \[' git log pickaxe',  'exe "Glog -S" input("string: ")'],
      \[' git index', 'exe "Gedit " input("branchname\:filename: ")'],
      \[' git mv', 'exe "Gmove " input("destination: ")'],
      \[' git grep',  'exe "Ggrep " input("string: ")'],
      \[' git prompt', 'exe "Git! " input("command: ")'],
      \] " Append ' --' after log to get commit info commit buffers
nnoremap <silent> <Leader>g :Denite -direction=botright -silent -buffer-name=git -start-insert menu:git<CR>
"}}}
map <leader>a :Ag<CR>
