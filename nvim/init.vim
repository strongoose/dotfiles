"""" Plugins

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'morhetz/gruvbox'
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/gundo.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-surround.git'
Plugin 'tpope/vim-fireplace'
Plugin 'venantius/vim-eastwood'
Plugin 'pearofducks/ansible-vim'
Plugin 'hashivim/vim-terraform'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'benmills/vimux'
Plugin 'vim-latex/vim-latex'

call vundle#end()
filetype plugin indent on

"" Nerdtree
nnoremap <F3> :NERDTreeToggle<CR>

"" Gundo
nnoremap <F4> :GundoToggle<CR>

"" Syntastic
" Load pylint
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_sh_checkers = ['shellcheck']

"" Gruvbox
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark

"" Vim Tmux Navigator
" Disable default mappings
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
nnoremap <silent> <M-w> :TmuxNavigatePrevious<cr>

"" Vimux
nnoremap <Leader>vp :VimuxPromptCommand<CR>
nnoremap <Leader>vc :VimuxCloseRunner<CR>

"" Vim-LaTeX
" Use XeLaTeX
let g:Tex_CompileRule_pdf = 'xelatex $*'
" Output PDF by default
let g:Tex_DefaultTargetFormat = 'pdf'

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

" hlsearch is just annoying
set nohlsearch

" Highlight cursor line and collumn
set cursorline
set cursorcolumn

" Display line, collumn number and percentage progress through file in
" statusbar
set ruler


"""" FileTypes

" Python: show PEP8 code/comment widths, set textwidth to code width
autocmd FileType python setlocal textwidth=72 colorcolumn=73,81

" Bash: don't try to manage textwidth
autocmd FileType sh setlocal textwidth=0

" Lua: expand tabs to two spaces
autocmd FileType lua set tabstop=2

" Text: don't number lines
autocmd FileType text set nonumber

" Go: use tabs
autocmd FileType go setlocal noexpandtab

" YAML: 2 space tabstop
autocmd FileType yaml setlocal tabstop=2

" Themes: set the filetype on oh-my-zsh themes to zsh
autocmd BufRead,BufNewFile *.zsh-theme setfiletype zsh


"""" Keybindings

"" Pane naivgation
" See Vim Tmux Navigator settings above

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
