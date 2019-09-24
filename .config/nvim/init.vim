"
" NeoVim Config File
"
" Autoinstall Plug
" ================
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
   silent !curl -fLo '~/.local/share/nvim/site/autoload/plug.vim' --create-dir \
   'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
" =======
call plug#begin('$HOME/.local/share//nvim/plugged')

Plug 'morhetz/gruvbox'                   " Color schemes
Plug 'vim-airline/vim-airline'           " Airline status bar
Plug 'vim-airline/vim-airline-themes'    " Airline themes
Plug 'sheerun/vim-polyglot'              " Language packs
Plug 'airblade/vim-gitgutter'            " Git
Plug 'chriskempson/base16-vim'           " UI related
Plug 'dense-analysis/ale'                " Syntax checking
Plug 'Chiel92/vim-autoformat'            " Formater
Plug 'rudrab/vimf90'                     " General fortran stuff
Plug 'SirVer/ultisnips'                  " Dependency to vimf90

"Plug 'neoclide/coc.nvim', {'branch': 'release'} " Completion framework and language server client

" Not sure about these, for Python
"Plug 'ncm2/ncm2'                         " Autocomplete (Python only?)
"Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-path'
"Plug 'ncm2/ncm2-jedi'
"Plug 'roxma/nvim-yarp'

call plug#end()

" Ale setup
" =========
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace']
\}
" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1
" First, make sure: pip3 install jedi flake8 autopep8
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {'python': ['flake8']}

" Looks
" =====
colorscheme gruvbox                          " Color scheme
set background=dark                          " Dark/light mode
let g:airline_theme='gruvbox'                " Corresponding airline theme
let g:airline_powerline_fonts = 1            " Turn on fonts
set termguicolors                            " Allow for 32-bit colors

" Basics
" ======
syntax on                                    " Syntax highlighting
filetype plugin indent on

set number                                   " Line numbers
"set relativenumber
set cursorline                               " Cursor line

set tabstop=3                                " Tab behaviour
set softtabstop=0                            "     -
set expandtab                                "     -
set shiftwidth=3                             "     -
set smarttab                                 "     -

"set mouse=a                                  " Enable mouse

set hidden
set noshowmode
set noshowmatch
set nolazyredraw

" Turn off backup
set nobackup
set noswapfile
set nowritebackup

" Search configuration
set ignorecase                    " ignore case when searching
set smartcase                     " turn on smartcase

let mapleader=","                            " Set <leader>

" Vim Behaviour
let g:clever_f_show_prompt = 1
let g:clever_f_across_no_line = 1

" Fortran
" =======
" VimF90 Plug leader
" let g:VimF90Leader = ','

" Set gq command to use fprettify to reformat paragraphs [https://pypi.org/project/fprettify]
" Use <leader>f below to format whole file
autocmd Filetype fortran setlocal formatprg="fprettify\ --silent"

" Fortran Language Server
" General: https://github.com/hansec/fortran-language-server
" NeoVim:  https://github.com/hansec/fortran-language-server/wiki/Using-forts-with-vim
let g:LanguageClient_serverCommands = {
    \   'fortran': ['fortls', '--symbol_skip_mem', '--incrmental_sync', '--autocomplete_no_prefix']
    \ }

" Shift+f to switch between fixed and free form
nmap <S-F> :set syntax=fortran<CR>:let b:fortran_fixed_source=!b:fortran_fixed_source<CR>:set syntax=text<CR>:set syntax=fortran<CR>

" Python
" ======
autocmd FileType python setlocal shiftwidth=3 softtabstop=3 expandtab

" General remaps
" ==============
" Ctrl+f to autmatically detect source
nmap <C-F> :filetype detect<CR>

" Leader remaps
" =============
noremap <leader>a :Autoformat<CR>
" Format whole file (uses fprettify for Fortran)
nnoremap <leader>f gggqG
" Indent whole file
nnoremap <leader>i gg=G
" Delete trailing white space and Dos-returns and to expand tabs to spaces.
nnoremap <Leader>t :set et<CR>:retab!<CR>:%s/[\r \t]\+$//<CR>
" Remove trailing white spaces
nnoremap <leader>w :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
" Convert whole file to lower case
nnoremap <leader>l ggVGu
" Convert whole file to upper case
nnoremap <leader>u ggVGU

" Other remaps
" ============
" Make enter break and open newline - normal mode
noremap <CR> i<CR><Esc>==
" Make space add space - in normal mode
noremap <Space> i<Space><Esc>l


" Return to same line when file is reopened
" =========================================
augroup line_return
   au!
   au BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \     execute 'normal! g`"zvzz' |
            \ endif
augroup END

" Trailing whitespaces
" ====================
" Highlight trailing whitespaces
" Make this highlighting not appear whilst you are typing in insert mode
" Make this highlighting of whitespaces apply when you open new buffers
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
