" based on  : https://github.com/mhartington/dotfiles/

let vimsettings = '~/.config/nvim/settings'

exe 'source' vimsettings . '/plugins.vim'
exe 'source' vimsettings . '/system.vim'

if pluginsExist
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

" Settings
" Based on https://github.com/skwp/dotfiles/blob/master/vim/settings.vim
for fpath in split(globpath(vimsettings, '*.vim'), '\n')
  if (fpath == expand(vimsettings) . "/plugins.vim")
    continue " do not source twice
  endif

  exe 'source' fpath
endfor

endif
