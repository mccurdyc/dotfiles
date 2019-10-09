call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'voldikss/vim-floaterm' " floating terminal toggle
Plug 'tpope/vim-fugitive'
Plug 'tomtom/tcomment_vim'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'                " linting
Plug 'sebdah/vim-delve'        " debugger
Plug 'kshenoy/vim-signature'   " display marks in sidebar
Plug 'daviesjamie/vim-base16-lightline'
Plug 'itchyny/lightline.vim'   " light, configurable statusline
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
Plug 'mhinz/vim-startify' " startup screen

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
set hidden

" Display with faster timeouts in the TUI
set timeoutlen=500
set ttimeoutlen=10

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

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Plugin: https://github.com/itchyny/lightline.vim
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

if !has('gui_running')
  set t_Co=256
endif

" Do not display the standard status line
set noshowmode

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

" Plugin: https://github.com/voldikss/vim-floaterm
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

" Plugin: https://github.com/neoclide/coc.nvim
" Better display for messages
set cmdheight=2
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" setup multiple cursor support
hi CocCursorRange guibg=#b16286 guifg=#ebdbb2

nmap <silent> <C-c> <Plug>(coc-cursors-position)
nmap <silent> <C-d> <Plug>(coc-cursors-word)
xmap <silent> <C-d> <Plug>(coc-cursors-range)
" use normal command like `<leader>xi(`
nmap <leader>x  <Plug>(coc-cursors-operator)

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

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

" Plugin: https://github.com/mhinz/vim-startify
let g:startify_bookmarks = [ {'c': '~/dotfiles/.config/nvim/init.vim'}, '~/.zshrc' ]

function! s:list_commits()
    let git = 'git -C $(pwd)'
    let commits = systemlist(git .' status --oneline | head -n10')
    let git = 'G'. git[1:]
    return map(commits, '{"line": matchstr(v:val, ".*")}')
  endfunction

let g:startify_lists = [
      \ { 'header': ['   MRU'],            'type': 'files' },
      \ { 'header': ['   MRU '. getcwd()], 'type': 'dir' },
      \ { 'header': ['   Sessions'],       'type': 'sessions' },
      \ { 'header': ['   Commits'],        'type': function('s:list_commits') },
      \ ]

" http://patorjk.com/software/taag/#p=display&f=3D-ASCII&t=NeoVim
let g:startify_custom_header = [
 \'  ________   _______   ________  ___      ___ ___  _____ ______       ',
 \' |\   ___  \|\  ___ \ |\   __  \|\  \    /  /|\  \|\   _ \  _   \     ',
 \' \ \  \\ \  \ \   __/|\ \  \|\  \ \  \  /  / | \  \ \  \\\__\ \  \    ',
 \'  \ \  \\ \  \ \  \_|/_\ \  \\\  \ \  \/  / / \ \  \ \  \\|__| \  \   ',
 \'   \ \  \\ \  \ \  \_|\ \ \  \\\  \ \    / /   \ \  \ \  \    \ \  \  ',
 \'    \ \__\\ \__\ \_______\ \_______\ \__/ /     \ \__\ \__\    \ \__\ ',
 \'     \|__| \|__|\|_______|\|_______|\|__|/       \|__|\|__|     \|__| ',
 \ ]
