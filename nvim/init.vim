"""" Leader

let mapleader = ','

"""" Plugins

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'            " Plugin manager

"" Look & feel
Plugin 'morhetz/gruvbox'                 " Colour scheme
Plugin 'myusuf3/numbers.vim'             " Line numbers

" Tools
Plugin 'christoomey/vim-tmux-navigator'  " Tmux pane navigation integration
Plugin 'tpope/vim-fugitive'              " Git integration

"" Navigation
Plugin 'junegunn/fzf'                    " Fuzzy file finder
Plugin 'junegunn/fzf.vim'
Plugin 'scrooloose/nerdtree'             " File browser

"" Enhancements
Plugin 'Shougo/deoplete.nvim'            " Completion
Plugin 'scrooloose/nerdcommenter'        " Code comments
Plugin 'sjl/gundo.vim'                   " Undo tree navigation
Plugin 'svermeulen/vim-easyclip'         " Clipboard enhancements
Plugin 'tpope/vim-repeat'                " Repeat (. operator) support for plugins
Plugin 'tpope/vim-surround'              " Enclose text with brackets/quotes/tags/etc.
Plugin 'mhinz/vim-signify'

"" Syntax highlighting and coding
Plugin 'fatih/vim-go'                    " Golang
Plugin 'hashivim/vim-terraform'          " Terraform
Plugin 'leshill/vim-json'                " JSON syntax highlighting
Plugin 'martinda/Jenkinsfile-vim-syntax' " Jenkinsfiles
Plugin 'pearofducks/ansible-vim'         " Ansible
Plugin 'rodjek/vim-puppet'               " Puppet
Plugin 'zchee/deoplete-jedi'             " Python

" Clojure
Plugin 'tpope/vim-fireplace'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'vim-scripts/paredit.vim'

"" Linting
Plugin 'scrooloose/syntastic'            " General-purpose linter integration
Plugin 'venantius/vim-eastwood'          " Clojure linting

call vundle#end()
filetype plugin indent on

"" Python 3
let g:python3_host_prog = $HOME . '/.virtualenvs/neovim-python3/bin/python'
let g:python_host_prog = $HOME . '/.virtualenvs/neovim-python2/bin/python'

"" deoplete
let g:deoplete#enable_at_startup = 1
" When pop-up menu is visible remap <TAB> to <C-n> for cycling through
" autocomplete options.
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

"" signify
let g:signify_vcs_list = [ 'git', 'hg' ]

"" Nerdtree
nnoremap <F3> :NERDTreeToggle<CR>

"" Gundo
nnoremap <F4> :GundoToggle<CR>

"" Syntastic
" Load pylint
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_sh_checkers = ['shellcheck']
let g:syntastic_js_checkers = ['jshint']
let g:syntastic_html_checkers = ['tidy']
let g:syntastic_css_checkers = ['csslint']

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

"" Vim Terraform
let g:terraform_fmt_on_save = 1

"" Vim-LaTeX
" Use XeLaTeX
let g:Tex_CompileRule_pdf = 'xelatex $*'
" Output PDF by default
let g:Tex_DefaultTargetFormat = 'pdf'

" Use true colour
set termguicolors

"" FZF
nnoremap <C-E> :Files<CR>

"" easyclip
let g:EasyClipUseSubstituteDefaults = 1


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

" Don't autowrap in most files
set textwidth=0

" Be smart about case: use ignorecase unless pattern contains uppercase
set ignorecase
set smartcase


"""" FileTypes

" Python: show PEP8 code/comment widths, set textwidth to code width
autocmd FileType python setlocal colorcolumn=80

" Text: don't number lines, wrap to 120
autocmd FileType text setlocal nonumber colorcolumn=120

" Go: use tabs
autocmd FileType go setlocal noexpandtab

" Themes: set the filetype on oh-my-zsh themes to zsh
autocmd BufRead,BufNewFile *.zsh-theme setfiletype zsh

" Markdown: wrap at 80
autocmd FileType markdown setlocal colorcolumn=120

" Various: 2 space tabstop
autocmd FileType html,css,ruby,yaml,lua,sh,terraform,Jenkinsfile setlocal tabstop=2


"""" Keybindings

" Toggle number with F2
nnoremap <F2> :set nonumber!

" Clipboard integration
set clipboard=unnamedplus

" Mouse
set mouse=a

" Inc/Dec numbers (default C-a to increment conflicts with tmux leader)
nnoremap <C-k> <C-a>
nnoremap <C-j> <C-x>


"""" Miscellanious

" Remove trailing whitespace before write
autocmd BufWritePre * :%s/\s\+$//e

" Restore to file position from previous editing
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Set nowrap if there are really long lines in the file (e.g. hiera-eyaml
" encrypted fields) Note that the system call returns '<numlines> <path>', but
" the `>` seems to just ignore the non-numeric part.
autocmd BufReadPost * if system('wc -L ' . expand('%')) > 200 | setlocal nowrap | endif

" Local chdir to file directory on read
"autocmd BufRead,BufNewFile * silent! lcd %:p:h

" Use ww!! as a shortcut to save using sudo
cmap w!! w !sudo tee > /dev/null %
