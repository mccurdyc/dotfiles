call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'voldikss/vim-floaterm' " floating terminal toggle
Plug 'tpope/vim-fugitive'
Plug 'tomtom/tcomment_vim'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'                " linting
Plug 'sebdah/vim-delve'        " debugger
" Plug 'kshenoy/vim-signature'   " display marks in sidebar
" Plug 'itchyny/lightline.vim'   " light, configurable statusline
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" colorscheme
Plug 'chriskempson/base16-vim'
" Plug 'daviesjamie/vim-base16-lightline' " lightline colorscheme

call plug#end()

"----------------------------------------------
" general settings
"----------------------------------------------
" Display screen redraws faster
set nocursorcolumn
set nocursorline
set ttyfast

set clipboard=unnamedplus      " copy and paste to system clipboard
set smarttab                   " indents instead of tabs at the beginning of a line
set autowrite                  " write when switching buffers
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

" map kj to escape key
inoremap kj <Esc>

" turn spell check on for markdown and tex files
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.tex setlocal spell

"----------------------------------------------
" color settings
"----------------------------------------------
set termguicolors
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-eighties

" fix grey line number bar
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

"----------------------------------------------
" plugin settings
"----------------------------------------------
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

" Plugin: airblade/vim-gitgutter
" remove background from git gutter
let g:gitgutter_override_sign_column_highlight = 0

" Plugin: w0rp/ale
let g:ale_sign_column_always = 1 " always keep sign gutter open to avoid jumpiness

" moving between warnings and errors quickly.
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Show 5 lines of errors (default: 10)
let g:ale_list_window_size = 10

" Error and warning signs.
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '▸'
highlight link ALEWarningSign String
highlight link ALEErrorSign WarningMsg

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'go': ['gofmt'],
\   'terraform': ['fmt'],
\}

let g:ale_linters = {
\ 'go': ['gopls', 'golangci-lint', 'gofmt'],
\ 'rust': ['rustc'],
\ 'terraform': ['fmt', 'tflint'],
\ }

let g:ale_go_golangci_lint_executable = '$GOPATH/bin/golangci-lint'
" let g:ale_terraform_terraform_executable = '/usr/bin/terraform'
let g:ale_terraform_tflint_executable = '$GOPATH/bin/tflint'

let b:ale_fix_on_save = 1
" let b:ale_completion_enabled = 1

" Plugin: junegunn/fzf
let g:fzf_command_prefix = 'Fzf'

au FileType fzf set nonu nornu

" Floating window in NeoVim!
" This requires NeoVim > 0.4.0
function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': 1,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  let win = nvim_open_win(buf, v:true, opts)
  call setwinvar(win, '&number', 0)
endfunction

" Load just hidden files
command! FZFHidden call fzf#run({
      \  'window': 'call FloatingFZF()',
      \  'source':  'rg --hidden -l -g "!.git',
      \  'sink':    'e',
      \  'options': '-m -x +s --no-bold --cycle'})

" Load all files
command! FZFFiles call fzf#run({
      \  'window': 'call FloatingFZF()',
      \  'source':  'rg --hidden --files -l -g "!.git"',
      \  'sink':    'e',
      \  'options': '--no-bold --cycle'})

" Load files in Git
command! FZFGit call fzf#run({
      \  'window': 'call FloatingFZF()',
      \  'sink':    'e',
      \  'source':  'git ls-files'})

let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

" Define key combinations
nmap <C-f> :FzfRg<CR>
nmap <C-p> :FZFFiles <CR>
nnoremap <silent> <Leader>ag :FzfAg <C-R><C-W><CR>
nnoremap <silent> <Leader>rg :FzfRg <C-R><C-W><CR>

" Configure the FZF statusline in Neovim
function! s:fzf_statusline()
  " Define colors for the statusline
  setlocal statusline=%#fzf1#\ \%#fzf2#\ \FIND\ \ %#fzf3#
endfunction

" Display a customized statusline when invoking fzf
" NOTE: this will not always trigger if in an augroup
autocmd! User FzfStatusLine call <SID>fzf_statusline()

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

"=====================================================
"===================== STATUSLINE ====================
let s:modes = {
      \ 'n': 'NORMAL',
      \ 'i': 'INSERT',
      \ 'R': 'REPLACE',
      \ 'v': 'VISUAL',
      \ 'V': 'V-LINE',
      \ "\<C-v>": 'V-BLOCK',
      \ 'c': 'COMMAND',
      \ 's': 'SELECT',
      \ 'S': 'S-LINE',
      \ "\<C-s>": 'S-BLOCK',
      \ 't': 'TERMINAL'
      \}

let s:prev_mode = ""
function! StatusLineMode()
  let cur_mode = get(s:modes, mode(), '')

  " do not update higlight if the mode is the same
  if cur_mode == s:prev_mode
    return cur_mode
  endif

  if cur_mode == "NORMAL"
    exe 'hi! StatusLine ctermfg=236'
    exe 'hi! myModeColor cterm=bold ctermbg=148 ctermfg=22'
  elseif cur_mode == "INSERT"
    exe 'hi! myModeColor cterm=bold ctermbg=23 ctermfg=231'
  elseif cur_mode == "VISUAL" || cur_mode == "V-LINE" || cur_mode == "V_BLOCK"
    exe 'hi! StatusLine ctermfg=236'
    exe 'hi! myModeColor cterm=bold ctermbg=208 ctermfg=88'
  endif

  let s:prev_mode = cur_mode
  return cur_mode
endfunction

function! StatusLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! StatusLinePercent()
  return (100 * line('.') / line('$')) . '%'
endfunction

function! StatusLineLeftInfo()
 let branch = fugitive#head()
 let filename = '' != expand('%:t') ? expand('%:t') : '[No Name]'
 if branch !=# ''
   return printf("%s | %s", branch, filename)
 endif
 return filename
endfunction

exe 'hi! myInfoColor ctermbg=240 ctermfg=252'

" start building our statusline
set statusline=

" mode with custom colors
set statusline+=%#myModeColor#
set statusline+=%{StatusLineMode()}
set statusline+=%*

" left information bar (after mode)
set statusline+=%#myInfoColor#
set statusline+=\ %{StatusLineLeftInfo()}
set statusline+=\ %*

" go command status (requires vim-go)
set statusline+=%#goStatuslineColor#
set statusline+=%{go#statusline#Show()}
set statusline+=%*

" right section seperator
set statusline+=%=

" filetype, percentage, line number and column number
set statusline+=%#myInfoColor#
set statusline+=\ %{StatusLineFiletype()}\ %{StatusLinePercent()}\ %l:%v
set statusline+=\ %*

" Plugin: fatih/vim-go
let g:go_fmt_command = "goimports" " automagically get dependencies
let g:syntastic_go_checkers = ['golangci-lint', 'govet']

let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_enabled = ['vet', 'golint']

let g:go_autodetect_gopath = 1
let g:go_auto_type_info = 1 " show type information in status line

" Plugin: sebdah/vim-delve
" open Delve with a horizontal split rather than a vertical split.
let g:delve_new_command = "vnew"

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

" To use `ALT+{h,j,k,l}` to navigate windows from any mode:
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

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

" floating terminal toggle
noremap  <C-Space> :FloatermToggle<CR>i
noremap! <C-Space> <Esc>:FloatermToggle<CR>i
tnoremap <C-Space> <C-\><C-n>:FloatermToggle<CR>

let height = float2nr(&lines - (&lines * 2 / 10))
let width = float2nr(&columns - (&columns * 2 / 7))

let g:floaterm_height = height
let g:floaterm_width = width
let g:floaterm_winblend = 0
let g:floaterm_position = 'center'
