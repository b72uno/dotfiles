"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/clash/.local/share/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/clash/.local/share/dein')
  call dein#begin('/home/clash/.local/share/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/home/clash/.local/share/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/deol.nvim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('tsukkee/unite-tag')
  call dein#add('ujihisa/neco-look')
  call dein#add('Shougo/neco-syntax')
  call dein#add('davidhalter/jedi')
  call dein#add('zchee/deoplete-jedi')

  call dein#add('hynek/vim-python-pep8-indent')

  call dein#add('plasticboy/vim-markdown')
  call dein#add('elzr/vim-json')
  call dein#add('cespare/vim-toml')
  call dein#add('morhetz/gruvbox')
  call dein#add('terryma/vim-smooth-scroll')
  call dein#add('matze/vim-move')
  call dein#add('tpope/vim-commentary')
  call dein#add('sickill/vim-pasta')
  call dein#add('justinmk/vim-sneak')
  call dein#add('tpope/vim-unimpaired')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-speeddating')
  call dein#add('tpope/vim-surround')
  call dein#add('tmhedberg/matchit')
  call dein#add('terryma/vim-multiple-cursors')
  call dein#add('dhruvasagar/vim-table-mode')
  call dein#add('tpope/vim-fugitive')


  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" Plugin settings

" Use deoplete
 let g:deoplete#enable_at_startup = 1
 "---------------------------------------------------------------------------
" deoplete.nvim
"

" <TAB>: completion.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

inoremap <expr><C-g> deoplete#undo_completion()
" <C-l>: redraw candidates
inoremap <expr><C-l>       deoplete#refresh()

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#cancel_popup() . "\<CR>"
endfunction

inoremap <expr> '  pumvisible() ? deoplete#close_popup() : "'"

" call deoplete#custom#set('_', 'matchers', ['matcher_head'])
call deoplete#custom#set('ghc', 'sorters', ['sorter_word'])
" call deoplete#custom#set('buffer', 'mark', '')
" call deoplete#custom#set('_', 'matchers', ['matcher_full_fuzzy'])
" call deoplete#custom#set('_', 'disabled_syntaxes', ['Comment', 'String'])
" call deoplete#custom#set('buffer', 'mark', '*')

" Use auto delimiter
" call deoplete#custom#set('_', 'converters',
"       \ ['converter_auto_paren',
"       \  'converter_auto_delimiter', 'remove_overlap'])
call deoplete#custom#set('_', 'converters', [
      \ 'converter_remove_paren',
      \ 'converter_remove_overlap',
      \ 'converter_truncate_abbr',
      \ 'converter_truncate_menu',
      \ 'converter_auto_delimiter',
      \ ])

" call deoplete#custom#set('buffer', 'min_pattern_length', 9999)
call deoplete#custom#set('clang', 'input_pattern', '\.\w*|\.->\w*|\w+::\w*')
call deoplete#custom#set('clang', 'max_pattern_length', -1)

let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns._ = '[a-zA-Z_]\k*\(?'
" let g:deoplete#keyword_patterns.tex = '\\?[a-zA-Z_]\w*'
let g:deoplete#keyword_patterns.tex = '[^\w|\s][a-zA-Z_]\w*'

let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.python = ''
let g:deoplete#omni#functions = {}

" inoremap <silent><expr> <C-t> deoplete#manual_complete('file')

" let g:deoplete#enable_refresh_always = 1
let g:deoplete#enable_camel_case = 1
" let g:deoplete#auto_complete_delay = 50
" let g:deoplete#auto_complete_start_length = 3

let g:deoplete#skip_chars = ['(', ')']

" let g:deoplete#enable_profile = 1
" call deoplete#enable_logging('DEBUG', 'deoplete.log')
" call deoplete#custom#set('clang', 'debug_enabled', 1)

" Unite
if executable('ag')
  let g:unite_source_rec_async_command =
    \ ['ag', '--nocolor', '--nogroup',
    \  '--depth', '10', '-g', '']
  " ag is quite fast, so we increase this number
  let g:unite_source_rec_min_cache_files = 1200
endif

" Denite
nnoremap <leader>y :<C-u>Denite history/yank<CR>
nnoremap <leader>l :<C-u>Denite -start-insert -auto-resize line<CR>
nnoremap <leader>R :<C-u>Denite register<CR>
nnoremap <leader>b :<C-u>Denite -start-insert -auto-resize buffer<CR>
nnoremap <leader>o :<C-u>Denite -auto-resize outline<CR>
nnoremap <leader>f :<C-u>Denite -start-insert -auto-resize file_rec/git<CR>
nnoremap <leader>e :<C-u>DeniteBufferDir -start-insert -auto-resize file<CR>

" Change mappings.
	call denite#custom#map(
	      \ 'insert',
	      \ '<C-j>',
	      \ '<denite:move_to_next_line>',
	      \ 'noremap'
	      \)
	call denite#custom#map(
	      \ 'insert',
	      \ '<C-k>',
	      \ '<denite:move_to_previous_line>',
	      \ 'noremap'
	      \)

" Gruvbox
colorscheme gruvbox
let g_gruvbox_italic = 1
set background=dark " Setting dark mode

" Smooth scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>


" functions 
  function! Preserve(command) 
    " preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    execute a:command
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
  endfunction 
  function! StripTrailingWhitespace() 
    call Preserve("%s/\\s\\+$//e")
  endfunction 
  function! CloseWindowOrKillBuffer() 
    let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))

    if number_of_windows_to_this_buffer > 1
      wincmd c
    else
      bdelete
    endif
  endfunction 

" base configuration ----------------

  let mapleader = ","
  let g:mapleader = ","

  set timeoutlen=300                                  "mapping timeout
  set ttimeoutlen=50                                  "keycode timeout
  " Make the 'cw' and like commands put a $ at the end instead of just deleting the text and replacing it
  set cpoptions+=ces$
  set history=1000                                    "number of command lines to remember
  set ttyfast                                         "assume fast terminal connection
  set viewoptions=folds,options,cursor,unix,slash     "unix/windows compatibility
  set encoding=utf-8                                  "set encoding for text
  if exists('$TMUX')
    set clipboard=
  else
    set clipboard=unnamed                             "sync with OS clipboard
  endif
  set hidden                                          "allow buffer switching without saving
  set autoread                                        "auto reload if file saved externally
  set fileformats+=mac                                "add mac to auto-detection of file format line endings
  set nrformats-=octal                                "always assume decimal numbers
  set showcmd
  "
  " Syntax coloring lines that are too long just slows down the world
  set synmaxcol=2048

  set noshelltemp                                     "use pipes

  " whitespace
  set backspace=indent,eol,start                      "allow backspacing everything in insert mode
  set diffopt+=iwhite                                 "add ignorance of whitespace to diff
  set autoindent                                      "automatically indent to match adjacent lines
  set virtualedit=all                                 "allow the cursor to go to invalid places
  set expandtab                                       "spaces instead of tabs
  set smarttab                                        "use shiftwidth to enter tabs
  set list                                            "highlight whitespace
  set listchars=tab:│\ ,trail:•,extends:❯,precedes:❮
  set shiftround
  set linebreak
  let &showbreak='↪ '

  set scrolloff=1                                     "always show content after scroll
  set scrolljump=5                                    "minimum number of lines to scroll
  set display+=lastline
  set wildmenu                                        "show list for autocomplete
  set wildmode=list:full
  set wildignorecase
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
  set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
  set wildignore+=*.o,*.obj,*.pyc,*.pyo,*.pyd,*.class,*.lock
  set wildignore+=*.png,*.gif,*.jpg,*.ico

  set splitbelow
  set splitright

  " searching
  set hlsearch                                        "highlight searches
  set incsearch                                       "incremental searching
  set ignorecase                                      "ignore case for searching
  set smartcase                                       "do case-sensitive if there's a capital letter
  set wrapscan                                        "set the search scan to wrap lines

  if executable('ack')
    set grepprg=ack\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow\ $*
    set grepformat=%f:%l:%c:%m
  endif

" ui configuration 
  set termguicolors
  set showmatch                                       "automatically highlight matching braces/brackets/etc.
  noremap % v%
  set matchpairs=(:),{:},[:] " List of characters we expect in balanced pairs
  set matchtime=2                                     "tens of a second to show matching parentheses
  set number
  set ch=2                                            "make command line 2 lines high
  set lazyredraw
  set laststatus=2
  set noshowmode
  set foldenable                                      "enable folds by default
  set foldmethod=syntax                               "fold via syntax of files
  set foldlevelstart=99                               "open all folds by default
  " These commands open folds
  set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo
  let g:xml_syntax_folding=1                          "enable xml folding

" mappings 
  " formatting shortcuts
  nmap <leader>fef :call Preserve("normal gg=G")<CR>
  nmap <leader>f$ :call StripTrailingWhitespace()<CR>
  vmap <leader>s :sort<cr>

  nnoremap <leader>w :w<cr>

  " Toggle paste mode
  nmap <silent> <leader>p :set invpaste<CR>:set paste?<CR>

  " Set text wrapping toggles
  nmap <silent> <Leader>tw :set invwrap<CR>:set wrap?<CR>

  " remap arrow keys
  nnoremap <left> :bprev<CR>
  nnoremap <right> :bnext<CR>
  nnoremap <up> :tabnext<CR>
  nnoremap <down> :tabprev<CR>

  " smash escape
  inoremap jk <esc>
  inoremap kj <esc>

  " yank the buffer to system register
  nmap <leader>ya :%y+<CR>


  " sane regex 
    nnoremap / /\v
    vnoremap / /\v
    nnoremap ? ?\v
    vnoremap ? ?\v
    nnoremap :s/ :s/\v
  " 

  " command-line window 
    nnoremap q: q:i
    nnoremap q/ q/i
    nnoremap q? q?i
  " 

  " folds 
    nnoremap zr zr:echo &foldlevel<cr>
    nnoremap zm zm:echo &foldlevel<cr>
    nnoremap zR zR:echo &foldlevel<cr>
    nnoremap zM zM:echo &foldlevel<cr>
  " 

  " screen line scroll
    nnoremap <silent> j gj
    nnoremap <silent> k gk

  " auto center 
    nnoremap <silent> n nzz
    nnoremap <silent> N Nzz
    nnoremap <silent> * *zz
    nnoremap <silent> # #zz
    nnoremap <silent> g* g*zz
    nnoremap <silent> g# g#zz
    nnoremap <silent> <C-o> <C-o>zz
    nnoremap <silent> <C-i> <C-i>zz
  

  " reselect visual block after indent
  vnoremap < <gv
  vnoremap > >gv

  " reselect last paste
  nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

  " find current word in quickfix
  nnoremap <leader>fw :execute "vimgrep ".expand("<cword>")." %"<cr>:copen<cr>
  " find last search in quickfix
  nnoremap <leader>ff :execute 'vimgrep /'.@/.'/g %'<cr>:copen<cr>

  " CD to the directory containing the file in the buffer 
  nmap <silent> <leader>cd :lcd %:h<CR>:pwd<CR>
  nmap <silent> <leader>md :!mkdir -p %:p:h<CR>
  " 

  " run the command that was just yanked
  nmap <silent> <leader>rc :@"<cr>

  " shortcuts for windows 
  nnoremap <leader>v <C-w>v<C-w>l
  nnoremap <leader>s <C-w>s
  nnoremap <leader>vsa :vert sba<cr>
  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l
  noremap <silent> <leader>cc :close<CR>
  noremap <silent> <leader>cw :cclose<CR>
  nnoremap <silent> <leader>ml <C-W>L
  nnoremap <silent> <leader>mk <C-W>K
  nnoremap <silent> <leader>mh <C-W>H
  nnoremap <silent> <leader>mj <C-W>J
  
  " tab shortcuts
  map <leader>tn :tabnew<CR>
  map <leader>tc :tabclose<CR>
  map <silent> <leader>tm :tabm
  map <silent> <leader>ts :tab split<CR>

  " toggle scrollbind
  nmap <F6> :windo set scrollbind! diff! diffopt=iwhite scrollbind? diff?<cr>

  " make Y consistent with C and D. See :help Y.
  nnoremap Y y$

  " hide annoying quit message
  nnoremap <C-c> <C-c>:echo<cr>

  " window killer
  nnoremap <silent> Q :call CloseWindowOrKillBuffer()<cr>

  " quick buffer open
  nnoremap gb :ls<cr>:e #

  " edit/source vimrc 
  nmap <silent> <leader>ev :e $MYVIMRC<CR>
  nmap <silent> <leader>sv :so $MYVIMRC<CR>
  " 

  " underline the current line with '='
  nmap <silent> <leader>ul :t.\|s/./=/g\|set nohls<cr>

  " general
  nmap <leader>li :set list! list?<cr>
  
  " toggle highlighting search results
  nnoremap <BS> :set hlsearch! hlsearch?<cr>


" autocmd 
  " go back to previous position of cursor if any
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \  exe 'normal! g`"zvzz' |
    \ endif

  autocmd FileType js,scss,css,python,coffee autocmd BufWritePre <buffer> call StripTrailingWhitespace()
  autocmd FileType css,scss setlocal foldmethod=marker foldmarker={,}
  autocmd FileType css,scss,python nnoremap <silent> <leader>S vi{:sort<CR>
  autocmd FileType python setlocal foldmethod=indent
  autocmd FileType markdown setlocal nolist
  autocmd FileType vim setlocal fdm=indent keywordprg=:help
  
  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  
  " Customisations based on house-style (arbitrary)
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType htmldjango setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType jade setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType stylus setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript,js setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType java,c,cpp,objc setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType vim setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab

  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml

  " Binary
  augroup Binary
      au!
      au BufReadPre   *.bin let &bin=1
      au BufReadPost  *.bin if &bin | %!xxd
      au BufReadPost  *.bin set filetype=xxd | endif
      au BufWritePre  *.bin if &bin | %!xxd -r
      au BufWritePre  *.bin endif
      au BufWritePost *.bin if &bin | %!xxd
      au BufWritePost *.bin set nomod | endif
  augroup END
  " Set terminal colors
  let s:num = 0
  for s:color in [
        \ '#6c6c6c', '#ff6666', '#66ff66', '#ffd30a',
        \ '#1e95fd', '#ff13ff', '#1bc8c8', '#c0c0c0',
        \ '#383838', '#ff4444', '#44ff44', '#ffb30a',
        \ '#6699ff', '#f820ff', '#4ae2e2', '#ffffff',
        \ ]
    let g:terminal_color_{s:num} = s:color
    let s:num += 1
  endfor
  unlet! s:num
  unlet! s:color
