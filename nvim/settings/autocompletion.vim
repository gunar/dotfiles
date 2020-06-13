" tabnine
" https://github.com/tbodt/deoplete-tabnine/issues/5
call deoplete#custom#source('tabnine', 'rank', 50)

call deoplete#custom#option('keyword_patterns', {'clojure': '[\w!$%&*+/:<=>?@\^_~\-\.#]*'})
set completeopt-=preview

let g:float_preview#docked = 0
let g:float_preview#max_width = 80
let g:float_preview#max_height = 40
