" CtrlP.vim
let g:ctrlp_match_window = 'top,order:btt,min:1,max:20,results:20'
let g:ctrlp_match_window_bottom = 0 " Show at top of window
let g:ctrlp_jump_to_buffer = 'Et' " Jump to tab AND buffer if already open
let g:ctrlp_split_window = 0 " <CR> = New Tab
let g:ctrlp_open_new_file = 'r' " Open newly created files in a new tab
let g:ctrlp_open_multiple_files = '2vjr' " Open max 2 files in vsplit, rest in hidden buffers
let g:ctrlp_default_input = 0 "input seeded with current file's directory
let g:ctrlp_show_hidden = 1
let g:ctrlp_mruf_relative = 1 " MRU includes current directory
let g:ctrlp_mruf_default_order = 1 " MRU disable sorting
let g:ctrlp_root_markers = ['Gruntfile.js', 'gulpfile.js']
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/tags/*,*/.DS_Store/*
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.?(git|hg|svn|node_modules|bower_components|lib)$',
    \ 'file': '\v\.?(exe|so|dll|tags)$',
    \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
    \}
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files . -co --exclude-standard']
    \ },
  \ 'fallback': 'ack -g %s',
  \ 'ignore': 1
  \ }
let g:ctrlp_max_depth = 20
let g:ctrlp_max_files = 5000
let g:ctrlp_abbrev = {
\ 'gmode': 'i',
\ 'abbrevs': [
  \ {
    \ 'pattern': '^cd b',
    \ 'expanded': '@cd ~/.vim/bundle',
    \ 'mode': 'pfrz',
  \ },
  \ {
    \ 'pattern': '\(^@.\+\|\\\@<!:.\+\)\@<! ',
    \ 'expanded': '.\{-}',
    \ 'mode': 'pfr',
  \ },
  \ {
    \ 'pattern': '\\\@<!:.\+\zs\\\@<! ',
    \ 'expanded': '\ ',
    \ 'mode': 'pfz',
  \ },
  \ {
    \ 'pattern': '^vim',
    \ 'expanded': '@cd ~/.vim',
    \ 'mode': 'pfrz',
  \ },
  \ {
    \ 'pattern': '^sb',
    \ 'expanded': '@cd ~/Sites/sandbox',
    \ 'mode': 'pfrz',
  \ },
  \ {
    \ 'pattern': '^repos',
    \ 'expanded': '@cd ~/Sites/repos',
    \ 'mode': 'pfrz',
  \ },
  \ {
    \ 'pattern': '^storm',
    \ 'expanded': '@cd ~/Sites/sf-eagle/www/storm',
    \ 'mode': 'pfrz',
  \ },
  \ ]
\ }
let g:ctrlp_prompt_mappings = {
\ 'ToggleFocus()':        ['<c-w>'],
\ 'AcceptSelection("v")': ['<c-v>'],
\ }
" <c-t> opens html file in browser
function! HTMLOpenFunc(action, line)
  if a:action =~ '^[tx]$' && fnamemodify(a:line, ':e') =~? '^html\?$'
    " Get the filename
    let filename = fnameescape(fnamemodify(a:line, ':p'))
    " Close CtrlP
    call ctrlp#exit()
    " Open the file
    silent! execute '!open' filename
  elseif a:action == 'x' && fnamemodify(a:line, ':e') !~? '^html\?$'
    " Not a HTML file, simulate pressing <c-o> again and wait for new input
    call feedkeys("\<c-o>")
  else
    " Use CtrlP's default file opening function
    call call('ctrlp#acceptfile', [a:action, a:line])
  endif
endfunction
let g:ctrlp_open_func = { 'files': 'HTMLOpenFunc' }

