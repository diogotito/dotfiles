" I trust the Vim 8.0 defaults
source /usr/share/vim/vim80/defaults.vim

" User interface
color solarized
set background=dark
if has("gui_running")
	color solarized
        set guioptions-=T  " remove the toolbar, but keep the menubar
end
set title         " Always set the terminal title to 'titlestring'

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

