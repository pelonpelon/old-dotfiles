" VARIABLES
let g:metadir = "~/.metafiles/"

exe 'au BufRead ' . metadir . ' set ft=meta'
au Filetype meta setlocal wrap linebreak

com! -nargs=? ToggleMeta call MetafileManager(<f-args>)
function! MetafileManager(...)
  "echo "CALLED: MetafileManager()"
  if !exists('a:1')
    "echo "MetafileManager called without argument: " . a:1
    return
  endif

  let metadir = g:metadir

  "set thisfile
  if exists(expand('<afile>'))
    let thisfile = shellescape(expand('<afile>'))
  else
    let thisfile = expand('%')
  endif
  " echo "thisfile: " . thisfile

  if a:1 == "toggle"
    "echo "TOGGLE: "
    if exists('b:parent')
      silent w!
      noautocmd silent bdelete
      return
    else
      if bufwinnr(expand(b:metafile)) != -1
        exe 'noautocmd buffer ' . b:metafile
        silent w!
        noautocmd bdelete
        return
      else
        noautocmd silent exe '40 vsplit ' . b:metafile
        setlocal ft=meta
        let b:parent = expand(thisfile)
        nmap <buffer> <F11> :ToggleMeta toggle<CR>
        w!
        return
      endif
    endif
  endif

  "get inode
  try
    let inode = system("stat -f " . shellescape('%i') . ' ' . thisfile )
    let inode = strpart(inode,-1,len(inode))
  catch /.*/
    "echo "couldn't get inode of " . thisfile
  endtry
  "set metafile
  let metafile = metadir . inode
  " echo "metfile: " . metafile

  if a:1 == "open"
    " echo "OPEN: "
    "Is there a metafile already open ?
    if bufwinnr(expand(metafile)) != -1
      " echo metafile . " already opened"
      return
    endif

    "we called from a metafile
    if getftype(expand(thisfile)) == 'meta'
      "echo "F11: refusing to open metafile of a metafile. thisfile: " . thisfile . "  metafile: " . metafile
      return
    endif


    "does thisfile already have a metafile ?
    if filereadable(expand(metafile))
      "if so, let's open it
      " echo metafile . " readable"
      let b:metafile = metafile
      nmap <buffer> <F11> :ToggleMeta toggle<CR>
      exe 'au QuitPre <buffer> silent buffer ' . b:metafile . ' | bdelete'
      exe 'au BufDelete <buffer> silent buffer ' . b:metafile . ' | bdelete'
      noautocmd silent exe '40 vsplit ' . metafile
      setlocal ft=meta autowriteall backupcopy=yes
      let b:parent = thisfile
      nmap <buffer> <F11> :ToggleMeta toggle<CR>
      return
    else
    "if not, map key for instant creation
    " echo metafile . " :: NOT readable"
      let b:metafile = metafile
      nmap <buffer> <F11> :ToggleMeta create<CR>
      return
    endif
  endif

  if a:1 == "create"
    "echo "CREATE: "
    "if metafile doesn't exist, create one
    if !filereadable(expand(metafile))
      let b:metafile = metafile
      nmap <buffer> <F11> :ToggleMeta toggle<CR>
      exe 'au QuitPre <buffer> silent buffer ' . b:metafile . ' | bdelete'
      exe 'au BufDelete <buffer> silent buffer ' . b:metafile . ' | bdelete'
      noautocmd silent exe '40 vsplit ' . metafile
      setlocal ft=meta autowriteall backupcopy=yes
      let b:parent = thisfile
      nmap <buffer> <F11> :ToggleMeta toggle<CR>
      exe 'normal i' . thisfile . ''
      w!
      return
    endif
  endif


  if a:1 == "update"
    "echon "UPDATE: "
    "if metafile doesn't exist, map f11 to open one
    if !filereadable(expand(metafile))
      let b:metafile = metafile
      nmap <buffer> <F11> :ToggleMeta create<CR>
      return
    else
    "open existing metafile
      let b:metafile = metafile
      nmap <buffer> <F11> :ToggleMeta toggle<CR>
      noautocmd silent exe '40 vsplit ' . metafile
      "echo "openD: " . metafile
      let b:parent = thisfile
      setlocal wrap
      nmap <buffer> <F11> :ToggleMeta toggle<CR>
      w!
      return
    endif
  endif

endfunction

au BufReadPost * call MetafileManager("open")
"au BufEnter * call MetafileManager("open")
"au WinEnter * call MetafileManager("update")
"au BufHidden * call MetafileManager("close")
" au BufDelete,BufUnload * call MetafileManager("detroy")
" au BufEnter * call s:MetaFileManager()
