execute pathogen#infect()
syntax enable
filetype plugin indent on
set background=dark
colorscheme gruvbox
set number

set tabstop=3 softtabstop=0 expandtab shiftwidth=3 smarttab

set hlsearch

set cursorline


 " Trailing whitespaces
 " --------------------
 "  Auto remove with <F5>
 :nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

 " highlight trailing whitespace in red
 " have this highlighting not appear whilst you are typing in insert mode
 " have the highlighting of whitespace apply when you open new buffers
 highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
 match ExtraWhitespace /\s\+$/
 autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
 autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
 autocmd InsertLeave * match ExtraWhitespace /\s\+$/
 autocmd BufWinLeave * call clearmatches()
