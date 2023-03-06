" vim:foldmethod=marker

" Plugins {{{

" Initialise Plug {{{
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" }}}

" Look & feel
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'                                                   " Colour scheme

" Productivity
Plug 'junegunn/fzf'                                                      " Fuzzy finder
Plug 'junegunn/fzf.vim'                                                  " Vim functions for FZF
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }            " Completion

" Development tools
Plug 'tpope/vim-fugitive'                                                " Git integration
Plug 'dense-analysis/ale'                                                " Async linter for nvim/vim8
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}              " Syntax based highlighting and operations using tree-sitter
Plug 'nvim-treesitter/nvim-treesitter-refactor'                          " Refactoring using tree-sitter

" Enhancements
Plug 'mhinz/vim-signify'                                                 " Show VCS add/change/deletes
Plug 'svermeulen/vim-cutlass'                                            " Blackhole deletion
Plug 'svermeulen/vim-subversive'                                         " Substitute motions
Plug 'tpope/vim-commentary'                                              " Code comments
Plug 'tpope/vim-repeat'                                                  " Repeat (. operator) support for plugins
Plug 'tpope/vim-surround'                                                " Enclose text with brackets/quotes/tags/etc.
Plug 'tpope/vim-unimpaired'                                              " Various mappings

call plug#end()

" }}}

" Appearance {{{

" Use true colour
set termguicolors

" Gruvbox
let g:gruvbox_italic=1
colorscheme gruvbox
set background=light

" Jump to matching paren on close
set showmatch
set matchtime=2 " i.e. 2/10 second jump

" Show trailing whitespace and tabs
set list

" Show line numbers
" enabling number and relativenumber puts vim in hybrid mode, whereby the
" current line number is absolute and other lines are relative
set number

" Underline search matches
highlight Search gui=underline guifg=None guibg=None

" Expand focused windows to occupy vertical space
set winwidth=84
set winheight=999
set winminheight=5

" }}}

" Python integration {{{

let g:python3_host_prog = $HOME . "/.pyenv/versions/neovim3/bin/python"

" }}}

" Vim options {{{

" Expand tabs to 4 spaces unless overridden by a filetype plugin
set expandtab
set tabstop=4
set shiftwidth=0 " use value of tabstop

" Don't autobreak in most files
set textwidth=0

" Be smart about case-sensitivity in search: use ignorecase unless pattern contains uppercase
set ignorecase
set smartcase

" Never create swapfiles
set noswapfile

" Clipboard integration
set clipboard+=unnamedplus

" Mouse
set mouse=a

" }}}

" Plugin options {{{

" Deoplete
let g:deoplete#enable_at_startup = 1
" While pop-up menu is visible, TAB should cycle through autocomplete options.
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" signify
let g:signify_vcs_list = [ 'git', 'hg' ]

" Tree-sitter {{{

" tree-sitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
      -- scripting
      "bash",
      "python",
      "ruby",

      -- vim
      "lua",
      "vim",

      -- other
      "go",
      "rust",
      "javascript",
      "java",

      -- data
      "dockerfile",
      "hcl",
      "json",
      "html",
      "toml",
      "yaml",
  },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

require'nvim-treesitter.configs'.setup {
  refactor = {
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
  },
}
EOF

" }}}

" }}}

" Keybindings {{{

" Leader
let mapleader = ','
let maplocalleader = ','

" Clipboard: vim-cutlass makes d destructive, so we add a 'move' operator
nnoremap m d
xnoremap m d
nnoremap mm dd
nnoremap M D

" vim-subversive has no default mappings
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)

" FZF
" Find in current buffer's directory
nmap <leader>t :FZF %%<cr>
" Find in vim process' current directory
nnoremap <leader>T :FZF <cr>
" Find in $HOME
nnoremap <leader>g :FZF ~<cr>
" Find text in files
" Note that column is required for FZF to navigate correctly: removing it
" results in file mangling.
command -nargs=* Find call fzf#vim#grep('rg --fixed-strings --column --line-number --color always '.shellescape(<q-args>), 1)
nnoremap <leader>f :Find<cr>

" }}}

" Filetype settings {{{

" Vagrantfile: treat as ruby
augroup vagrant
  au!
  au BufRead,BufNewFile Vagrantfile set filetype=ruby
augroup END

" Jenkinsfile: treat as groovy
augroup Jenkinsfile
  au!
  au BufRead,BufNewFile Jenkinsfile set filetype=groovy
augroup END

" Various: 2 space tabstop
autocmd FileType javascript,typescript,typescriptreact,html,css,ruby,yaml,lua,sh,tf,Jenkinsfile,coffee setlocal tabstop=2

" Set spell checking on appropriate filetypes:
autocmd FileType markdown,text setlocal spell

" }}}

" Miscellanious {{{

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

" Have %% expand to the directory of the current buffer
" TODO: if the current buffer is not a file this expands to '/'! Should
" default to $HOME
cnoremap %% <C-R>=expand('%:h').'/'<cr>
