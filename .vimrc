let mapleader ="ñ"
colors dracula
syntax on
set number
set guifont=ProFont\ 10
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
noremap <F12> :w \| !clear && echo "% is running..." && python3 %<CR>
let g:pymode_virtualenv = 1 
let g:pymode_python = 'python'

" autocomplection
set wildmode=longest,list,full
set wildmenu

" Open corresponding .pdf
map <leader>p :!opout <c-r>%<CR><CR>

" Compile document
map <leader>c :!groff -ms review.ms -T pdf > review.pdf <c-r>%<CR>

" Replace all is aliased to S.
map <leader>r :%s//g<Left><Left>

" groff files automatically detected
autocmd BufRead,BufNewFile *.ms,*.me,*.mom set filetype=groff


" Spell-check set to F6:
map <leader>s :setlocal spell! spelllang=en_us<CR>

" Copy selected text to system clipboard (requires gvim installed):
vnoremap <C-c> "*Y :let @+=@*<CR>
map <C-p> "+P

" Transparent background with ctrl T
let t:is_transparent = 0
function! Toggle_transparent()
    if t:is_transparent == 0
        hi Normal guibg=NONE ctermbg=NONE
        let t:is_transparent = 1
    else
        set background=dark
        let t:is_tranparent = 0
    endif
endfunction
nnoremap <C-t> : call Toggle_transparent()<CR>

au BufRead /tmp/mutt-* set tw=72

" Enable folding
set foldmethod=indent
set foldlevel=99
set mouse=a
set nocompatible
filetype off

" set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" The bundles you install will be listed here

filetype plugin indent on

" The rest of your config follows here
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'
" Vimtex
Plug 'lervag/vimtex'
" Poweline
Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" Git
Plug 'tpope/vim-fugitive'
" Searching
Plug 'kien/ctrlp.vim'
"python-mode
Plug 'python-mode/python-mode', { 'branch': 'develop' }


" Initialize plugin system
call plug#end()
