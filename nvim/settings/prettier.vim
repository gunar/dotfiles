" Disable auto formatting of files that have "@format" tag 
let g:prettier#autoformat = 0

" Use async 
let g:prettier#exec_cmd_async = 1

" By default parsing errors will open the quickfix but can also be disabled
let g:prettier#quickfix_enabled  = 1

" By default we auto focus on the quickfix when there are errors but can also be disabled
let g:prettier#quickfix_auto_focus = 0
