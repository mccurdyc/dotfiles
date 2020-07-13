" " vim:sw=2:
" " ============================================================================
" " FileName: zkt.vim
" " Documentation: https://github.com/voldikss/vim-floaterm#how-to-define-more-wrappers
" $ ln -snf ./zkt.vim $HOME/.vim/plugged/vim-floaterm/autoload/floaterm/wrapper/zkt.vim
" " ============================================================================
function! floaterm#wrapper#zkt#(cmd) abort
  let s:zkt_tmpfile = tempname()
  let cmdlist = split(a:cmd)
  let cmd = 'zkt'

  " zkt arguments
  if len(cmdlist) > 1
    let cmd .= ' ' . join(cmdlist[1:], ' ')
  endif

  " the exit force floaterm to close after fzf
  return [cmd . ' | fzf && exit', {}, v:true]
  " The following doesn't work because zoekt doesn't output the line number.
  " It is like a tag line number or index or something.
  " zoekt "hello r:fst_app_timespiral" | fzf | awk -F ":" '{ system("nvim +" $2 "~/src/" $1) }'
endfunction
