" This vimrc is "inspired" by @moonglum, @garybernhardt and @railsbros-dirk
" Thanks to all of you for letting me steal your stuff :)

" Activate Syntax Highlight
syntax enable
" set default encoding to UTF-8
set encoding=utf-8

" Highlight search results
set hlsearch
" Incremental search, search as you type
set incsearch
" Ignore case when searching
set ignorecase smartcase
" Ignore case when searching lowercase
set smartcase

" Deactivate Wrapping
set nowrap
" Treat all numbers as decimal
set nrformats=
" I don't like Swapfiles
set noswapfile
" Don't make a backup before overwriting a file.
set nobackup
" And again.
set nowritebackup
" I prefer , to be the leader key
let mapleader = ","
" show line numbers
set number
" MOAR colors
set t_Co=256
" Unselect the search result
map <Leader><Space> :noh<CR>
" nnoremap <esc> :noh<return><esc>
" Better buffer handling
set hidden
" hightlight cursor position
set cursorline

" Use the clipboard of Mac OS
if has('mac')
  set clipboard=unnamed
end

" Enable mouse
set mouse=a
" Set the title of the iterm tab
set title

" no timeout, make switching modes easier
set timeoutlen=1000 ttimeoutlen=0

" using another color scheme for diffing, my
" current one does not work that well :(
set diffopt=vertical
au FilterWritePre * if &diff | colorscheme Tomorrow-Night | endif

call plug#begin('~/.config/nvim/plugged')

" CtrlP: Full path fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'

" Borrowed from @skwp
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command =
    \ 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
else
  " Fall back to using git ls-files if Ag is not available
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

let g:ctrlp_working_path_mode = 0

noremap <C-b> :CtrlPBuffer<CR>
let g:ctrlp_dont_split = 'NERD_tree_2'

" Nerdtree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.rbc$', '\.rbo$', '\.class$', '\.o$', '\~$']
noremap <C-n> :NERDTreeToggle<CR>
noremap <leader>n :NERDTreeToggle<CR>

" Color Theme
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'altercation/vim-colors-solarized'

" Polyglot: A collection of language packs, loaded on demand
Plug 'sheerun/vim-polyglot'
" Added Javascript Template Support
au BufNewFile,BufRead *.ejs set filetype=jst

" Syntastic: Really great Syntax checker
Plug 'scrooloose/syntastic'
let g:syntastic_enable_signs=1
let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_auto_loc_list=2
let g:syntastic_javascript_checkers = ['jsl']

" Use Node.js for JavaScript interpretation
let $JS_CMD='node'

" ack.vim: ack integration
Plug 'mileszs/ack.vim'
let g:ackprg = 'ag -S --nogroup --column'

" Better statusbar
Plug 'bling/vim-airline'
let g:airline_powerline_fonts = 1
let g:airlinetheme = "powerlineish"

let g:airline#extensions#branch#displayed_head_limit = 17

set laststatus=2

Plug 'tpope/vim-fugitive'

" Git Gutter: shows a git diff in the gutter
Plug 'airblade/vim-gitgutter'
" without any weird color
highlight clear SignColumn

" Git Commit Browser
Plug 'int3/vim-extradite'
let g:extradite_resize=0

" Cool Undo Tree
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
noremap <Leader>g :GundoToggle<CR>

" Tab completion
Plug 'ervandew/supertab'

" Better * search for selections.
" http://vimcasts.org/episodes/search-for-the-selected-text/
Plug 'nelstrom/vim-visual-star-search'

" Open Markdown files in Marked
Plug 'itspriddle/vim-marked'
noremap <leader>m :MarkedOpen<CR>
let g:marked_app = "Marked"

" Toggle comment blocks
Plug 'tpope/vim-commentary'

Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-rails'
Plug 'bronson/vim-trailing-whitespace'

" Jump between pairs of keywords via %
runtime macros/matchit.vim

" Textobj Rubyblock: Custom text object for selecting ruby blocks
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'jeetsukumaran/vim-buffergator'

" My self written plugins
Plug 'bitboxer/vim-playpause'

Plug 'AndrewRadev/switch.vim'
let g:switch_mapping = "-"

Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
let g:goyo_margin_top=2
let g:goyo_margin_bottom=2
let g:goyo_width=80

function! s:goyo_enter()
  set textwidth=80
  set wrap linebreak
endfunction

function! s:goyo_leave()
  set textwidth&
  set nowrap
endfunction

autocmd! User GoyoEnter
autocmd! User GoyoLeave
autocmd  User GoyoEnter nested call <SID>goyo_enter()
autocmd  User GoyoLeave nested call <SID>goyo_leave()

Plug 'kassio/neoterm'

let g:neoterm_clear_cmd = "clear; printf '=%.0s' {1..80}; clear"
let g:neoterm_position = 'horizontal'
let g:neoterm_automap_keys = ',rt'

nnoremap <silent> <f9> :call neoterm#repl#line()<cr>
vnoremap <silent> <f9> :call neoterm#repl#selection()<cr>

" run set test lib
nnoremap <silent> ,ra :call neoterm#test#run('all')<cr>
nnoremap <silent> ,rf :call neoterm#test#run('file')<cr>
nnoremap <silent> ,rn :call neoterm#test#run('current')<cr>
nnoremap <silent> ,rr :call neoterm#test#rerun()<cr>

" Useful maps
" closes the terminal buffers
nnoremap <silent> ,rc :call neoterm#close()<cr>
" clear terminal
nnoremap <silent> ,rl :call neoterm#clear()<cr>

" experimental area
Plug 'vim-scripts/BufOnly.vim', {'on': ['Bonly', 'BOnly', 'Bufonly', 'BufOnly'] }
Plug 'troydm/zoomwintab.vim', { 'on': 'ZoomWinTabIn' }
Plug 'ngmy/vim-rubocop', { 'on' : 'RubuCop' }
Plug 'Xuyuanp/nerdtree-git-plugin'

" Show invisible characters:
" Tabs and trailing whitespace
set list
set listchars=tab:›\ ,trail:.
" Tabs should be 2 spaces

set tabstop=2
" Soft-Tabs should be 2 spaces
set softtabstop=2
" When shifting, use 2 spaces
set shiftwidth=2
" Use Soft-Tabs
set expandtab
" backspace through everything in insert mode
set backspace=indent,eol,start
" Makefiles require tabs
autocmd FileType make setlocal noexpandtab

" Highlight Characters that overstep the 100 character limit
set colorcolumn=100

" Automatically set the indent of a new line (local to buffer)
" from railsbros-dirk
set ai

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

" Make sure all markdown files have the correct filetype
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} set ft=markdown
au BufRead,BufNewFile *.{cehtml} set ft=html

" Set the Ruby filetype for a number of common Ruby files without .rb
au BufRead,BufNewFile {Berksfile,Vagrantfile,Procfile,config.ru,*.god,*.arb} set ft=ruby

" Treat JSON files like JavaScript
au BufNewFile,BufRead {*.json,*.jsm} set ft=javascript

" Recognize CoffeeScript
au BufNewFile,BufRead *.coffee set ft=coffee

" Make cursor move by visual lines instead of file lines (when wrapping)
noremap k gk
noremap j gj

" upper/lower word
nnoremap <leader>u mQviwU`Q
nnoremap <leader>l mQviwu`Q

" upper/lower first char of word
nnoremap <leader>U mQgewvU`Q
nnoremap <leader>L mQgewvu`Q

" Move selected block
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" ARROW KEYS ARE UNACCEPTABLE
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <Up> <Nop>
noremap <Down> <Nop>

" find merge conflict markers
nnoremap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" Replace selection with text in clipboard
vnoremap r "_dP

" Remember last location in file, but not for commit messages.
" see :help last-position-jump
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g`\"" | endif

" Spelling highlights in bright green
hi clear SpellBad
hi SpellBad ctermfg=41

" Enable spell as default only for certain files
autocmd FileType markdown setlocal spell spelllang=en,de
autocmd BufNewFile,BufRead COMMIT_EDITMSG setlocal spell spelllang=en,de

" enable project based vimrc
set exrc
set secure

" --- End ---
call plug#end()

" colorscheme Tomorrow-Night-Bright
set background=dark
colorscheme solarized
