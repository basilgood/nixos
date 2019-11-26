set encoding=utf-8
scriptencoding utf-8

augroup vimRc
  autocmd!
augroup END

if has('vim_starting')
  let g:startuptime = reltime()
  autocmd vimRc VimEnter * let g:startuptime = reltime(g:startuptime) | redraw
        \ | echomsg 'startuptime: ' . reltimestr(g:startuptime)
endif

let g:loaded_matchparen         = 1
let g:loaded_rrhelper           = 1
let g:did_install_default_menus = 1
let g:is_bash                   = 1
let g:sh_noisk                  = 1
let g:loaded_vimball            = 1
let g:loaded_vimballPlugin      = 1
let g:loaded_getscript          = 1
let g:loaded_getscriptPlugin    = 1
let g:loaded_logipat            = 1
let g:loaded_man                = 1

"""" after vim start
if has('vim_starting') && has('timers')
  autocmd vimRc VimEnter * call timer_start(1, 'functions#packaddhandler', {'repeat': 0})
endif

colorscheme nordish
hi! Comment      guifg=#5c6370 guibg=NONE gui=italic cterm=italic
hi! ParenMatch   guifg=#85EB6A guibg=#135B00 gui=NONE cterm=NONE term=reverse ctermbg=11
set secure
