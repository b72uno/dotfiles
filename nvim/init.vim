" Vimplug

"Automated installation of vimplug if not installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/plugged')

"Autocomplete
Plug 'neoclide/coc.nvim', { 'branch': 'release' } " completion
Plug 'liuchengxu/vista.vim' " tag viewer
Plug 'gelguy/wilder.nvim' " better wildmenu

"Syntax
Plug 'dense-analysis/ale' " linter
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'sheerun/vim-polyglot' " language packs
Plug 'editorconfig/editorconfig-vim' " .editoconfig
Plug 'jeetsukumaran/vim-pythonsense' "text objects and motions for python
Plug 'Vimjas/vim-python-pep8-indent' "better whitespace

"Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' } " fuzzy finder
Plug 'junegunn/fzf.vim'

"Editing
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " Tree explorer
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " multiple cursors
Plug 'tpope/vim-surround' " mappings to edit surroundings in pairs
Plug 'matze/vim-move' " move text up and down without deleting/pasting
Plug 'tpope/vim-repeat' " make . work better with plugins
Plug 'sickill/vim-pasta' " pasting with context
Plug 'godlygeek/tabular' " aligning text
Plug 'dhruvasagar/vim-table-mode' " table creator / formatter
Plug 'tpope/vim-commentary' " better commenting
Plug 'tpope/vim-sleuth' " auto-sets shiftwidth and expandtap
Plug 'andymass/vim-matchup' " better %
Plug 'brooth/far.vim' " find and replace
Plug 'AndrewRadev/splitjoin.vim' " switch between single and multiline
" Plug 'jiangmiao/auto-pairs' " insert and delete brackets etc in pairs
" Plug 'tpope/vim-endwise' " conflicts with Coc

" Navigation
Plug 'wellle/context.vim' " context of visible buffer
Plug 'tpope/vim-unimpaired' " better brackets
Plug 'tpope/vim-speeddating' " better incr/decr dates,times etc
Plug 'easymotion/vim-easymotion' " jump to arbitrary spaces

"Git
Plug 'tpope/vim-fugitive' "
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim' " git commit browser, requires fugitive

"Misc
Plug 'ThePrimeagen/vim-be-good'  " game
Plug 'breuerfelix/vim-todo-lists' " easier TODO lists
Plug 'mhinz/vim-startify' " MRU files on startup
Plug 'honza/vim-snippets' " also install coc-snippets

"Statusbar, color and visual aids
Plug 'vim-airline/vim-airline'
Plug 'rafi/awesome-vim-colorschemes'
"Plug 'morhetz/gruvbox' " colorscheme
Plug 'dracula/vim' " colorscheme
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' } " visual focus
Plug 'junegunn/limelight.vim', { 'on': 'Goyo' }
Plug 'junegunn/vim-peekaboo' " toggles registers before pasting
Plug 'roman/golden-ratio' " auto resize active tab
Plug 'norcalli/nvim-colorizer.lua' " color code highlighter
Plug 'ryanoasis/vim-devicons'  " visual icons for files
Plug 'liuchengxu/vim-which-key' " preview of shortcuts

"Language specific
Plug 'jpalardy/vim-slime' " REPL
Plug 'lervag/vimtex' " LaTeX support
Plug 'fatih/vim-go' "go support
Plug 'mattn/emmet-vim' " easier HTML
Plug 'chrisbra/vim-zsh'
Plug 'tomlion/vim-solidity'

call plug#end()

filetype plugin indent on
syntax enable

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

"---------------------------------------------------------------------------
" Plugin settings

" Colorscheme
colorscheme dracula
let g_afterglow_italic_comments = 1
" let g_gruvbox_italic = 1
" set background=dark " Setting dark mode

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Comfortable motion
let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"

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
set incsearch                                       "incremental searching
set ignorecase                                      "ignore case for searching
set smartcase                                       "do case-sensitive if there's a capital letter
set wrapscan                                        "set the search scan to wrap lines

"" allows incsearch highlighting for range commands
cnoremap $t <CR>:t''<CR>
cnoremap $T <CR>:T''<CR>
cnoremap $m <CR>:m''<CR>
cnoremap $M <CR>:M''<CR>
cnoremap $d <CR>:d<CR>

"ui configuration
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
noremap <silent> <leader>cc :close<CR>
noremap <silent> <leader>cw :cclose<CR>

" tab shortcuts
map <leader>tn :tabnew<CR>
map <leader>tc :tabclose<CR>
map <silent> <leader>tm :tabm
map <silent> <leader>ts :tab split<CR>

" remap arrow keys
" nnoremap <left> :bprev<CR>
" nnoremap <right> :bnext<CR>
" nnoremap <up> :tabnext<CR>
" nnoremap <down> :tabprev<CR>

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
nnoremap <silent> <leader>ev :edit $MYVIMRC<CR>
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>
nnoremap <silent> <leader>et :edit ~/.config/dotfiles/tmux/tmux.conf.symlink<CR>
nnoremap <silent> <leader>ea :edit ~/.config/dotfiles/alacritty/alacritty.yml<CR>
nnoremap <silent> <leader>ez :edit ~/.config/dotfiles/zsh/zshrc.symlink<CR>
"

" underline the current line with '='
nmap <silent> <leader>ul :t.\|s/./=/g\|set nohls<cr>

" general
nmap <leader>li :set list! list?<cr>

" toggle highlighting search results
nnoremap <leader>h :set hlsearch! hlsearch?<cr>

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

" This is what sets vim to use 24-bit colors. It will also work for any version of neovim newer than 0.1.4.
set termguicolors

"Wilder
"command completion
call wilder#enable_cmdline_enter()
set wildcharm=<Tab>
cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"

" only / and ? is enabled by default
call wilder#set_option('modes', ['/', '?', ':'])


"fzf
nnoremap <silent> <leader>F :FZF ~<cr>

" Open files on enter in a new tab
let g:fzf_action = {
      \ 'enter': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

" Limit the window size to 40% screen from the bottom
let g:fzf_layout = { 'down': '~40%' }

" Mapping for most oftenly used command
nnoremap <Leader><Leader> :Files<cr>

" Search a file but only within the files that are changed (Git-wise)
command! Fzfc call fzf#run(fzf#wrap(
      \ {'source': 'git ls-files --exclude-standard --others --modified'}))
noremap <Leader>] :Fzfc<cr>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

"Coc
" ====
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
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
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Show snippets for current file
nnoremap <silent><nowait> <space>a :<C-u>CocList snippets<cr>

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

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)


"ALE
let g:ale_disable_lsp = 1
let g:ale_linters = {
      \   'python': ['flake8', 'pylint'],
      \   'ruby': ['standardrb', 'rubocop'],
      \   'javascript': ['eslint'],
      \}

let g:ale_fixers = {
      \    'python': ['yapf'],
      \}
nmap <F10> :ALEFix<CR>
let g:ale_fix_on_save = 1
nnoremap ]r :ALENextWrap<CR>  " move to the next ALE warning / error
nnoremap [r :ALEPreviousWrap<CR> " move to the previous ALE warning / error
nnoremap <leader>d :ALEDetail<cr> " show the full message

"NerdTree
map <F7> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1 "Always show hiden files
let NERDTreeQuitOnOpen=1 "Close after opening a file

"Vim-slime
let g:slime_python_ipython=1
let g:slime_target = 'tmux'
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_dont_ask_default = 1
let g:slime_cell_delimiter = "# %%"
nmap <leader>sc <Plug>SlimeSendCell

"language-specific mappings
autocmd FileType python map <buffer> <S-e> :w<CR>:!/usr/bin/env python %<CR>

let g:tex_flavor = 'latex' "vimtex

" vim-which-key
let g:maplocalleader = "\<Space>"
let g:mapleader = ','
nnoremap <silent> <localleader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <leader> :<c-u>WhichKey  ','<CR>

" emmet-vim
let g:user_emmet_leader_key='<C-e>'

" context-vim
nmap <leader>ct :ContextToggle<cr>

" easymotion
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" 2 char search
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next) 
map  N <Plug>(easymotion-prev)
