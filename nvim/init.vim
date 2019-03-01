"""" Leader

let mapleader = ','

"""" Plugins

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

"" Look & feel
Plug 'morhetz/gruvbox'                                                   " Colour scheme

" Tools
Plug 'christoomey/vim-tmux-navigator'                                    " Tmux pane navigation
Plug 'tpope/vim-fugitive'                                                " Git integration

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }} " Markdown previews

"" Enhancements
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }            " Completion
Plug 'tpope/vim-commentary'                                              " Code comments
Plug 'tpope/vim-unimpaired'                                              " Various mappings
Plug 'svermeulen/vim-easyclip'                                           " Clipboard enhancements
Plug 'tpope/vim-repeat'                                                  " Repeat (. operator) support for plugins
Plug 'tpope/vim-surround'                                                " Enclose text with brackets/quotes/tags/etc.
Plug 'mhinz/vim-signify'                                                 " Show VCS add/change/deletes
Plug 'junegunn/fzf'                                                      " Fuzzy finder
Plug 'junegunn/fzf.vim'                                                  " Vim functions for FZF

"" Language-specific
Plug 'hashivim/vim-terraform'
Plug 'rodjek/vim-puppet'
Plug 'google/vim-jsonnet'
Plug 'tpope/vim-fireplace'
Plug 'kien/rainbow_parentheses.vim'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

"" Linting
Plug 'scrooloose/syntastic'                                              " General-purpose linter integration

call plug#end()

"" Python 3
let g:python3_host_prog = $HOME . '/.virtualenvs/pynvim-python3/bin/python'
let g:python_host_prog =  $HOME . '/.virtualenvs/pynvim-python2/bin/python'

"" deoplete
let g:deoplete#enable_at_startup = 1
" When pop-up menu is visible remap <TAB> to <C-n> for cycling through
" autocomplete options.
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

"" signify
let g:signify_vcs_list = [ 'git', 'hg' ]

"" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['pylint']
let g:syntastic_sh_checkers = ['shellcheck']
let g:syntastic_puppet_checkers = ['puppetlint']
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

" Use true colour
set termguicolors

"" easyclip
let g:EasyClipUseSubstituteDefaults = 1

"" sexp
" Unset sexp mappings that conflict with tmux navigation. These are replaced
" by tpope's sane mappings anyway
let g:sexp_mappings = {
  \ 'sexp_swap_list_backward':    '',
  \ 'sexp_swap_list_forward':     '',
  \ 'sexp_swap_element_backward': '',
  \ 'sexp_swap_element_forward':  '',
  \ }

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
" enabling number and relativenumber puts vim in hybrid mode, whereby the
" current line number is absolute and other lines are relative
set number relativenumber

" Underline search matches
autocmd ColorScheme * highlight Search cterm=underline ctermfg=None ctermbg=None
autocmd ColorScheme * highlight Search gui=underline guifg=None guibg=None

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

" Never create swapfiles
set noswapfile


"""" FileTypes

" Python: show PEP8 code/comment widths, set textwidth to code width
autocmd FileType python setlocal colorcolumn=80

" Text: don't number lines, wrap to 120
autocmd FileType text setlocal nonumber colorcolumn=120 textwidth=120

" Go: use tabs
autocmd FileType go setlocal noexpandtab

" Themes: set the filetype on oh-my-zsh themes to zsh
autocmd BufRead,BufNewFile *.zsh-theme setfiletype zsh

" Markdown: wrap at 80
autocmd FileType markdown setlocal colorcolumn=120

" Various: 2 space tabstop
autocmd FileType html,css,ruby,yaml,lua,sh,terraform,Jenkinsfile setlocal tabstop=2


"""" Keybindings

" Clipboard integration
set clipboard+=unnamedplus

" Mouse
set mouse=a

" Inc/Dec numbers (default C-a to increment conflicts with tmux leader)
nnoremap <C-k> <C-a>
nnoremap <C-j> <C-x>

" FZF
" Find in current buffer's directory
nmap <leader>t :FZF %%<cr>
" Find in vim process' current directory
nnoremap <leader>T :FZF <cr>
" Find in $HOME
nnoremap <leader>g :FZF ~<cr>
" Find text in files
command -nargs=* Find call fzf#vim#grep('rg --fixed-strings --line-number --color always '.shellescape(<q-args>), 1)
nnoremap <leader>f :Find<cr>

" Switch to last buffer (Basically alt-tab)
nnoremap <leader><leader> <C-^>

" Clojure
" Reload the current namespace
au Filetype clojure nmap <c-c><c-k> :Require<cr>

"""" Miscellanious

" Remove trailing whitespace before write
autocmd BufWritePre * :%s/\s\+$//e

" Restore to file position from previous editing
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \     exe "normal! g`\"" |
    \ endif

" Set nowrap if there are really long lines in the file (e.g. hiera-eyaml
" encrypted fields) Note that the system call returns '<numlines> <path>', but
" the `>` seems to just ignore the non-numeric part.
autocmd BufReadPost * if system('wc -L ' . expand('%')) > 200 | setlocal nowrap | endif

" Use ww!! as a shortcut to save using sudo
cmap w!! w !sudo tee > /dev/null %

" Have %% expand to the directory of the current buffer
" TODO: if the current buffer is not a file this expands to '/'! Should
" default to $HOME
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Focused window expansion
set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=999
