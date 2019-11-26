scriptencoding utf-8

command! -nargs=0 BO silent! execute "%bd|e#|bd#"
command! Bd setlocal bufhidden=delete | bnext
command! -nargs=0 WS %s/\s\+$// | normal! ``
command! -nargs=0 HL call functions#hl()
command! -range GB echo join(systemlist("git blame -L <line1>,<line2> " . expand('%')), "\n")
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 OrganiseImports :CocCommand tsserver.organizeImports
command! -nargs=0 FixAllImports :CocCommand tsserver.executeAutoFix
command! -nargs=0 NixFormat silent! execute '!nixfmt %'
