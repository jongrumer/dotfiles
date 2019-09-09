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
   Plug 'rhysd/clever-f.vim'                " Clever f F t T commands

call plug#end()

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
set cursorline                               " Cursor line
set tabstop=3                                " Tab behaviour
set softtabstop=0                            "     -
set expandtab                                "     -
set shiftwidth=3                             "     -
set smarttab                                 "     -
set mouse=a                                  " Enable mouse
let mapleader=","                            " Set <leader>

" Vim Behaviour
let g:clever_f_show_prompt = 1
let g:clever_f_across_no_line = 1

" Fortran
" =======
" Shift+f to switch between fixed and free form
nmap <S-F> :set syntax=fortran<CR>:let b:fortran_fixed_source=!b:fortran_fixed_source<CR>:set syntax=text<CR>:set syntax=fortran<CR>
" Ctrl+f to autmatically detect source
nmap <C-F> :filetype detect<CR>
" Set gq command to use fprettify to reformat paragraphs [https://pypi.org/project/fprettify]
" Use <leader>f below to format whole file
autocmd Filetype fortran setlocal formatprg=fprettify\ --silent

" Leader remaps
" =============
" Format whole file (uses fprettify for Fortran, see below)
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
