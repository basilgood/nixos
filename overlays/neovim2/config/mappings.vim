scriptencoding utf-8

"""" mappings
nnoremap j gj
nnoremap k gk
nnoremap > >>
nnoremap < <<
vnoremap > >gv
vnoremap < <gv
nnoremap <C-s> :<c-u>update<cr>
inoremap <C-s> <esc>:update<cr>
xnoremap <C-s> <esc>:<C-u>update<cr>
nnoremap <expr> 0 virtcol('.') - 1 <= indent('.') && col('.') > 1 ? '0' : '_'
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-Del> <C-o>dw
nnoremap } }zz
nnoremap { {zz

" Smart <C-f>, <C-b>.
noremap <expr> <C-f> max([winheight(0) - 2, 1])
      \ . "\<C-d>" . (line('w$') >= line('$') ? "L" : "M")
noremap <expr> <C-b> max([winheight(0) - 2, 1])
      \ . "\<C-u>" . (line('w0') <= 1 ? "H" : "M")

"""" windows
nnoremap <silent> <space>v  :<c-u>vsplit<cr>
nnoremap <silent> <space>s  :<c-u>split<cr>
nnoremap <silent> <space>o  :<c-u>only<cr>
nnoremap <silent> <space>q  :<c-u>close<cr>
nnoremap <silent> <Tab> :wincmd w<CR>
nnoremap <silent> <S-Tab> :wincmd W<CR>

"""" prev and next buffer
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

"""" lists
nnoremap ]l :lnext<cr>
nnoremap [l :lprevious<cr>
nnoremap ]q :cnext<cr>
nnoremap [q :cprevious<cr>
nnoremap ]Q :clast<cr>
nnoremap [Q :cfirst<cr>

"""" niceblock
xnoremap <expr> I (mode()=~#'[vV]'?'<C-v>^o^I':'I')
xnoremap <expr> A (mode()=~#'[vV]'?'<C-v>0o$A':'A')

"""" innerline
xnoremap <silent> il <Esc>^vg_
onoremap <silent> il :<C-U>normal! ^vg_<cr>

"""" entire
xnoremap <silent> ie gg0oG$
onoremap <silent> ie :<C-U>execute "normal! m`"<Bar>keepjumps normal! ggVG<cr>

"""" disable EX-mode
nnoremap Q <Nop>

"""" execute macro
nnoremap Q @q
"""" Run macro on selected lines
vnoremap Q :norm Q<cr>

"""" yank to clipboard
vnoremap <space>y "+y

"""" yank and keep cursor position
vnoremap <expr>y "my\"" . v:register . "y`y"

"""" paste from clipboard
nnoremap <space>p :put+<cr>
vnoremap <space>p "+p
nnoremap <space>P :put!+<cr>
vnoremap <space>P "+P

"""" Paste continuously.
nnoremap [p "0p
nnoremap ]p viw"0p
vnoremap P "0p

"""" replace a word with clipboard
nnoremap <space>w viw"+p

"""" switch buffers
nnoremap <space>1 1<c-w>w
nnoremap <space>2 2<c-w>w
nnoremap <space>3 3<c-w>w
nnoremap <space>4 4<c-w>w
nnoremap <space>5 5<c-w>w
nnoremap <space>6 6<c-w>w
nnoremap <space>7 7<c-w>w
nnoremap <space>8 8<c-w>w
nnoremap <space>9 9<c-w>w

"""" substitute.
nnoremap [subst]   <Nop>
nmap   s [subst]
xmap   s [subst]
nnoremap [subst]s :%s/
nnoremap [subst]l :s/
xnoremap [subst]  :s/
nnoremap [subst]a :<c-u>%s/\C\<<c-r><c-w>\>/<c-r><c-w>
nnoremap [subst]p vip :<c-u>s/
nnoremap [subst]w :<C-u>%s/\C\<<C-R><C-w>\>//g<Left><Left>

"""" zoom
nnoremap <C-w>t :tabedit %<cr>
nnoremap <C-w>z :tabclose<cr>

"""" git commands
nnoremap <silent> <expr> <space>dt ":\<C-u>"."windo ".(&diff?"diffoff":"diffthis")."\<CR>"

"""" hlsearch hlnext
nnoremap <silent> <space>n :nohlsearch<CR>

" CTRL-L to fix syntax highlight
nnoremap <silent><expr> <C-l> empty(get(b:, 'current_syntax'))
      \ ? "\<C-l>"
      \ : "\<C-l>:syntax sync fromstart\<CR>"
