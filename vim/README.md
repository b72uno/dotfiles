# bling.vim
Vim config based on [bling.vim - "A highly tuned vim distribution that will blow your socks off!"](https://github.com/bling/dotvim)

## introduction

this is my ***personal*** vim distribution that i have tweaked over time and evolved from a simple vanilla vimrc configuration to a full-blown distribution that it is today.

while it is very easy to install this and get up and running on a brand new machine (a use case i have), i recommend that you do not install this unless you fully understand everything that's going on inside.  scan it for tips and tricks, or fork and customize it for *your* needs.

## installation

1.  clone this repository into your `~/.vim` directory
1.  `git submodule init && git submodule update`
1.  `mv ~/.vimrc ~/.vimrc.backup`
1.  create the following shim and save it as `~/.vimrc`:

```
let g:dotvim_settings = {}
let g:dotvim_settings.version = 1
source ~/.vim/vimrc
```

1.  startup vim and neobundle will detect and ask you install any missing plugins.  you can also manually initiate this with `:NeoBundleInstall`
1.  done!

### versioning

the `g:dotvim_settings.version` is a simple version number which is manually edited.  it is used to detect whether significant breaking changes have been introduced so that users of the distribution can be notified accordingly.

## customization

*  since the distribution is just one file, customization is straightforward.  any customizations can be added to the `g:dotvim_settings` variable, which will be used whilst sourcing the distribution's `vimrc` file.  here is an example:

```
" this is the bare minimum
let g:dotvim_settings = {}
let g:dotvim_settings.version = 1

" here are some basic customizations, please refer to the top of the vimrc file for all possible options
let g:dotvim_settings.default_indent = 3
let g:dotvim_settings.max_column = 80
let g:dotvim_settings.colorscheme = 'my_awesome_colorscheme'

" by default, language specific plugins are not loaded.  this can be changed with the following:
let g:dotvim_settings.plugin_groups_exclude = ['ruby','python']

" if there are groups you want always loaded, you can use this:
let g:dotvim_settings.plugin_groups_include = ['go']

" alternatively, you can set this variable to load exactly what you want
let g:dotvim_settings.plugin_groups = ['core','web']

" if there is a particular plugin you don't like, you can define this variable to disable them entirely
let g:dotvim_settings.disabled_plugins=['vim-foo','vim-bar']

" finally, load the distribution
source ~/.vim/vimrc

" anything defined here are simply overrides
set wildignore+=\*/node_modules/\*
set guifont=Wingdings:h10
```

## autocomplete

this distribution will pick one of three combinations, in the following priority:

1.  [neocomplete][nc] + [neosnippet][ns] if you have `lua` enabled.
2.  [youcompleteme][ycm] + [ultisnips][us] if you have compiled YCM.
3.  [neocomplcache][ncl] + [neosnippet][ns] if you only have vimscript available

this can be overridden with `g:dotvim_settings.autocomplete_method`

## standard modifications

*  if you have either [ack](http://betterthangrep.com/) or [ag](https://github.com/ggreer/the_silver_searcher) installed, they will be used for `grepprg`
*  all temporary files are stored in `~/.vim/.cache`, such as backup files and persistent undo

## mappings

### insert mode
*  `<C-h>` move the cursor left
*  `<C-l>` move the cursor right
*  `jk`, `kj` remapped for "smash escape"

### normal mode
*  `<leader>fef` format entire file
*  `<leader>f$` strip current line of trailing white space
*  window shortcuts
  *  `<leader>v` vertical split
  *  `<leader>s` horizontal split
  *  `<leader>vsa` vertically split all buffers
  *  `<C-h>` `<C-j>` `<C-k>` `<C-l>` move to window in the direction of hkjl
*  window killer
  *  `Q` remapped to close windows and delete the buffer (if it is the last buffer window)
* searching
  *  `<leader>fw` find the word under cursor into the quickfix list
  *  `<leader>ff` find the last search into the quickfix list
  *  `/` replaced with `/\v` for sane regex searching
  *  `<cr>` toggles hlsearch
*  `<Down>` `<Up>` maps to `:bprev` and `:bnext` respectively
*  `<Left>` `<Right>` maps to `:tabprev` and `:tabnext` respectively
*  `gp` remapped to visually reselect the last paste
*  `gb` for quick going to buffer
*  `<leader>l` toggles `list` and `nolist`
*  profiling shortcuts
   * `<leader>DD` starts profiling all functions and files into a file `profile.log`
   * `<leader>DP` pauses profiling
   * `<leader>DC` continues profiling
   * `<leader>DQ` finishes profiling and exits vim

### visual mode
*  `<leader>s` sort selection
*  `>` and `<` automatically reselects the visual selection

## Extensive plugin list 

### Core

* [neobundle](https://github.com/Shougo/neobundle.vim) Vim plugin manager
* [vimproc](https://github.com/Shougo/vimproc.vim) A dependency for plugins by Shougo (neobundle, unite, neocomplcache)
* [airline](https://github.com/bling/vim-airline) Lean & mean status/tabline for vim that's light as air.
* [surround](https://github.com/tpope/vim-surround) makes for quick work of surrounds
* [repeat](https://github.com/tpope/vim-repeat) repeat plugin commands
* [dispatch](https://github.com/tpope/vim-dispatch) asynchronous build and test dispatcher
* [eunuch](https://github.com/tpope/vim-eunuch) Vim sugar for the UNIX shell commands
* [unimpaired]:W(https://github.com/tpope/vim-unimpaired)
  *  many additional bracket `[]` maps
  *  `<C-up>` to move lines up
  *  `<C-down>` to move lines down

### Web
* [vim-less](https://github.com/groenewege/vim-less) less syntax support 
* [scss-syntax](https://github.com/cakebaker/scss-syntax.vim) scss syntax support 
* [vim-css3-syntax](https://github.com/hail2u/vim-css3-syntax.vim) css3  syntax support 
* [vim-css-color](https://github.com/ap/vim-css-color) highlight colors in css files
* [html5](https://github.com/othree/html5.vim) html5 syntax support
* [vim-stylus](https://github.com/wavded/vim-stylus) stylus syntax support
* [vim-jade](https://github.com/digitaltoad/vim-jade) jade syntax support
* [vim-mustache-handlebars](https://github.com/juvenn/mustache.vim) mustache and handlebars syntax support
* [MatchTag](https://github.com/gregsexton/Matchtag) highlights the matching html tag on cursor position
* [emmet](https://github.com/mattn/emmet-vim)
  *  makes for writing html/css extremely fast
  *  for supported most filetypes, `<tab>` will be mapped to automatically expand the line (you can use `<C-v><Tab>` to insert a tab character if needed)
  *  for other features, default plugin mappings are available, which means `<C-y>` is the prefix, followed by a variety of options (see `:help zencoding`)

### Javascript
* [tern_for_vim](https://github.com/marijnh/tern_for_vim) In JavaScript files, the package will hook into omni completion to handle autocompletion, and provide the following commands:  
  * TernDef: Jump to the definition of the thing under the cursor.
  * TernDoc: Look up the documentation of something.
  * TernType: Find the type of the thing under the cursor.
  * TernRefs: Show all references to the variable or property under the cursor.
  * TernRename: Rename the variable under the cursor.
* [vim-javascript](https://github.com/pangloss/vim-javascript) js syntax and indent support
* [vim-jsbeautify](https://github.com/maksimr/vim-jsbeautify) allows to quickly format js, html and css files. <leader>fjs will call JsBeautify()
* [typescript-vim](https://github.com/leafgarland/typescript-vim) typscript syntax support
* [vim-coffee-script](https://github.com/kchmck/vim-coffee-script) coffee-script syntax support
* [vim-node.js](https://github.com/mmalecki/vim-node.js) ft detect plugin which detects node.js shebang 
* [vim-json](https://github.com/leshill/vim-json) JSON syntax support
* [javascript-libraries-syntax](https://github.com/othree/javascript-libraries-syntax.vim) syntax support for various JS libraries like jQuery, underscore, angularjs, requirejs, jasmine, etc

### Ruby
* [vim-rails](https://github.com/tpope/vim-rails) toolbox for Rails. See help. 
* [vim-bundler](https://github.com/tpope/vim-bundler) support for Bundler 

### Python
* [python-mode](https://github.com/klen/python-mode) toolbox for Python. Includes pylint, rope, pydoc, pyflakes, pep8 and mccabe 
* [jedi-vim](https://github.com/davidhalter/jedi-vim) a vim binding to the autocompletion library Jedi

### Scala
* [vim-scala](https://github.com/derekwyatt/vim-scala) integration of Scala into Vim. 
* [vimside](https://github.com/megaannum/vimside) vim scala IDE, built upon ENSIME

### Go
* [vim-golang](https://github.com/jnwhiteh/vim-golang) plugin bundle for Go
* [gocode](https://github.com/nsf/gocode) autocompletion for Go

### SCM
*  [signify](https://github.com/mhinz/vim-signify) adds + and - to the signs column when changes are detected to source control files (supports git/hg/svn)
* [fugitive](https://github.com/tpope/vim-fugitive) git wrapper
  *  `<leader>gs` status
  *  `<leader>gd` diff
  *  `<leader>gc` commit
  *  `<leader>gb` blame
  *  `<leader>gl` log
  *  `<leader>gp` push
  *  `<leader>gw` stage
  *  `<leader>gr` rm
  *  in addition to all the standard bindings when in the git status window, you can also use `U` to perform a `git checkout --` on the current file
* [vim-lawrencium](https://github.com/ludovicchabant/vim-lawrencium) a mercurial wrapper for vim
* [gitv](https://github.com/gregsexton/gitv)
  *  nice log history viewer for git
  *  `<leader>gv`

### General autocompletion 
* [vim-snippets](https://github.com/honza/vim-snippets) snippets for autocompletion
* [youcompleteme][ycm]/[ultisnips][us]
  *  amazingly fast fuzzy autocomplete engine combined with an excellent snippets library
  *  use `<C-n>` and `<C-p>` to go back/forward between selections, and `<tab>` to expand snippets

* [neocomplcache][ncl]/[neosnippet][ns]
  *  autocomplete/snippet support as a fallback choice when YCM and/or python is unavailable
  *  `<Tab>` to select the next match, or expand if the keyword is a snippet
  *  if you have lua installed, it will use [neocomplete][nc] instead

### Editing
* [editorconfig-vim](https://github.com/editorconfig/editorconfig-vim) EditorConfig support 
* [vim-endwise](https://github.com/tpope/vim-endwise) wisely adds "end" in ruby, endfunction/endif/more in vim script, etc
* [speeddating](https://github.com/tpope/vim-speeddating) `Ctrl+A` and `Ctrl+X` for dates
* [vim-visualstar](https://github.com/thinca/vim-visualstar) search your selection text in visual mode 
* [tcomment](https://github.com/tomtom/tcomment_vim) very versatile commenting plugin that can do motions
  *  `gcc` to toggle or `gc{motion}`
* [vim-expand-region](https://github.com/terryma/vim-expand-region) allows you to visually select increasingly larger regions of text using the same key combination.
    * Use + to expand, _ to shrink.
* [vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors)
  *  mapped to `<C-N>`, this will select all matching words and lets you concurrently change all matches at the same time
* [nrrwrgn](http://github.com/chrisbra/NrrwRgn)
  *  `<leader>nr` puts the current visual selection into a new scratch buffer, allowing you to perform global commands and merge changes to the original file automatically
* [tabular](https://github.com/godlygeek/tabular) easily aligns code
  *  `<leader>a&`, `<leader>a=`, `<leader>a:`, `<leader>a,`, `<leader>a|`
* [auto-pairs](https://github.com/jiangmiao/auto-pairs) allows to insert and delete brackets, parens or quotes in pairs
* [vim-sneak](https://github.com/justinmk/vim-sneak) allows to move to any location specified by two characters.
  * Works accross multiple lines, with operators (including repeat .)
  * Move to the next or previous match via ; or , (or by pressing s again immediately)
  * Move to the nth match by prefixing ; or , with a count

### Navigation
* [ack](https://github.com/mileszs/ack.vim) 
* [undotree](https://github.com/mbbill/undotree) visualize the undo tree
  *  `<F5>` to toggle
* [EasyGrep](https://github.com/vim-scripts/EasyGrep) makes search/replacing in your project a lot easier without relying on `find` and `sed`
  *  the loading time of this plugin is relatively heavy, so it is not loaded at startup.  to load it on-demand, use `<leader>vo`, which opens the options window.
  *  `<leader>vv` find word under the cursor
  *  `<leader>vV` find whole word under the cursor
  *  `<leader>vr` perform global search replace of word under cursor, with confirmation
  *  `<leader>vR` same as vr, but matches whole word
* [ctrlp](https://github.com/kien/ctrlp.vim) fuzzy file searching
  *  `<C-p>` to bring up the search
  *  `\t` search the current buffer tags
  *  `\T` search global tags
  *  `\l` search all lines of all buffers
  *  `\b` search open buffers
  *  `\o` parses the current file for functions with [funky](https://github.com/tacahiroy/ctrlp-funky)
* [nerdtree](https://github.com/scrooloose/nerdtree) file browser
  *  `<F2>` toggle browser
  *  `<F3>` open tree to path of the current file
* [tagbar](https://github.com/majutsushi/tagbar) file tag browser
  * `<F9>` toggle tagbar

### Unite 
* [unite.vim](https://github.com/Shougo/unite.vim) this is an extremely powerful plugin that lets you build up lists from arbitrary sources
  *  mappings
    *  `<space><space>` go to anything (files, buffers, MRU, bookmarks)
    *  `<space>y` select from previous yanks
    *  `<space>l` select line from current buffer
    *  `<space>b` select from current buffers
    *  `<space>o` select from outline of current file
    *  `<space>s` quick switch buffer
    *  `<space>/` recursively search all files for matching text (uses `ag` or `ack` if found)
* [unite-airline_themes](https://github.com/osyo-manga/unite-airline_themes) 
* [unite-tag](https://github.com/tsukkee/unite-tag) a plugin for selecting tags or files including tags
* [unite-outline](https://github.com/Shougo/unite-outline) provides vims buffer with the outline view
* [unite-help](https://github.com/Shougo/unite-help)
* [junkfile](https://github.com/Shougo/junkfile.vim) create a temporary file for testing etc

### Indents
* [vim-indent-guides](https://github.com/nathanaelkane/vim-indent-guides) vertical highlights for indents


### Textobject
* [vim-textobj-user](https://github.com/kana/vim-textobj-user) text object helper
* [vim-textobj-indent](https://github.com/kana/vim-textobj-indent) text objects for indented blocks of lines
* [vim-textobj-entire](https://github.com/kana/vim-textobj-entire) text objects for entire buffer
* [vim-textobj-underscore](https://github.com/lucapette/vim-textobj-underscore) 
  * provides two new text-objects which are triggered by a_ and i_ respectively
  * ou can use them when you have to deal with the following type of words:
    * `Foo_bar_baz`
  * Now, suppose you have to change bar to qux (* for cursor position). You can do the following:
    * foo_b*ar_bar and type `ci_` to get foo_*_bar. 
    * Or you can type `da_` to get foobar

### Misc
* [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) navigation between tmux panes and vim splits
* [vim-vspec](https://github.com/kana/vim-vspec) testing framework for vimscript
* [vim-scriptease](https://github.com/tpope/vim-scriptease) as tpope puts it - amalgamation of crap he uses for editing runtime files
* [vim-markdown](https://github.com/plasticboy/vim-markdown) support for markdown
* [vim-instant-markdown](https://github.com/suan/vim-instant-markdown) realtime markdown preview in browser 
* [xterm-color-table](https://github.com/guns/xterm-color-table.vim) xterm colors in vim
  * Provides command :XtermColorTable, as well as variants for different splits
  * Xterm numbers on the left, equivalent RGB values on the right
  * Press # to yank current color (shortcut for yiw)
  * Press t to toggle RGB text visibility
  * Press f to set RGB text to current color
  * Buffer behavior similar to Scratch.vim
* [vim_faq](https://github.com/chrisbra/vim_faq) 
* [vimwiki](https://github.com/vim-scripts/vimwiki) Vimwiki is a personal wiki for Vim -- a number of linked text files that have their own syntax highlighting.
  * With vimwiki you can:
    - organize notes and ideas;
    - manage todo-lists;
    - write documentation.
  * To do a quick start press <Leader>ww (this is usually \ww) to go to your index wiki file.  By default it is located in: ~/vimwiki/index.wiki
* [bufkill.vim](https://github.com/vim-scripts/bufkill.vim) Unload/delete/wipe a buffer, keep its window(s), display last accessed buffer(s)
  * `<leader>bd` or `:BD` will kill a buffer without changing the window layout
* [vim-startify](https://github.com/mhinz/vim-startify) a better start screen for vim
* [syntastic](https://github.com/scrooloose/syntastic) syntax checking for variety of languages
* [gist](https://github.com/mattn/gist-vim) automatically get or push changes for gists with `:Gist`
* [vimshell](https://github.com/Shougo/vimshell) shell in vim 
  * `<leader>c` splits a new window with an embedded shell
* [GoldenView](https://github.com/zhaocai/GoldenView.Vim) automatically resizes your active window
  * `<C-L>` automatically split to tiled windows
  * `<F8>` / `<S-F8`  switch current window with the main pane and toggle back
  * `<C-N>, <C-P>` jump to next/previous window

### Windows
* [vim-ps1](https://github.com/PProvost/vim-ps1) powershell support
* [Omnisharp](https://github.com/nosami/Omnisharp) vim omnicompletion and more for C#


### Notes for personalization 
* Rewrite settings
* [Colorizer](https://github.com/chrisbra/Colorizer) color hex codes and color names, replace vim-css3-color from web group?
* vim-jedi seems to conflict with python-mode, make sure it is true and disable on if needed. Also jedi-vim requires Jedi, which can be installed via pip install jedi or with git submodule update --init. Make sure this config installs it?
* Check out how multiple cursors work, get used to them
* Check out sneak, try it.
* Try out easygrep
* For instant markdown - [sudo] gem install pygments.rb [sudo] gem install redcarpet -v 2.3.0 [sudo] npm -g install instant-markdown-d If you're on Linux, the xdg-utils package needs to be installed 
* Install xolox plugins - easytags and session 
* Check for plugins in next section
* Get rid of plugins like the vimwiki, but first try it out, maybe it catches, also change the bloody font to something 
* http://www.slant.co/topics/67/~what-are-the-best-programming-fonts add way to install Source Code Pro at least


### and some more plugins

* [signature](https://github.com/kshenoy/vim-signature) shows marks beside line numbers
* [bufferline](https://github.com/bling/vim-bufferline) simple plugin which prints all your open buffers in the command bar
* [delimitmate](https://github.com/Raimondi/delimitMate) automagically adds closing quotes and braces

## credits

I wanted to give special thanks to all of the people who worked on the following projects, or people simply posted their vim distributions, because i learned a lot and took many ideas and incorporated them into my configuration.

*  [janus](https://github.com/carlhuda/janus)
*  [spf13](https://github.com/spf13/spf13-vim)
*  [yadr](http://skwp.github.com/dotfiles/)
*  [astrails](https://github.com/astrails/dotvim)
*  [tpope](https://github.com/tpope)
*  [scrooloose](https://github.com/scrooloose)
*  [shougo](https://github.com/Shougo)
*  [lokaltog](https://github.com/Lokaltog)
*  [sjl](https://github.com/sjl)
*  [terryma](https://github.com/terryma)

## license
[WTFPL](http://sam.zoy.org/wtfpl/)

## changelog

*  v1
  * requires `g:dotvim_settings.version` to be defined
  * disable all langauge-specific plugins by default
  * add support for `g:dotvim_settings.plugin_groups_include`


[ycm]: https://github.com/Valloric/YouCompleteMe
[us]: https://github.com/SirVer/ultisnips
[nc]: https://github.com/Shougo/neocomplete.vim
[ncl]: https://github.com/Shougo/neocomplcache.vim
[ns]: https://github.com/Shougo/neosnippet.vim


Running into errors when installing npm packages? Reclaim your rights!
sudo chown -R `whoami` ~/.npm
sudo chown -R `whoami` /usr/local/lib/node_modules
