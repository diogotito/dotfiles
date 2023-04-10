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

let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 1
let g:startify_change_cmd = 'cd'
let g:startify_custom_header = ''
let g:startify_custom_footer = 'startify#pad(systemlist("todo.sh -p ls")->map({_, v -> v->trim()}))'

let g:zim_notebook="$HOME\\Todo_txt\\zimwiki"
let g:zim_notebooks_dir="$HOME\\Todo_txt\\zimwiki"

let g:rustfmt_autosave = 1
let g:rust_clip_command = 'xclip -selection clipboard'

let g:instant_markdown_autostart = 0

let g:ale_fixers = {
\   'sh': [ 'shellcheck' ],
\   'javascript': [ 'eslint' ],
\}
nmap <silent> [r <Plug>(ale_previous_wrap)
nmap <silent> ]r <Plug>(ale_next_wrap)
let g:ale_completion_enable = 1  " Desativar quando quiser experimentar o Deoplete
let g:ale_completion_autoimport = 1
set omnifunc=ale#completion#OmniFunc


" User interface
set laststatus=2
" let g:airline_theme = 'solarized'
" let g:airline_theme = 'cool'
" let g:airline_theme = 'base16-dracula'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


" Vimtex
let g:vimtex_view_method = 'zathura'


" color solarized
" color dracula
" set background=light
set background=dark
if has("gui_running")
    set lines=35 columns=150
	" color dracula
    color ChocolatePapaya
    set background=light
    " let g:airline_theme = 'cool'
    set guioptions-=T  " toolbar
    set guioptions-=m  " menubar
    set guifont="Fira Code 10,Source Code Pro 12,Fixed 12"
end

set hidden

set title         " Always set the terminal title to 'titlestring'

set number
set cursorline

" Change cursor shape in different modes
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" Miscellaneous
set clipboard^=unnamedplus,autoselect
set path+=.,**
set viminfo+=%
set splitright
" set foldcolumn=2  " Make folds more intuitive
 
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

" other features
set dictionary=/usr/share/dict/british,/usr/share/dict/portuguese
set spelllang=en,pt

" Mappings
nnoremap gb :ls<CR>:b<space>
nnoremap <Tab> 
nnoremap <C-s> :<C-u>write<CR>
" nnoremap <C-j> j<C-e>j<C-e>j<C-e>
" nnoremap <C-k> k<C-y>k<C-y>k<C-y>

""""""""""""""""""""""""""""""""""""""""""""""""
"
" DEVIATING FROM STANDARD VIM
"
""""""""""""""""""""""""""""""""""""""""""""""""

" Broken keyboard
function Broken()
    map nn m
    imap nn m
    cmap nn m
    nmap nn m
endfunction
nnoremap <C-S-n> :<C-u>call Broken()<CR>


inoremap jk <esc>
inoremap kj <esc>
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> gj G
nnoremap <silent> gk gg
nnoremap <silent> gl $
nnoremap <silent> gh ^

""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <esc>t :vertical rightbelow terminal<CR>
nnoremap <esc>s :w<CR>
nnoremap <esc>w :w<CR>
nnoremap <esc>S :w!<CR>
nnoremap <esc>W :w!<CR>
nnoremap <esc>r :e<CR>
nnoremap <esc>e :e<CR>
nnoremap <esc>R :e!<CR>
nnoremap <esc>E :e!<CR>

nnoremap <C-l> :noh\|redraw!<CR>

let g:lightmode=0

function LightMode()
    if g:lightmode
        colorscheme dracula
        set background=dark
        let g:lightmode=0
    else
        colorscheme summerfruit256
        set background=light
        let g:lightmode=1
    end
endfunction

command -nargs=0 -bar Light :call LightMode()
nnoremap <silent> <C-S-l>    :Light<CR>
nnoremap <silent> <leader>kl :Light<CR>


nnoremap <silent> <leader>kt :AirlineToggle<CR>
nnoremap <leader>ks :let &laststatus=(&laststatus+1)%3\|echo &laststatus<CR>
nnoremap <leader>ka <Plug>(ale_toggle)
nnoremap <leader>kv :source ~/.vimrc<CR>

" Refinements {{{
" set ttyfast
" set lazyredraw
" }}}

" vim: foldmethod=marker


