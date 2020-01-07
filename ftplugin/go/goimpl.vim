function! s:goimpl(...)
  noau update
  let l:dir = expand('%:p:h')
  if !empty(a:000)
    let l:word = a:000[0]
  else
    let l:word = expand('<cword>')
    if l:word ==# 'type'
      normal! w
      let l:word = expand('<cword>')
    elseif l:word ==# 'struct' || l:word ==# 'interface'
      normal! B
      let l:word = expand('<cword>')
    endif
    silent let l:package = system(printf('cd %s && go list', shellescape(l:dir)))
    if !empty(l:package)
      let l:word = substitute(l:package, '[ \t\r\n]', '', 'g') . '.' . l:word
    endif
  endif
  if empty(l:word)
    return
  endif
  let l:recv = split(l:word, '\.')[-1]
  let l:strct = l:recv
  if empty(a:000) && getline('.') =~# ' interface {'
    let l:strct .= 'Impl'
  elseif len(a:000) ==# 2
    let l:strct = a:000[1]
  endif
  let l:impl = printf('%s *%s', tolower(l:strct[0]), l:strct)
  let l:cmd = printf('impl -dir %s %s %s', shellescape(l:dir), shellescape(l:impl), l:word)
  let l:out = system(l:cmd)
  let l:lines = split(l:out, '\n')
  if v:shell_error != 0
    echomsg join(l:lines, "\n")
    return
  endif
  if l:recv !=# l:strct
    let l:lines = ['type ' . l:strct . ' struct {', '}', ''] + l:lines
  endif
  call append('$', ['']+l:lines)
endfunction

command! -nargs=* -buffer GoImpl call s:goimpl(<f-args>)
