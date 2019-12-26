call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'voldikss/vim-floaterm' " floating terminal toggle
Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit' " additional git tools. cycle staged changes
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'                " linting
Plug 'sebdah/vim-delve'        " debugger
Plug 'kshenoy/vim-signature'   " display marks in sidebar
Plug 'itchyny/lightline.vim'   " light, configurable statusline
Plug 'daviesjamie/vim-base16-lightline'
Plug 'edkolev/tmuxline.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
Plug 'mhinz/vim-startify' " startup screen
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets' " Default snippets for many languages
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'rhysd/git-messenger.vim'
Plug 'christianrondeau/vim-base64'
Plug 'junegunn/limelight.vim' " plugin to focus / greyout other blocks
Plug 'junegunn/goyo.vim'

" colorscheme
Plug 'mccurdyc/base16-vim'

call plug#end()

"----------------------------------------------
" general settings
"----------------------------------------------
" https://mokagio.github.io/tech-journal/2015/02/12/vim-copy-and-paste-multiple-times.html
" be able to paste more than once
xnoremap p pgvy

" Display screen redraws faster
set nocursorcolumn
set nocursorline
set ttyfast

set clipboard=unnamedplus      " copy and paste to system clipboard
set smarttab                   " indents instead of tabs at the beginning of a line
set autoread
au CursorHold * checktime
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
au Filetype go set nolist

" Allow vim to set a custom font or color for a word
syntax enable
syntax manual
au Filetype * setlocal syntax=ON
autocmd Filetype * if getfsize(@%) > 1000000 | setlocal syntax=OFF | endif

let maplocalleader = ","
let mapleader = ","

" clear search highlights
no <silent><Leader>cs :nohls<CR>

" map kj to escape key
inoremap kj <Esc>

" temporarily zoom split
nnoremap <silent> <C-w>w :ZoomWin<CR>

" turn spell check on for markdown and tex files
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.tex setlocal spell

set nohlsearch

" open urls correctly in Brave
let g:netrw_browsex_viewer= "xdg-open"

" Plugin: https://github.com/junegunn/limelight.vim
" plugin for focusing and greying-out background
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.8

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 0

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

" Plugin: https://github.com/junegunn/goyo.vim
let g:goyo_width = 120

" Plugin: https://github.com/airblade/vim-gitgutter
" remove background from git gutter
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'

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

" Plugin: junegunn/fzf
let g:fzf_command_prefix = 'Fzf'

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
      \  'sink':    'e',
      \  'source':  'rg --hidden --files -l -g "!.git"'})

" Load files in Git
command! FZFGit call fzf#run({
      \  'window': 'call FloatingFZF()',
      \  'sink':    'e',
      \  'source':  'git ls-files'})

let $FZF_DEFAULT_OPTS='--layout=reverse'

" Define key combinations
nmap <C-f> :FzfRg<CR>
nmap <C-p> :FZFFiles <CR>

let g:fzf_layout = { 'window': 'call FloatingFZF()' } " otherwise built-in FZF commands wont float

nnoremap <silent> <Leader>ag :FzfAg <C-R><C-W><CR>
nnoremap <silent> <Leader>rg :FzfRg <C-R><C-W><CR>

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Plugin: https://github.com/edkolev/tmuxline.vim
let g:tmuxline_powerline_separators = 0

" Plugin: https://github.com/itchyny/lightline.vim
" Dependency: tpope/vim-fugitive (for branch info)
let g:lightline = {
      \ 'colorscheme': 'base16',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch'],
	    \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status'
      \ },
  \ }

" Do not display the standard status line
set noshowmode

" Plugin: https://github.com/neoclide/coc-snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Make <tab> used for trigger completion, completion confirm, snippet expand and jump like VSCode.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Pluin: https://github.com/jiangmiao/auto-pairs

" Plugin: https://github.com/fatih/vim-go
" https://github.com/fatih/vim-go/blob/master/doc/vim-go.txt
let g:go_fmt_command = "goimports" " automagically get dependencies
let g:syntastic_go_checkers = ['golangci-lint', 'govet']
let g:go_snippet_engine = "neosnippet"

let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_enabled = ['vet', 'golint']

let g:go_autodetect_gopath = 1

" let lsp handle these
let g:go_auto_type_info = 0 " show type information in status line
let g:go_def_mapping_enabled = 0 " go-to-definition
let g:go_code_completion_enabled = 0 " completion
let g:go_doc_keywordprg_enabled = 0 " 'K' go doc buffer
let g:go_echo_go_info = 0 " show identifier information in statusline
let g:go_fmt_fail_silently = 0 " disable quickfix/locationlist windows for linter errors
let g:go_list_type = "quickfix"
let g:go_test_show_name = 1
let g:go_list_autoclose = 0

" https://github.com/neoclide/coc.nvim/issues/472#issuecomment-475848284
" fixing editor highlighting
let g:go_template_autocreate = 0 " disable the templated main.go
let g:go_decls_mode = 'fzf'
let g:go_fmt_options = {
  \ 'gofmt': '-s',
  \ }

" wrap long lines in quickfix - https://github.com/fatih/vim-go/issues/1271
augroup quickfix
    autocmd!
    autocmd FileType qf setlocal wrap
augroup END

au FileType go nmap <leader>gta <Plug>(go-alternate-vertical)
au FileType go nmap <leader>gtt <Plug>(go-test)
au FileType go nmap <leader>gtf :GoTestFunc!<cr>
au FileType go nmap <leader>gtc <Plug>(go-coverage-toggle)
au FileType go nmap <leader>gcb <Plug>(go-cover-browser)

let g:go_term_enabled = 1
let g:go_term_height = 20
let g:go_term_mode = "split"

au FileType go nmap <leader>gg <Plug>(go-doc)
au FileType go nmap <leader>gv <Plug>(go-doc-vertical)

" Plugin: https://github.com/sebdah/vim-delve
" open Delve with a horizontal split rather than a vertical split.
let g:delve_new_command = "vnew"

" Plugin: https://github.com/voldikss/vim-floaterm
" floating terminal toggle
noremap  <C-Space> :FloatermToggle<CR>
noremap! <C-Space> <Esc>:FloatermToggle<CR>
tnoremap <C-Space> <C-\><C-n>:FloatermToggle<CR>

let height = float2nr(&lines - (&lines * 2 / 10))
let width = float2nr(&columns - (&columns * 2 / 7))

let g:floaterm_height = height
let g:floaterm_width = width
let g:floaterm_winblend = 0
let g:floaterm_position = 'center'

" Plugin: https://github.com/lervag/vimtexhttps://github.com/lervag/vimtex
let g:vimtex_fold_enabled = 0
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_index_show_help = 0
let g:vimtex_view_method = 'mupdf'
let g:vimtex_view_mupdf_options = '-r 250'
let g:vimtex_compiler_progname = 'nvr'

" Plugin: https://github.com/neoclide/coc.nvim
" Better display for messages
set cmdheight=2
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

nmap <silent> <C-c> <Plug>(coc-cursors-position)
nmap <silent> <C-r> <Plug>(coc-refactor)
nmap <silent> <C-d> <Plug>(coc-cursors-word)
xmap <silent> <C-d> <Plug>(coc-cursors-range)

" show signature help on param hover
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

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
nmap <silent> gt <Plug>(coc-type-definition)
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
" https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

nnoremap <C-s> :sp <CR>

" Autosave buffers before leaving them
autocmd BufLeave * silent! :wa

" splitting
set splitbelow " default horizontal split below instead of above
set splitright " default vertical split right

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
let g:startify_change_to_dir = 0 " when set to true, messes up CTRL-P

let g:startify_bookmarks = [{'c': '~/.config/nvim/coc-settings.json'}, {'n': '~/dotfiles/.config/nvim/init.vim'},{'t': '~/.tmux.conf'}, {'z': '~/.zshrc'}]
let g:startify_files_number = 3

function! s:list_commits()
    let git = 'git -C $(pwd)'
    let commits = systemlist(git .' log --oneline | head -n10')
    let git = 'G'. git[1:]
    return map(commits, '{"line": matchstr(v:val, ".*")}')
endfunction

function! s:tree()
    let tree = 'tree'
    let out = systemlist(tree)
    return map(out, '{"line": matchstr(v:val, ".*")}')
endfunction

let g:startify_lists = [
      \ { 'header': ['   MRU '. getcwd()], 'type': 'dir' },
      \ { 'header': ['   Tree'],           'type': function('s:tree') },
      \ { 'header': ['   Commits'],        'type': function('s:list_commits') },
      \ { 'header': ['   Bookmarks'],      'type': 'bookmarks' },
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

"----------------------------------------------
" color settings
"----------------------------------------------
set termguicolors
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-eighties
autocmd FileType go colorscheme base16-eighties-minimal

highlight link ALEWarningSign String
highlight link ALEErrorSign WarningMsg
highlight link ALEStyleError error
highlight link ALEStyleWarning error
highlight link ALEError error
highlight link AleWarning error

set rtp +=~/.vim " necessary to reload .vim dir with autoload functions
nnoremap <leader>vimrc :call reloadvimrc#Run()<cr>
