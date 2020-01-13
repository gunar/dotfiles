au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md  set ft=markdown

let g:neomake_markdown_vale_maker = {
\   'exe': 'vale',
\   'args': ['--output', 'line'],
\   'errorformat': '%f:%l:%c:%s:%m'
\ }

function! ProcessSove(context) abort
  let entries = []
  for file in a:context['json']
    for data in file.messages
      let entry = {
            \ 'maker_name': 'sove',
            \ 'filename': file.path,
            \ 'text': data.reason,
            \ 'lnum': data.line,
            \ 'col': data.column,
            \ 'type': data.fatal ? 'E' : 'W'
            \ }
      call add(entries, entry)
    endfor
  endfor
  return entries
endfunction

let g:neomake_markdown_sove_maker = {
\   'exe': 'remark',
\   'args': ['--no-stdout', '--report', 'json', '--frail', '-u', 'validate-links', '-u', 'external-links', '-u', 'preset-lint-recommended'],
\   'process_json': function('ProcessSove'),
\   'output_stream': 'stderr'
\ }


let g:neomake_markdown_enabled_makers = ['sove']

augroup neomake_md
  autocmd FileType markdown setlocal conceallevel=2
  autocmd FileType markdown :Neomake
  call neomake#configure#automake('w')
augroup END

" " turn on spelling for markdown files
" augroup spelling
"   autocmd!
"   autocmd BufRead,BufNewFile *.md setlocal spell complete+=kspell
" augroup END
"
