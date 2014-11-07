function! FamousGF()
  let ext = expand('%:e')
  lcd %:p:h
  try
    normal yi'
  catch
    normal yi'
  finally
    echo "no file." . ext . " found in " . expand('%:p:h')
  endtry
  let file=@" . "." . ext
  if filereadable(file)
    exe 'edit ' . file
  else
    echo file . " not found"
  endif
endfunc
nnoremap <leader>gf :call FamousGF()<CR>

au BufRead,BufNewFile *.coffee nnoremap <buffer> gf :silent call FamousGF()<CR>


" 'views/AppView'
