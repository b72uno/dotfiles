"---------------------------------------------------------------------------
" Vimplug

"Automated installation of vimplug if not installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/plugged')

"Autocomplete 
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'liuchengxu/vista.vim'
Plug 'gelguy/wilder.nvim'

"Syntax
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'
Plug 'norcalli/nvim-colorizer.lua'

"Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

"Editing
Plug 'jiangmiao/auto-pairs'
Plug 'matze/vim-move'
Plug 'sickill/vim-pasta'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'dhruvasagar/vim-table-mode'
Plug 'godlygeek/tabular'

"Commenting
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-commentary'

"Files
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-sleuth'
Plug 'ryanoasis/vim-devicons'

" Navigation
Plug 'terryma/vim-smooth-scroll'
Plug 'wellle/context.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'justinmk/vim-sneak'

"Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
"
"Statusbar, color and visual aids
Plug 'vim-airline/vim-airline'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'morhetz/gruvbox'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

"Misc
Plug 'ThePrimeagen/vim-be-good'
Plug 'breuerfelix/vim-todo-lists'
" Plug 'lervag/vimtex'
Plug 'chrisbra/vim-zsh'
Plug 'mattn/emmet-vim'

call plug#end()

filetype plugin indent on
syntax enable

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

" Setting of the encoding to use for a save and reading.
" Make it normal in UTF-8 in Unix.
if has('vim_starting') && &encoding !=# 'utf-8'
  if IsWindows() && !has('gui_running')
    set encoding=cp932
  else
    set encoding=utf-8
  endif
endif


"---------------------------------------------------------------------------
" Plugin settings

"CoC
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

inoremap <silent><expr> <C-space> coc#refresh()

"GoTo code navigation
nmap <leader>g <C-o>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>rn <Plug>(coc-rename)

"show all diagnostics.
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>
"manage extensions.
nnoremap <silent> <space>e :<C-u>CocList extensions<cr>

" Gruvbox
colorscheme afterglow
let g_afterglow_italic_comments = 1
" let g_gruvbox_italic = 1
" set background=dark " Setting dark mode

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

"---------------------------------------------------------------------------
" Native config
"

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

" edit dotfiles 
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nmap <silent> <leader>et :e ~/.config/dotfiles/tmux/tmux.conf.symlink<CR>
nmap <silent> <leader>ea :e ~/.config/dotfiles/alacritty/alacritty.yml<CR>
nmap <silent> <leader>ez :e ~/.config/dotfiles/zsh/zshrc.symlink<CR>
" 

" underline the current line with '='
nmap <silent> <leader>ul :t.\|s/./=/g\|set nohls<cr>

" general
nmap <leader>li :set list! list?<cr>

" toggle highlighting search results
nnoremap <BS> :set hlsearch! hlsearch?<cr>

" Tabularize
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
endif


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
autocmd FileType ipynb setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab

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

call wilder#enable_cmdline_enter()

set wildcharm=<Tab>
cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"

" only / and ? is enabled by default
call wilder#set_option('modes', ['/', '?', ':'])

"fzf
nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>F :FZF ~<cr>
