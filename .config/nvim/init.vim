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

" Python 2 and 3 hosts
" ====================
"let g:python2_host_prog = '/usr/local/bin/python2'
"let g:python3_host_prog = '/Users/jon/anaconda3/bin/python3'
"let g:ruby_host_prog    = '/usr/bin/ruby'


" Plugins
" =======
call plug#begin('$HOME/.local/share//nvim/plugged')

Plug 'morhetz/gruvbox'                   " Color schemes
Plug 'vim-airline/vim-airline'           " Airline status bar
Plug 'vim-airline/vim-airline-themes'    " Airline themes
Plug 'sheerun/vim-polyglot'              " Language packs
Plug 'airblade/vim-gitgutter'            " Git
Plug 'chriskempson/base16-vim'           " UI related

Plug 'Chiel92/vim-autoformat'            " Formater
Plug 'ncm2/ncm2'                         " Autocompletion
Plug 'roxma/nvim-yarp'                   " Needed for ncm2
Plug 'ncm2/ncm2-bufword'                 "  - Current buffer
Plug 'ncm2/ncm2-path'                    "  - Path Completion
"Plug 'autozimu/LanguageClient-neovim', {
"         \ 'branch': 'next',
"         \ 'do': 'bash install.sh',
"         \ }                             " LanguageServer client
Plug 'JuliaEditorSupport/julia-vim'      " Julia

call plug#end()

" Enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" Affects the visual representation of what happens after you hit <C-x><C-o>
" https://neovim.io/doc/user/insert.html#i_CTRL-X_CTRL-O
" https://neovim.io/doc/user/options.html#'completeopt'
"
" This will show the popup menu even if there's only one match (menuone),
" prevent automatic selection (noselect) and prevent automatic text injection
" into the current line (noinsert).
set completeopt=noinsert,menuone,noselect

" Connect to Language servers: https://langserver.org
let g:LanguageClient_autoStart = 1

" - Python: https://github.com/palantir/python-language-server
" - Fortran: https://github.com/hansec/fortran-language-server/wiki/Using-forts-with-vim
" - Julia
let g:default_julia_version = '1.0'

let g:LanguageClient_serverCommands = {
         \   'fortran': ['fortls', '--notify_init', '--lowercase_intrinsics', '--symbol_skip_mem', '--incremental_sync', '--autocomplete_no_prefix', '--variable_hover'],
         \   'python': ['pyls'],
         \   'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
         \       using LanguageServer;
         \       using Pkg;
         \       import StaticLint;
         \       import SymbolServer;
         \       env_path = dirname(Pkg.Types.Context().env.project_file);
         \       debug = false;
         \
         \       server = LanguageServer.LanguageServerInstance(stdin, stdout, debug, env_path, "", Dict());
         \       server.runlinter = true;
         \       run(server);
         \   ']
         \ }

" Context menu
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
"    Document symbols (textDocument/documentSymbol)
"    Auto-complete (textDocument/completion)
"    Signature help (textDocument/signatureHelp)
"    GoTo/Peek definition (textDocument/definition)
"    Hover (textDocument/hover)
"    GoTo implementation (textDocument/implementation)
"    Find/Peek references (textDocument/references)
"    Project-wide symbol search (workspace/symbol)
"    Symbol renaming (textDocument/rename)
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <F3> :call LanguageClient#textDocument_completion()<CR>


" Ale setup
" =========
" let g:ale_fixers = {
" \   '*': ['remove_trailing_lines', 'trim_whitespace']
" \}
" " Set this variable to 1 to fix files when you save them.
" let g:ale_fix_on_save = 1
" " First, make sure: pip3 install jedi flake8 autopep8
" let g:ale_lint_on_enter = 0
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_echo_msg_error_str = 'E'
" let g:ale_echo_msg_warning_str = 'W'
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" let g:ale_linters = {'python': ['flake8']}

" Looks
" =====
colorscheme gruvbox                          " Color scheme
set background=dark                          " Dark/light mode
set termguicolors                            " Allow for 32-bit colors
let g:airline_theme='gruvbox'                " Corresponding airline theme
let g:airline_powerline_fonts = 1            " Turn on fonts
let g:airline_left_sep  = ''
let g:airline_right_sep = ''
let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#error_symbol = 'E:'
let airline#extensions#ale#warning_symbol = 'W:'

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

" Fortran specifics
" =================
"   Set gq command to use fprettify to reformat paragraphs [https://pypi.org/project/fprettify]
"   Use <leader>f below to format whole file
autocmd Filetype fortran setlocal formatprg=fprettify\ --silent

" Python specifics
" ================
autocmd FileType python setlocal formatprg=autopep8\ -
autocmd FileType python setlocal equalprg=autopep8\ -

" General remaps
" ==============
" Make enter break and open newline - normal mode
noremap <CR> i<CR><Esc>==
" Make space add space - in normal mode
noremap <Space> i<Space><Esc>l
" Ctrl+f to autmatically detect source
nmap <C-F> :filetype detect<CR>
" Shift+f to switch between Fortran fixed and free form
nmap <S-F> :set syntax=fortran<CR>:let b:fortran_fixed_source=!b:fortran_fixed_source<CR>:set syntax=text<CR>:set syntax=fortran<CR>

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
