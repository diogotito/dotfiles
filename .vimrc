" I trust the Vim 8.0 defaults
source /usr/share/vim/vim80/defaults.vim


" User interface
" color solarized
color pablo
set background=light
set background=dark
if has("gui_running")
    set lines=35 columns=150
	color desert
    set guioptions-=T  " remove the toolbar, but keep the menubar
end
set title         " Always set the terminal title to 'titlestring'
" Change cursor shape in different modes
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" Miscellaneous
" set clipboard^=unnamed
" path+=**
 
" Indentation
set autoindent
set smarttab
set tabstop=4     " 1 tab -> 4 \" spaces\" 
set shiftwidth=4  " >> and <<
set softtabstop=4
set shiftround    " multiples of 4
set expandtab     " I generally prefer spaces over tabs

    " Searching
set hlsearch
set ignorecase
set smartcase     " Overrides ignorecase if search pattern has uppercase chars.


" Mappings
nnoremap <F9> :noh<CR>
inoremap jk <esc>

" Refinements {{{
" set ttyfast
" set lazyredraw
" }}}


" vim: foldmethod=marker


