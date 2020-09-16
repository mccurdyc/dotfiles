call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'terryma/vim-multiple-cursors'
Plug 'airblade/vim-rooter'
Plug 'voldikss/vim-floaterm' " floating terminal toggle
Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit' " additional git tools. cycle staged changes
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'      " linting and general interation with language servers
Plug 'sebdah/vim-delve'        " debugger
Plug 'kshenoy/vim-signature'   " display marks in sidebar
Plug 'itchyny/lightline.vim'   " light, configurable statusline
Plug 'daviesjamie/vim-base16-lightline'
Plug 'edkolev/tmuxline.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }
Plug 'rust-lang/rust.vim'
Plug 'neovim/nvim-lspconfig' " required nvim 0.5 HEAD
Plug 'mhinz/vim-startify' " startup screen
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'rhysd/git-messenger.vim'
" Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets' " Default snippets for many languages
" Plug 'ludovicchabant/vim-gutentags' " broke: https://github.com/ludovicchabant/vim-gutentags/issues/283
" Plug 'junegunn/limelight.vim' " plugin to focus / greyout other blocks
" Plug 'junegunn/goyo.vim'
Plug 'vim-scripts/colorizer' " highlight hex colors

" colorscheme
Plug 'mccurdyc/base16-vim'

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

" Permanent undo (even after closing vim)
set undodir=~/.config/nvim/.undodir
set undofile

" Display problematic whitespace
set listchars=tab:➜\ ,trail:•,extends:#,precedes:#,nbsp:⌻
set list
" Go uses tabs, so disable the highlighting for Go
au Filetype go set nolist

" https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
" set working directory to the current file
autocmd BufEnter * silent! lcd %:p:h

" Allow vim to set a custom font or color for a word
syntax enable
syntax manual
au Filetype * setlocal syntax=ON
autocmd Filetype * if getfsize(@%) > 1000000 | setlocal syntax=OFF | endif

set rtp +=~/.vim " necessary to reload .vim dir with autoload functions
nnoremap <leader>vimrc :call reloadvimrc#Run()<cr>

" augroup quickfix
"     autocmd!
"     " wrap long lines in quickfix - https://github.com/fatih/vim-go/issues/1271
"     autocmd FileType qf setlocal wrap
" augroup END

" Autoclose quickfix/location list when leaving a file
" https://stackoverflow.com/questions/7476126/how-to-automatically-close-the-quick-fix-window-when-leaving-a-file
" au FileType qf call CloseIfBufferIsEmpty()
" function! CloseIfBufferIsEmpty()
"   if getline(1) == '' |q|endif
" endfunction

aug ListClose
  au!
  au WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
  au WinEnter * if winnr('$') == 1 && (&buftype == "quickfix" || &buftype == "locationlist") | lclose | endif
aug END

au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
    let l = 1
    let n_lines = 0
    let w_width = winwidth(0)
    while l <= line('$')
        " number to float for division
        let l_len = strlen(getline(l)) + 0.0
        let line_width = l_len/w_width
        let n_lines += float2nr(ceil(line_width))
        let l += 1
    endw
    exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
endfunction
" https://gist.github.com/juanpabloaj/5845848

" General Keybindings
let maplocalleader = ","
let mapleader = ","

" Navigate quickfix list with ease
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>

" Navigation
" https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally
set splitbelow " default horizontal split below instead of above
set splitright " default vertical split right

nnoremap <C-s> :sp <CR>
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

" replace visual selection globally, confirm.
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" https://mokagio.github.io/tech-journal/2015/02/12/vim-copy-and-paste-multiple-times.html
" be able to paste more than once
xnoremap p pgvy

" clear search highlights
no <silent><Leader>cs :nohls<CR>

" map kj to escape key only in insert mode.
" I had it also in command and visual but caused delays and unexpected escape
" calls.
inoremap kj <Esc>
nnoremap dg :q!<CR>

" turn spell check on for markdown and tex files
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.tex setlocal spell

set nohlsearch

let g:python3_host_prog = '/usr/bin/python'
" disable python2
let g:loaded_python_provider = 0

" open urls correctly in Brave
let g:netrw_browsex_viewer= "xdg-open"

" Plugin:https://github.com/jreybert/vimagit
" enable deletion of untracked files
let g:magit_discard_untracked_do_delete = 1

" Plugin: https://github.com/rhysd/git-messenger.vim
let g:git_messenger_include_diff = "current"
let g:git_messenger_close_on_cursor_moved = v:false
let g:git_messenger_always_into_popup = v:true
let g:git_messenger_max_popup_height = 20
let g:git_messenger_max_popup_width = 80

function! GitMessengerPopup() abort
    " For example, set go back/forward history to <C-o>/<C-i>
    nmap <buffer><C-o> o
    nmap <buffer><C-i> O
endfunction
autocmd FileType gitmessengerpopup call GitMessengerPopup()

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

" Plugin: https://github.com/junegunn/fzf.vim
let g:fzf_command_prefix = 'Fzf'

" https://github.com/Blacksuan19/init.nvim/blob/master/init.vim
let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

" Always enable preview window on the right with 50% width
let g:fzf_preview_window = 'right:50%'

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

let $FZF_DEFAULT_OPTS='--layout=reverse'

" use rg by default
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
endif

" A nicer FzfFiles preview
" docs - https://github.com/junegunn/fzf.vim#example-customizing-files-command
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" advanced grep(faster with preview)
" docs - https://github.com/junegunn/fzf.vim#example-advanced-ripgrep-integration
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --no-ignore --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

" floating fzf window with borders
function! CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" docs - https://github.com/junegunn/fzf.vim#command-local-options
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" Define key combinations
nmap <leader>f :Rg<CR>
nmap <C-p> :FzfFiles<CR>
nmap <leader>gs :FzfGFiles?<CR>

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
" imap <C-l> <Plug>(coc-snippets-expand)
"
" " Use <C-j> for select text for visual placeholder of snippet.
" vmap <C-j> <Plug>(coc-snippets-select)
"
" " Use <C-j> for jump to next placeholder, it's default of coc.nvim
" let g:coc_snippet_next = '<c-j>'
"
" " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
" let g:coc_snippet_prev = '<c-k>'
"
" " Use <C-j> for both expand and jump (make expand higher priority.)
" imap <C-j> <Plug>(coc-snippets-expand-jump)
"
" " Make <tab> used for trigger completion, completion confirm, snippet expand and jump like VSCode.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? coc#_select_confirm() :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
"
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
"
" let g:coc_snippet_next = '<tab>'

" Plugin: https://github.com/fatih/vim-go
" https://github.com/fatih/vim-go/blob/master/doc/vim-go.txt
let g:go_fmt_command = "goimports" " automagically get dependencies
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

augroup quickfix
    autocmd!
    " wrap long lines in quickfix - https://github.com/fatih/vim-go/issues/1271
    autocmd FileType qf setlocal wrap
augroup END

" Navigate quickfix list with ease
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>

" For Go, don't use ctags, use Vim Go's implementation.
au FileType go nmap <C-]> <Plug>(go-def)
au FileType go nmap <C-t> <Plug>(go-def-pop)

au FileType go nmap <leader>gta <Plug>(go-alternate-split)
au FileType go nmap <leader>gtt <Plug>(go-test)
au FileType go nmap <leader>gtf :GoTestFunc!<cr>
au FileType go nmap <leader>gtc <Plug>(go-coverage-toggle)
au FileType go nmap <leader>gcb <Plug>(go-cover-browser)
" List functions in current file.
au FileType go nmap <leader>lf :g/^func /#<CR>

let g:go_term_enabled = 1
let g:go_term_height = 20
let g:go_term_mode = "split"

au FileType go nmap <leader>gg <Plug>(go-doc)
au FileType go nmap <leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <leader>gdb <Plug>(go-doc-browser)

" Plugin: https://github.com/sebdah/vim-delve
" open Delve with a horizontal split rather than a vertical split.
let g:delve_new_command = "new"
nmap <leader>dc :DlvConnect $DLV_SERVER_HOST<CR>
nmap <leader>ca :DlvClearAll <CR>
nmap <leader>dt :DlvToggleBreakpoint <CR>

" Plugin: https://github.com/voldikss/vim-floaterm
" floating terminal toggle
nmap <leader>tt :FloatermToggle<CR>
noremap! <leader>tt <Esc>:FloatermToggle<CR>
tnoremap <leader>tt <C-\><C-n>:FloatermToggle<CR>

let g:floaterm_autoclose = 2 " always close after job
let g:floaterm_wintype = 'floating'
let g:floaterm_height = 0.9
let g:floaterm_width = 0.9
let g:floaterm_winblend = 0
let g:floaterm_position = 'center'
let g:floaterm_open_command = 'split'

command! Ranger FloatermNew! ranger
command! Vifm FloatermNew! vifm
command! FZF FloatermNew! fzf
command! -nargs=1 Zkt FloatermNew! zkt <f-args>

let g:floaterm_borderchars = ['─', '│', '─', '│', '╭', '╮', '╯', '╰']

" Plugin: https://github.com/lervag/vimtexhttps://github.com/lervag/vimtex
let g:vimtex_fold_enabled = 0
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_index_show_help = 0
let g:vimtex_view_method = 'mupdf'
let g:vimtex_view_mupdf_options = '-r 250'
let g:vimtex_compiler_progname = 'nvr'

" Plugin: https://github.com/neovim/nvim-lspconfig
" Resource(s)
" * https://teukka.tech/luanvim.html
lua << EOF
local nvim_lsp = require 'nvim_lsp'

nvim_lsp.gopls.setup({
  root_dir = nvim_lsp.util.root_pattern('.git');
})
nvim_lsp.rls.setup({})
nvim_lsp.rust_analyzer.setup({})
nvim_lsp.terraformls.setup({})
nvim_lsp.pyls.setup({})
nvim_lsp.bashls.setup({})

nvim_lsp.yamlls.setup({})
nvim_lsp.jsonls.setup({})
EOF

" Plugin: https://github.com/dense-analysis/ale
" Resource(s)
" * https://www.vimfromscratch.com/articles/vim-and-language-server-protocol/
" Colors handled by colorscheme
highlight link ALEWarningSign String
highlight link ALEErrorSign WarningMsg
highlight link ALEStyleError error
highlight link ALEStyleWarning error
highlight link ALEError error
highlight link AleWarning error

set omnifunc=ale#completion#OmniFunc
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1

" Use quickfix instead of loclist
" https://github.com/dense-analysis/ale#5xiii-how-can-i-use-the-quickfix-list-instead-of-the-loclist
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

nmap K :ALEHover<CR>
nmap gr :ALEFindReferences<CR>
nmap gd :ALEGoToDefinition<CR>

set signcolumn=yes " always show signcolumns
let g:ale_sign_column_always = 1 " always keep sign gutter open to avoid jumpiness

" moving between warnings and errors quickly.
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Show 5 lines of errors (default: 10)
let g:ale_list_window_size = 10

" Error and warning signs.
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '▸'

" Only lint on save
" https://github.com/dense-analysis/ale#5xii-how-can-i-run-linters-only-when-i-save-files
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 1
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 1
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'go': ['gofmt'],
\   'terraform': ['terraform fmt'],
\}

let g:ale_linters = {
\ 'go': ['gopls', 'gofmt'],
\ 'rust': ['rustc'],
\ 'terraform': ['tflint'],
\ }

let b:ale_fix_on_save = 1

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
    let tree = 'tree -d 3 -I "vendor" .'
    let out = systemlist(tree)
    return map(out, '{"line": matchstr(v:val, ".*")}')
endfunction

let g:startify_lists = [
      \ { 'header': ['   MRU '. getcwd()], 'type': 'dir' },
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
colorscheme base16-eighties-minimal
" autocmd FileType go colorscheme base16-eighties-minimal

" DEAD
" Plugin: https://github.com/neoclide/coc.nvim
" set cmdheight=2 " Better display for messages
" set shortmess+=c " don't give |ins-completion-menu| messages.

" nmap <leader>rf <Plug>(coc-refactor)
" nmap <leader>cp <Plug>(coc-cursors-position)
" " Multi-cursor
" xmap <leader>cr <Plug>(coc-cursors-range)
" nmap <leader>cw <Plug>(coc-cursors-word)
"
" " show signature help on param hover
" autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"
" " Use tab for trigger completion with characters ahead and navigate.
" " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
"
" " Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()
"
" " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" " Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" " Or use `complete_info` if your vim support it, like:
" " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"
" " Use `[g` and `]g` to navigate diagnostics
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
" " Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gt <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
"
" " Use K to show documentation in preview window
" nnoremap <silent> K :call <SID>show_documentation()<CR>
"
" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction
"
" " Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')
"
" " Remap for rename current word
" nmap <leader>rn <Plug>(coc-rename)
"
" " Fix autofix problem of current line
" nmap <leader>qf  <Plug>(coc-fix-current)
"
" " Add status line support, for integration with other plugin, checkout `:h coc-status`
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"
" " Using CocList
" " Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
