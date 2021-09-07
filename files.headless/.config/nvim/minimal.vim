set noerrorbells               " No bells!
set vb t_vb=                   " no visual bells
set belloff=all
set title                      " let vim set the terminal title
set nowrap                     " don't wrap lines, leave them on same line
set number                     " show number ruler
set updatetime=100             " redraw the status bar often
set linebreak
set showbreak=━━
set breakindent
set tabstop=2
set shiftwidth=2
set expandtab " insert spaces for tab
set smarttab " tab intelligently on newline
set shiftround
set colorcolumn=80
set hidden

syntax enable
filetype plugin indent on
syntax manual
au Filetype * setlocal syntax=ON
autocmd Filetype * if getfsize(@%) > 1000000 | setlocal syntax=OFF | endif

" quickfix styling
aug QuickFix
  au FileType qf setlocal nonumber colorcolumn=
  " wrap long lines in quickfix - https://github.com/fatih/vim-go/issues/1271
  autocmd FileType qf setlocal wrap
aug END

" General Keybindings
let maplocalleader = ","
let mapleader = ","

" Quickfix keybindings
" Also see ALE ale_next, ale_previous
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>

" Navigation
" https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally
set splitbelow " default horizontal split below instead of above
set splitright " default vertical split right

nnoremap <C-s> :sp <CR>
" Autosave buffers before leaving them
autocmd BufLeave * silent! :wa

" clear search highlights
no <silent><Leader>cs :nohls<CR>

" map kj to escape key only in insert mode.
" I had it also in command and visual but caused delays and unexpected escape
" calls.
inoremap kj <Esc>
