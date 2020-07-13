runtime  defaults.vim
runtime! archlinux.vim

augroup i3config
    autocmd!
    autocmd BufReadPre   $HOME/.config/{i3,sway}/config set modelineexpr
    autocmd BufWritePost $HOME/.config/{i3,sway}/config silent !i3-msg reload
    autocmd BufWritePost $HOME/.config/{i3,sway}/config redraw!
augroup END


filetype plugin indent on



" Plugin specific
" execute pathogen#infect()

nnoremap <C-n> :NERDTreeToggle<CR>

let g:rustfmt_autosave = 1
let g:rust_clip_command = 'xclip -selection clipboard'

let g:ale_fixers = {
\   'sh': [ 'shfmt' ],
\}

" User interface
color dracula
set laststatus=2
let g:airline_theme = 'cool'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1



" color solarized
set background=light
set background=dark
if has("gui_running")
    set lines=35 columns=150
	color dracula
    let g:airline_theme = 'cool'
    set guioptions-=T  " toolbar
    set guioptions-=m  " menubar
    set guifont=Source\ Code\ Pro\ 12,Fixed\ 12
end

set title         " Always set the terminal title to 'titlestring'

set number
set cursorline

" Change cursor shape in different modes
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" Miscellaneous
set clipboard^=unnamed
set path+=.,**
set viminfo+=%
set splitright
 
" Indentation
set autoindent
set smarttab
set tabstop=4     " 1 tab -> 4 \" spaces\" 
set shiftwidth=4  " >> and <<
set softtabstop=4
set shiftround    " multiples of 4
set expandtab     " I generally prefer spaces over tabs

    " Searching
" set hlsearch
set ignorecase
set smartcase     " Overrides ignorecase if search pattern has uppercase chars.

" other features
set dictionary=/usr/share/dict/british,/usr/share/dict/portuguese
set spelllang=en,pt

" Mappings
nnoremap gb :ls<CR>:b<space>
nnoremap <Tab> <C-6>
inoremap jk <esc>
inoremap kj <esc>

nnoremap <esc>t :vertical rightbelow terminal<CR>

" Refinements {{{
" set ttyfast
" set lazyredraw
" }}}

" vim: foldmethod=marker


