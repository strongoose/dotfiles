if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('/home/dan/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'godlygeek/tabular'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'morhetz/gruvbox'
NeoBundle 'Lokaltog/powerline'
NeoBundle 'ervandew/supertab'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'fholgado/minibufexpl.vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'vim-scripts/TaskList.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'dag/vim-fish'
NeoBundle 'vim-latex/vim-latex'

" You can specify revision/branch/tag.
" NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" settings
set nocompatible " disable Vi compatibility
set backspace=eol,start " allow backspacing over eols and past start of insert
set nobackup " don't bother with backup files
set history=256
set incsearch " search while search command is still being typed
set cursorline
set cursorcolumn
set showmatch
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set textwidth=79
set colorcolumn=81
set foldenable
set foldmethod=indent
set foldlevel=99
set scrolloff=3
set number
set wildmenu
set wildmode=longest,list,full
set t_Co=256
set encoding=utf-8

" FileType specific settings
autocmd FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 textwidth=72 colorcolumn=73,81 list
autocmd FileType sh setlocal tabstop=2 expandtab shiftwidth=4 softtabstop=4 textwidth=0
autocmd FileType lua set shiftwidth=2 softtabstop=2

" Fix some key combinations vim doesn't recognise.
map [3$ <S-Del>
map Oc <c-Right>
map Od <c-Left>
map Oa <c-Up>
map Ob <c-Down>

" key maps
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-h> <C-w>h
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
map <F5> :w<CR>:!python % <CR>
nnoremap <F7> :set nolist!<CR>:set foldcolumn=0<CR>
map <leader>TT :TaskList<CR>

" Color
colorscheme gruvbox
set background=dark

" Powerline
set rtp+=/home/dan/.vim/bundle/powerline/powerline/bindings/vim
set laststatus=2
let g:Powerline_symbols = 'fancy'

" Jedi python
autocmd FileType python setlocal completeopt-=preview
let g:jedi#popup_select_first = 0

" Supertab
"let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']

" Nerdtree
nnoremap <F3> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\~$', '^\.git', '\.swp$', '\.pyc']
let NERDTreeShowHidden=0

" Gundo
nnoremap <F6> :GundoToggle<CR>

" Minibuffer
noremap <S-RIGHT> :MBEbn<CR>
noremap <S-LEFT> :MBEbp<CR>
noremap <S-Del> :MBEbd<CR>

" Tagbar
let g:tagbar_autofocus = 1
nmap <F4> :TagbarToggle<CR>

" Syntastic
let g:syntastic_python_checkers = ['pylint']

" vim-latex
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
autocmd FileType latex setlocal sw=2 iskeyword+=:
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_ViewRule_pdf = 'mupdf'
let g:Tex_CompileRule_pdf = 'xelatex -synctex=1 -interaction=nonstopmode $*'
" vim-latex/plugin/imaps.vim vmaps and nmaps <C-j> to <Plug>IMAP_JumpForward
" But I want <C-j> to be mapped to <C-W>j, so we need to noremap
" <Plug>IMAP_JumpForward
nnoremap <C-space> <Plug>IMAP_JumpForward
vnoremap <C-space> <Plug>IMAP_JumpForward

" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" Restore to file position from previous editing
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" Use ww!! as a shortcut to save using sudo 
cmap ww!! w !sudo tee > /dev/null %

" Fix a mapping conflict with TaskList
nnoremap <leader>v <Plug>TaskList
