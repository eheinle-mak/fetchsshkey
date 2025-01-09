function! FetchSSHKey(string)
  let url = "https://keys.makandra.de/ssh/" . a:string . ".pub"
  let content = system('curl -s ' . shellescape(url))
  if v:shell_error
    echoerr "Fehler beim Abrufen des Inhalts von " . url
    return
  endif
  let parts = split(content)
  if len(parts) >= 2
    let key = parts[1]
    if key =~? '^\s*HTML\s*$'
        echoerr "Fehler: Username '" . a:string . "' ist vermutlich nicht korrekt."
        return
    endif
    execute "normal! a" . key
  else
    echoerr "Ungültiges Format"
  endif
endfunction

command! -nargs=1 FetchSSHKey call FetchSSHKey(<f-args>)
