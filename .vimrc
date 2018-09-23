" when compatible is set, all the enhancements and improvements of Vi Improved are turned off.
set nocompatible

" Plug {{{

" Vim plugin manager Vim-Plug
call plug#begin('~/.vim/plugged')

Plug 'conradirwin/vim-bracketed-paste'
Plug 'git@github.com:jalvesaq/Nvim-R.git'
Plug 'git@github.com:Raimondi/delimitMate.git'
Plug 'git@github.com:lervag/vimtex.git'
Plug 'git@github.com:chrisbra/csv.vim.git'
Plug 'git@github.com:bronson/vim-trailing-whitespace.git'
Plug 'git@github.com:tomtom/tcomment_vim.git'
Plug 'git@github.com:tpope/vim-fugitive.git'
Plug 'git@github.com:chrisbra/Colorizer.git'
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'fatih/vim-go'
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'chriskempson/base16-vim'

call plug#end()

"" vim-go

let g:go_metalinter_enabled = ['vet', 'golint']

" automagically get dependencies
let g:go_fmt_command = "goimports"

" because the following wasnt working
let g:go_metalinter_autosave = 1
" autocmd BufWritePost *.go :GoMetaLinter

"" tcomment

" toggle
map <Leader>/ :TComment<CR>

"" vim-markdown

" disable the stupid folding
let g:vim_markdown_folding_disabled = 1

" for displaying LaTeX math
let g:vim_markdown_math = 1

"" vimtex

" make compile nice
autocmd FileType tex :nmap <Leader>ll \ll
nnoremap <Leader>ss :LatexmkStop<CR>

" taken from @gkafham's (https://github.com/gkapfham/dotfiles) .vimrc
let g:vimtex_latexmk_options="-pdf -pdflatex='pdflatex -file-line-error -shell-escape -interaction=nonstopmode -synctex=1'"
let g:vimtex_fold_enabled = 0
let g:vimtex_quickfix_mode = 2
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_toc_resize = 0
let g:vimtex_toc_hide_help = 1
let g:vimtex_indent_enabled = 1
let g:vimtex_latexmk_enabled = 1
let g:vimtex_latexmk_callback = 1
let g:vimtex_complete_recursive_bib = 0
let g:vimtex_view_method = 'mupdf'
let g:vimtex_view_mupdf_options = '-r 288'

"" vim-gitgutter

" reduce udpate time to 250 ms
set updatetime=250

"" NERDTree

" open NERDTree upon opening vim
autocmd vimenter * NERDTree

" start cursor out of NERDTree
autocmd VimEnter * wincmd p

" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" show current file NERDTree
nnoremap <silent> <C-n> :NERDTreeFind<CR>
inoremap <C-d> <Del>

" toggle NERDTree with ,nt
map <Leader>nt :NERDTreeToggle<ENTER>

" don't display junk in NERDTree
let NERDTreeIgnore = ['\.class$', '\.pyc$', '\.aux$', 'fdb_latexmk$', '\.fls$', '\.out$']

" shutdown vim if only window is a NERDTree window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" change arrow appearance
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" show hidden files
let NERDTreeShowHidden=1

" Set encoding to UTF-8 to show glyphs - vim-devicons & vim-nerdtree-syntax-highlight
set encoding=utf8
let g:airline_powerline_fonts = 1
let g:NERDTreeFileExtensionHighlightFullName = 1

"" fzf

let g:fzf_command_prefix = 'Fzf'

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~20%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Load hidden files
command! FZFHidden call fzf#run({
\  'source':  'ag --hidden --ignore .git -l -g ""',
\  'sink':    'e',
\  'options': '-m -x +s --no-bold --cycle',
\  'down':    '25%'})

" Load non-hidden files
command! FZFMine call fzf#run({
\  'source':  'ag --ignore .git -l -g ""',
\  'sink':    'e',
\  'options': '-m -x +s --no-bold --cycle',
\ 'down': '25%'})

" Define key combinations
nmap <C-p> :FZFMine<CR>
nmap <C-f> :FzfAg<CR>
nnoremap <silent> <Leader>ag :FzfAg <C-R><C-W><CR>

" }}}

" System {{{

" copy and paste to system clipboard
set clipboard=unnamedplus

let maplocalleader = ","
let mapleader = ","

" set no swap files
set noswapfile

" allow filetype to be on
filetype plugin indent on

" set backspace
set backspace=2

" size of a hard tabstop
set tabstop=2

" size of an indent
set shiftwidth=2

" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=2

" make tab insert indents instead of tabs at the beginning of a line
set smarttab

" always uses spaces instead of tab characters
set expandtab

" map kj to escape key
inoremap kj <Esc>

" turn spell check on for markdown and tex files
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.tex setlocal spell

" taken from Gregory M. Kapfhammer's dotfiles (github.com/gkapfham/dotfiles)

" Source the vimrc file
command! Reload :source $MYVIMRC

" }}}

" Display {{{

" ugly green/yellow bars without this set
" set termguicolors
colorscheme Tomorrow-Night-Eighties

" line numbers
set number
set relativenumber

" don't wrap lines, leave them on same line
set nowrap

" redraw screen faster
set nocursorcolumn
set nocursorline
set ttyfast

" fix slow screen redrawing
set lazyredraw

" always show statusline
set laststatus=2

" matching parentheses
set showmatch

set colorcolumn=80

" syntax highlighting
syntax on

" fix grey line number bar
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" remove background from git gutter
let g:gitgutter_override_sign_column_highlight = 0

" }}}

" Navigation {{{

" navigating vim splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" }}}

" Extra {{{

" Execute clear whitespace on save
map <Leader>st :call Preserve("%s/\\s\\+$//e")<CR>

" remove trailing whitespace
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" clear search highlights
no <silent><Leader>cs :nohls<CR>

" if the last window open is a quickfix window or only a quickfix and NERDTree, quit all
autocmd BufEnter * call LastWindow()
function! LastWindow()
  " if the window is quickfix go on
  if len(getbufinfo({'buflisted':1})) == 1
    if &buftype=="quickfix"
      quit!
    elseif buffer_name(2) == "NERD_tree_1"
      quit!
    endif
  elseif len(getbufinfo({'buflisted':1})) == 2
    if buffer_name(2) == "NERD_tree_1" && getbufvar(winbufnr(win_getid(2)), '&buftype')=="quickfix"
      quitall!
    endif
  endif
endfunction

command! JSONPrettyPrint execute ":%!python -m json.tool"
nmap <Leader>jj :JSONPrettyPrint<CR>

" }}}