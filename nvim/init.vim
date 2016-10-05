"""" Plugins

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'morhetz/gruvbox'
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/gundo.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'hashivim/vim-terraform'
Plugin 'scrooloose/syntastic'

call vundle#end()
filetype plugin indent on

"" Nerdtree
nnoremap <F3> :NERDTreeToggle<CR>

"" Gundo
nnoremap <F4> :GundoToggle<CR>

"" Syntastic
" Load pylint
let g:syntastic_python_checkers = ['pylint']

"" Gruvbox
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark

" Use true colour
set termguicolors


"""" Options

" Jump to matching paren on close
set showmatch
set matchtime=2 " i.e. 2/10 second jump

" Expand tabs to 4 spaces
set expandtab
set tabstop=4
set shiftwidth=0 " use value of tabstop

" Show trailing whitespace and tabs
set list

" Show line numbers
set number


"""" FileTypes

" Python: show PEP8 code/comment widths, set textwidth to code width
autocmd FileType python setlocal textwidth=72 colorcolumn=73,81

" Bash: don't try to manage textwidth
autocmd FileType sh setlocal textwidth=0

" Lua: expand tabs to two spaces
autocmd FileType lua set tabstop=2

" Text: don't number lines
autocmd FileType text set nonumber

" Themes: set the filetype on oh-my-zsh themes to zsh
autocmd BufRead,BufNewFile *.zsh-theme setfiletype zsh


"""" Keybindings

"" Pane naivgation
noremap <leader>w <C-w>w
noremap <leader>j <C-w>j
noremap <leader>k <C-w>k
noremap <leader>l <C-w>l
noremap <leader>h <C-w>h
"tnoremap <C-leader>w <C-\><C-n><C-w>h
"tnoremap <C-leader>j <C-\><C-n><C-w>j
"tnoremap <C-leader>k <C-\><C-n><C-w>k
"tnoremap <C-leader>l <C-\><C-n><C-w>l
noremap <leader><Up> <C-w>j
noremap <leader><Down> <C-w>k
noremap <leader><Right> <C-w>l
noremap <leader><Left> <C-w>h

" Toggle number with F2
nnoremap <F2> :set nonumber!

" Escape from terminal mode
tnoremap <Esc> <C-\><C-n>

" Copy/paste to/from clipboard with automatic :set paste
" +: CLIPBOARD
" *: PRIMARY
noremap <leader>y "+y
noremap <leader>yy "+Y
noremap <leader>p :set paste<CR>:put *<CR>:set nopaste<CR>

" Search for visually selected text
vnoremap // y/<C-R>"<CR>

"""" Miscellanious

" Add the virtualenv's site-packages to vim path
py3 << EOF
import os.path
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    with open(activate_this) as f:
        code = compile(f.read(), activate_this, 'exec')
        exec(code, dict(__file__=activate_this))
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
