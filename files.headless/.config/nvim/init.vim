lua require('init')

"----------------------------------------------
" General Settings
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
set listchars=tab:⇨\ ,trail:•,extends:#,precedes:#,nbsp:⌻
set list
" Go uses tabs, so disable the highlighting for Go
au Filetype go set nolist

" Allow vim to set a custom font or color for a word
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

" Navigation
" https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally
set splitbelow " default horizontal split below instead of above
set splitright " default vertical split right

" Autosave buffers before leaving them
autocmd BufLeave * silent! :wa

set nohlsearch

let g:python3_host_prog = '/usr/bin/python'
" disable python2
let g:loaded_python_provider = 0

" open urls correctly in Brave
let g:netrw_browsex_viewer= "xdg-open"

" Plugin:https://github.com/jreybert/vimagit
" enable deletion of untracked files
let g:magit_discard_untracked_do_delete = 1

" Do not display the standard status line
set noshowmode

" Plugin: https://github.com/fatih/vim-go
" https://github.com/fatih/vim-go/blob/master/doc/vim-go.txt
" No gofmt on save. We use ALE.
" gofmt on save handles arbitrary flags passed to gofmt, unlike lspconfig.
let g:go_fmt_autosave = 0
let g:go_autodetect_gopath = 1

" Disable vim-go snippets
let g:go_snippet_engine = ""

" let lspconfig handle these
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

let g:go_term_enabled = 1
let g:go_term_height = 20
let g:go_term_mode = "split"

" Plugin: https://github.com/sebdah/vim-delve
" open Delve with a horizontal split rather than a vertical split.
let g:delve_new_command = "new"


" Plugin: https://github.com/nvim-lua/diagnostic-nvim
let g:diagnostic_enable_virtual_text = 0 " disable in-line diagnostics
let g:diagnostic_virtual_text_prefix = '■'
let g:diagnostic_trimmed_virtual_text = '30'
let g:space_before_virtual_text = 10
let g:diagnostic_show_sign = 1
let g:diagnostic_enable_underline = 0
let g:diagnostic_auto_popup_while_jump = 0
let g:diagnostic_insert_delay = 1

call sign_define("LspDiagnosticsErrorSign", {"text" : "✗", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "▸", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsInformationSign", {"text" : "I", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsHintSign", {"text" : "H", "texthl" : "LspDiagnosticsHint"})

" Plugin: https://github.com/nvim-lua/completion-nvim
" autocmd BufEnter * if &ft != "md" | lua require'completion'.on_attach()

let g:completion_enable_auto_popup = 1

" http://vimdoc.sourceforge.net/htmldoc/options.html#'complete'
" https://vimhelp.org/insert.txt.html#ins-completion
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

let g:completion_confirm_key = ""
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Remove snippets b/c it uses the wrong snippets use FzfSnippets instead.
let g:completion_chain_complete_list = {
\ 'default': [
\   {'complete_items': ['lsp', 'snippet', 'path']},
\   {'mode': '<c-p>'},
\   {'mode': '<c-n>'}
\]
\}

let g:completion_enable_snippet = 'UltiSnips'
let g:completion_enable_auto_hover = 0 " don't print hover details because it doesn't look good.
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
let g:completion_matching_ignore_case = 1
let g:completion_enable_auto_signature = 1
let g:completion_enable_auto_paren = 1

" Colors handled by colorscheme
highlight link ALEWarningSign String
highlight link ALEErrorSign WarningMsg
highlight link ALEStyleError error
highlight link ALEStyleWarning error
highlight link ALEError error
highlight link AleWarning error

let g:ale_echo_msg_format = '[%linter%] [%severity%] %s'
let g:ale_echo_msg_error_str = 'ERR'
let g:ale_echo_msg_info_str = 'INFO'
let g:ale_echo_msg_warning_str = 'WARN'

set omnifunc=ale#completion#OmniFunc
let g:ale_completion_enabled = 0 " let lspconfig do this
let g:ale_completion_autoimport = 1

" Use quickfix instead of loclist
" https://github.com/dense-analysis/ale#5xiii-how-can-i-use-the-quickfix-list-instead-of-the-loclist
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

set signcolumn=yes " always show signcolumns
let g:ale_sign_column_always = 1 " always keep sign gutter open to avoid jumpiness

" Show X lines of errors (default: 10)
let g:ale_list_window_size = 10

" Error and warning signs.
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '▸'

" Only lint on save
" https://github.com/dense-analysis/ale#5xii-how-can-i-run-linters-only-when-i-save-files
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0
let g:ale_open_list = 1 " open list at bottom with errors
let g:ale_keep_list_window_open = 0 " close list windows when there aren't errors

" ALE supported tools - https://github.com/dense-analysis/ale/blob/master/supported-tools.md
" :ALEInfo
let g:ale_linters = {
\ 'go': ['gopls', 'staticcheck', 'gosimple'],
\ 'rust': ['rustc', 'analyzer'],
\ 'terraform': ['terraform', 'terraform_lsp', 'tflint'],
\ 'json': ['jsonlint'],
\ }

let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'go': ['gofmt', 'goimports'],
\ 'rust': ['rustfmt'],
\ 'terraform': ['terraform'],
\ 'json': ['jq'],
\}

let g:ale_rust_cargo_check_all_targets = 1

let g:ale_terraform_langserver_executable = 'terraform-lsp'
let g:ale_terraform_langserver_options = ''
let g:ale_terraform_terraform_executable = 'terraform'
let g:ale_terraform_tflint_executable = 'tflint'
let g:ale_terraform_tflint_options = ''

let g:ale_go_staticcheck_lint_package = 1
let g:ale_go_staticcheck_options = ''

" Plugin: https://github.com/sirver/UltiSnips
" Reference: https://github.com/SirVer/ultisnips/blob/master/doc/UltiSnips.txt
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

" Don't set this to <CR> or you won't be able to hit ENTER in Vim.
let g:UltiSnipsExpandTrigger="<C-l>"

" Snippets path
let g:UltiSnipsSnippetDirectories=[$HOME.'/dotfiles/vim-snippets/UltiSnips']

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="horizontal"

" Plugin: https://github.com/ruanyl/vim-gh-line
let g:gh_line_map_default = 0
let g:gh_line_blame_map_default = 0
let g:gh_line_map = '<leader>gh'
let g:gh_line_blame_map = '<leader>gb'
let g:gh_open_command = 'xdg-open '

" Plugin: https://github.com/airblade/vim-rooter
let g:rooter_patterns = ['.git', 'Makefile']
let g:rooter_change_directory_for_non_project_files = ''

"----------------------------------------------
" color settings
"----------------------------------------------
" set termguicolors
set t_Co=256
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-eighties-minimal
" autocmd FileType go colorscheme base16-eighties-minimal
