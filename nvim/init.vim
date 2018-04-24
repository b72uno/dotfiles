"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.local/share/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('$HOME/.local/share/dein')
  call dein#begin('$HOME/.local/share/dein')

  " Let dein manage dein
  " Required:
  call dein#add('$HOME/.local/share/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/neoyank.vim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('zchee/deoplete-clang')
  call dein#add('Shougo/deol.nvim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('tsukkee/unite-tag')
  call dein#add('ujihisa/neco-look')
  call dein#add('Shougo/neco-syntax')
  call dein#add('davidhalter/jedi')
  call dein#add('zchee/deoplete-jedi')
  call dein#add('neomake/neomake')

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
  call dein#add('vim-airline/vim-airline')
  call dein#add('godlygeek/tabular')


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
 let g:deoplete#num_processes = 1

"---------------------------------------------------------------------------
" deoplete.nvim
"

" <TAB>: completion.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

" inoremap <expr><C-g> deoplete#undo_completion()
" <C-l>: redraw candidates
inoremap <expr><C-g>       deoplete#refresh()
inoremap <silent><expr><C-l>       deoplete#complete_common_string()

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#cancel_popup() . "\<CR>"
endfunction

inoremap <expr> '  pumvisible() ? deoplete#close_popup() : "'"

" cpsm test
" call deoplete#custom#source('_', 'matchers', ['matcher_cpsm'])
" call deoplete#custom#source('_', 'sorters', [])

" call deoplete#custom#source('_', 'matchers', ['matcher_head'])
call deoplete#custom#source('ghc', 'sorters', ['sorter_word'])
" call deoplete#custom#source('buffer', 'mark', '')
" call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
" call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])
" call deoplete#custom#source('buffer', 'mark', '*')

" Use auto delimiter
" call deoplete#custom#source('_', 'converters',
"       \ ['converter_auto_paren',
"       \  'converter_auto_delimiter', 'remove_overlap'])
call deoplete#custom#source('_', 'converters', [
      \ 'converter_remove_paren',
      \ 'converter_remove_overlap',
      \ 'converter_truncate_abbr',
      \ 'converter_truncate_menu',
      \ 'converter_auto_delimiter',
      \ ])

" call deoplete#custom#source('buffer', 'min_pattern_length', 9999)
" call deoplete#custom#source('clang', 'input_pattern', '\.\w*|\.->\w*|\w+::\w*')
" call deoplete#custom#source('clang', 'max_pattern_length', -1)

call deoplete#custom#option('keyword_patterns', {
      \ '_': '[a-zA-Z_]\k*\(?',
      \ 'tex': '[^\w|\s][a-zA-Z_]\w*',
      \ })

" inoremap <silent><expr> <C-t> deoplete#manual_complete('file')

call deoplete#custom#option('camel_case', v:true)

" call deoplete#custom#option('profile', v:true)
" call deoplete#enable_logging('DEBUG', 'deoplete.log')
" call deoplete#custom#source('clang', 'debug_enabled', 1)


" Denite
" nnoremap <leader>y :<C-u>Denite history/yank<CR>
" nnoremap <leader>l :<C-u>Denite -start-insert -auto-resize line<CR>
" nnoremap <leader>R :<C-u>Denite register<CR>
" nnoremap <leader>b :<C-u>Denite -start-insert -auto-resize buffer<CR>
" nnoremap <leader>o :<C-u>Denite -auto-resize outline<CR>
" nnoremap <leader>f :<C-u>Denite -start-insert -auto-resize file_rec/git<CR>
" nnoremap <leader>e :<C-u>DeniteBufferDir -start-insert -auto-resize file<CR>

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

" [Space]: Other useful commands
" Smart space mapping.
nmap  <Space>   [Space]
nnoremap  [Space]   <Nop>

" Set autoread.
nnoremap [Space]ar
      \ :<C-u>call vimrc#toggle_option('autoread')<CR>
" Set spell check.
nnoremap [Space]p
      \ :<C-u>call vimrc#toggle_option('spell')<CR>
      \: set spelllang=en_us<CR>
      \: set spelllang+=cjk<CR>
nnoremap [Space]w
      \ :<C-u>call vimrc#toggle_option('wrap')<CR>

" Easily edit .vimrc
nnoremap <silent> [Space]ev  :<C-u>edit $MYVIMRC<CR>

" Useful save mappings.
nnoremap <silent> <Leader><Leader> :<C-u>update<CR>

  
 " s: Windows and buffers(High priority)
 " The prefix key.
 nnoremap    [Window]   <Nop>
 nmap    s [Window]
 nnoremap <silent> [Window]p  :<C-u>vsplit<CR>:wincmd w<CR>
 nnoremap <silent> [Window]o  :<C-u>only<CR>
 nnoremap <silent> <Tab>      :wincmd w<CR>
 nnoremap <silent><expr> q winnr('$') != 1 ? ':<C-u>close<CR>' : ""

  nnoremap <silent> ;r
        \ :<C-u>Denite -buffer-name=register
        \ register neoyank<CR>
  xnoremap <silent> ;r
        \ :<C-u>Denite -default-action=replace -buffer-name=register
        \ register neoyank<CR>
  nnoremap <silent> [Window]<Space>
        \ :<C-u>Denite file/rec:~/.vim/rc<CR>
  nnoremap <silent> / :<C-u>Denite -buffer-name=search -auto-highlight
        \ line<CR>
  nnoremap <silent> * :<C-u>DeniteCursorWord -buffer-name=search
        \ -auto-highlight -mode=normal line<CR>
  nnoremap <silent> [Window]s :<C-u>Denite file/point file/old
        \ -sorters=sorter/rank
        \ `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'`
        \ file file:new<CR>
  nnoremap <silent><expr> tt  &filetype == 'help' ?  "g\<C-]>" :
        \ ":\<C-u>DeniteCursorWord -buffer-name=tag -immediately
        \  tag:include\<CR>"
  nnoremap <silent><expr> tp  &filetype == 'help' ?
        \ ":\<C-u>pop\<CR>" : ":\<C-u>Denite -mode=normal jump\<CR>"
  nnoremap <silent> [Window]n :<C-u>Denite dein<CR>
  nnoremap <silent> [Window]g :<C-u>Denite ghq<CR>
  nnoremap <silent> ;g :<C-u>Denite -buffer-name=search
        \ -no-empty -mode=normal grep<CR>
  nnoremap <silent> n :<C-u>Denite -buffer-name=search
        \ -resume -mode=normal -refresh<CR>
  nnoremap <silent> ft :<C-u>Denite filetype<CR>
  nnoremap <silent> <C-t> :<C-u>Denite
        \ -select=`tabpagenr()-1` -mode=normal deol:zsh<CR>
  nnoremap <silent> <C-k> :<C-u>Denite -mode=normal change jump<CR>
  nnoremap <silent> [Space]gs :<C-u>Denite gitstatus<CR>
  nnoremap <silent> ;;
        \ :<C-u>Denite command command_history<CR>



" Neomake
autocmd! BufWritePost * Neomake

" Gruvbox
colorscheme gruvbox
let g_gruvbox_italic = 1
set background=dark " Setting dark mode

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1



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
  set guicursor=
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
  
  " Makes the background transparent. Leave these out if you're not using a transparent
  " terminal.
  highlight Normal ctermbg=NONE guibg=NONE
  highlight NonText ctermbg=NONE guibg=NONE

  " This is what sets vim to use 24-bit colors. It will also work for any version of neovim
  " newer than 0.1.4.
  set termguicolors
