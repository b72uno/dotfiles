if &compatible
  set nocompatible
endif

set runtimepath^=~/.cache/dein/repos/github.com/Shougo/dein.vim
let g:bundle_path = '~/.cache/dein/bundle'

if dein#load_state(g:bundle_path)
  call dein#begin(g:bundle_path)

  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('davidhalter/jedi')
  call dein#add('zchee/deoplete-jedi')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable
