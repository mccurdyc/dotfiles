"----------------------------------------------
" plugin management
"
" Download vim-plug from the URL below and follow the installation
" instructions:
" https://github.com/junegunn/vim-plug
"----------------------------------------------
call plug#begin('~/.vim/plugged')

" dependencies
Plug 'godlygeek/tabular'  " plasticboy/vim-markdown
Plug 'tpope/vim-fugitive' " itchyny/lightline.vim

" general plugins
Plug 'conradirwin/vim-bracketed-paste'
Plug 'Raimondi/delimitMate'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tomtom/tcomment_vim'
Plug 'chrisbra/Colorizer'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'      " linting
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-surround'      " quickly surround blocks of code (e.g., {}, (), <p></p>, etc.).
Plug 'junegunn/vim-easy-align' " gaip=
Plug 'junegunn/limelight.vim'  " focused highlighting
Plug 'kshenoy/vim-signature'   " display marks in sidebar
Plug 'itchyny/lightline.vim'   " light, configurable statusline
Plug 'vim-scripts/paredit.vim'

" language support
Plug 'lervag/vimtex'
Plug 'chrisbra/csv.vim'
Plug 'plasticboy/vim-markdown'
Plug 'jalvesaq/Nvim-R'
Plug 'pangloss/vim-javascript'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make' }
Plug 'sebdah/vim-delve'        " debugger
Plug 'tpope/vim-fireplace'                                                        " Clojure
Plug 'venantius/vim-cljfmt'
Plug 'vim-scripts/paredit.vim'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' } " Go auto completion
Plug 'zchee/deoplete-go', { 'do': 'make' }                                        " Go auto completion
Plug 'zchee/deoplete-jedi'                                                        " Go auto completion
Plug 'sebastianmarkow/deoplete-rust'
Plug 'racer-rust/vim-racer'
Plug 'tpope/vim-fireplace'                                                        " Clojure
Plug 'venantius/vim-cljfmt'
Plug 'rust-lang/rust.vim'

" colorscheme
Plug 'chriskempson/base16-vim'
Plug 'daviesjamie/vim-base16-lightline' " lightline colorscheme

" Always load special fonts last
" Plug 'ryanoasis/vim-devicons' " make sure your font supports it (e.g., use Source Code Pro)

call plug#end()

"----------------------------------------------
" general settings
"----------------------------------------------
set clipboard=unnamedplus      " copy and paste to system clipboard
set smarttab                   " indents instead of tabs at the beginning of a line
set autowrite                  " write when switching buffers
set autoread
set encoding=utf-8
set noswapfile                 " disable swap file usage
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
set completeopt+=noselect
set ttyfast                    " fix slow scrolling
set lazyredraw                 " fix slow screen redrawing
set colorcolumn=80
set statusline=2
set hidden

" Display with faster timeouts in the TUI
set timeoutlen=500
set ttimeoutlen=10

" Do not display the standard status line
set noshowmode " replaced by itchyny/lightline

" Display problematic whitespace
set listchars=tab:➜\ ,trail:•,extends:#,precedes:#,nbsp:⌻
set list

" [gofmt](https://golang.org/cmd/gofmt) uses tabs, so disable the listing for Go
au BufNewFile,BufRead,BufEnter *.go set nolist

let maplocalleader = ","
let mapleader = ","

" Allow vim to set a custom font or color for a word
syntax enable
syntax on

" Remove trailing white spaces on save
autocmd BufWritePre * :%s/\s\+$//e

" map kj to escape key
inoremap kj <Esc>

" turn spell check on for markdown and tex files
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.tex setlocal spell

"----------------------------------------------
" color settings
"----------------------------------------------
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-eighties

" fix grey line number bar
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

"----------------------------------------------
" plugin settings
"----------------------------------------------
" Plugin: sebastianmarkow/deoplete-rust

" required
let g:deoplete#sources#rust#racer_binary='/home/mccurdyc/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/home/mccurdyc/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'

" default
nmap <buffer> gd <plug>DeopleteRustGoToDefinitionDefault
nmap <buffer> K  <plug>DeopleteRustShowDocumentation

" Plugin: racer-rust/vim-racer
set hidden
let g:racer_cmd = "/home/mccurdyc/.cargo/bin/racer"

" show the complete function definition (e.g. its arguments and return type)
let g:racer_experimental_completer = 1

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

" Plugin: itchyny/lightline.vim
" Dependency: tpope/vim-fugitive (for branch info)
let g:lightline = {
      \ 'colorscheme': 'base16',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" Plugin: junegunn/limelight
" focused paragraph highlighting
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Display the current block of text/code in a highlighting limelight
nmap <Space>f :Limelight!! <CR>

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 0

" Plugin: junegunn/vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Plugin: airblade/vim-gitgutter
" remove background from git gutter
let g:gitgutter_override_sign_column_highlight = 0

" Plugin: dense-analysis/ale
let g:ale_sign_column_always = 1 " always keep sign gutter open to avoid jumpiness
let g:ale_completion_enabled = 1

" moving between warnings and errors quickly.
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Show 5 lines of errors (default: 10)
let g:ale_list_window_size = 5

" Error and warning signs.
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '▸'
highlight link ALEWarningSign String
highlight link ALEErrorSign WarningMsg

" In ~/.vim/vimrc, or somewhere similar.
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint']
\}

" https://github.com/w0rp/ale/blob/master/doc/ale-go.txt
let g:ale_linters = {
\ 'go': ['golangci-lint', 'gofmt'],
\ 'javascript': ['eslint'],
\ 'rust': ['rustc'],
\ }

let g:ale_go_golangci_lint_executable = '$GOPATH/bin/golangci-lint'

let g:ale_fix_on_save = 0 " fix files when you save
" Enable completion where available.
" This setting must be set before ALE is loaded.
let g:ale_completion_enabled = 1

" https://www.reddit.com/r/vim/comments/5iixed/how_to_navigate_autocomplete_popup_without_arrows/
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

set omnifunc=ale#completion#OmniFunc

" Plugin: pasticboy/vim-markdown
let g:vim_markdown_folding_disabled = 1 " disable folding
let g:vim_markdown_math = 1 " for displaying LaTeX math

" Plugin: lervag/vimtex
" make compile nice
autocmd FileType tex :nmap <Leader>ll \ll

" Plugin: scrooloose/nerdtree
autocmd VimEnter * NERDTree " open NERDTree upon opening vim
autocmd VimEnter * wincmd p " start cursor out of NERDTree
autocmd StdinReadPre * let s:std_in=1 " open a NERDTree automatically when vim starts up if no files were specified
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" show current file NERDTree
nnoremap <silent> <C-n> :NERDTreeFind<CR>

" toggle NERDTree with ,nt
map <Leader>nt :NERDTreeToggle<CR>

" ignore the following in NERDTree
let NERDTreeIgnore = ['\.class$', '\.pyc$', '\.aux$', 'fdb_latexmk$', '\.fls$', '\.out$']

" shutdown vim if only window is a NERDTree window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" change arrow appearance
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" show hidden files
let NERDTreeShowHidden=1

" Set encoding to UTF-8 to show glyphs - vim-devicons & vim-nerdtree-syntax-highlight
let g:NERDTreeFileExtensionHighlightFullName = 1

" Plugin: junegunn/fzf
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

" Plugin: tpope/vim-fireplace
" reference: https://blog.venanti.us/clojure-vim/
" for reloading namespace
au Filetype clojure nmap <C-c><C-k> :Require<cr>
let g:clj_fmt_autosave = 1 " disable (=0) :Cljfmt automatically on save (I think it was why NeoVim froze)

" Plugin: fatih/vim-go
let g:go_fmt_command = "goimports" " automagically get dependencies
let g:syntastic_go_checkers = ['golangci-lint', 'govet']
let g:go_def_mode='gopls' " fixed C-] goes to definition

" display function declarations
au FileType go nmap <leader>gt :GoDeclsDir<cr>

" GoAlternate; open in splits
au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)

" GoCoverage
au FileType go nmap <leader>gct :GoCoverageToggle -short<cr>
let g:go_auto_type_info = 0 " show type information in status line

" Plugin: shougo/deoplete.nvim
set completeopt=longest,menuone " auto complete setting
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns['default'] = '\h\w*'
let g:deoplete#omni#input_patterns = {}
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#align_class = 1

imap <expr> <tab>   pumvisible() ? "\<c-n>" : "\<tab>"
imap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<tab>"
imap <expr> <cr>    pumvisible() ? deoplete#close_popup() : "\<cr>"

" paste with 'p' multiple times
xnoremap p pgvy

"----------------------------------------------
" navigation settings
"----------------------------------------------
" Autosave buffers before leaving them
autocmd BufLeave * silent! :wa

" navigating vim splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" navigating NeoVim terminal splits
tnoremap <C-j> <C-\><C-n><C-j>
tnoremap <C-k> <C-\><C-n><C-k>
tnoremap <C-l> <C-\><C-n><C-l>
tnoremap <C-h> <C-\><C-n><C-h>

"----------------------------------------------
" search settings
"----------------------------------------------
set incsearch                     " move to match as you type the search query
set hlsearch                      " disable search result highlighting

if has('nvim')
    set inccommand=split          " enables interactive search and replace
endif

" clear search highlights
no <silent><Leader>cs :nohls<CR>

"----------------------------------------------
" splits settings
"----------------------------------------------
" Create horizontal splits below the current window
set splitbelow
set splitright

" Creating splits
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>h :split<cr>

" Closing splits
nnoremap <leader>q :close<cr>
