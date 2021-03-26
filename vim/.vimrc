" vim-plug is the package manager, so install it following the instructions at
" https://github.com/junegunn/vim-plug
"
" Shortcut: (works as of 05. Dec 2020)
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" Additionally, node.js and yarn need to be installed for coc.nvim
"
" On first install, the following coc-extensions should be manually added with
" :CocInstall <Name of Extension>
"  - coc-pairs
"  - coc-json
call plug#begin('~/.vim/plugged')
  Plug 'vim-airline/vim-airline'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'dense-analysis/ale'
  Plug 'tomasiser/vim-code-dark'
call plug#end()

set nocompatible
  filetype off

" activate undofile
  if !isdirectory($HOME."/.vim")
      call mkdir($HOME."/.vim", "", 0770)
  endif
  if !isdirectory($HOME."/.vim/undodir")
      call mkdir($HOME."/.vim/undodir", "", 0700)
  endif
  set undodir=~/.vim/undodir
  set undofile

" XML tag matching support
  packadd! matchit
" Terminal debugging
  packadd! termdebug

" Let ALE handle the LSP presentation and coc.nvim takes care of LSP
  let g:ale_disable_lsp = 1
" Enable ALE/ airline integration
  let g:airline#extensions#ale#enabled = 1

" use <tab> for trigger completion and navigate to the next complete item
" https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction

  inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()"

" Use <Tab> and <S-Tab> to navigate the completion list
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Enable syntax highlighting
  syntax on
  colorscheme codedark
  let g:airline_theme = 'codedark'
  set termguicolors

" Spaces & Tabs
  set tabstop=4         " 4 space tab
  set expandtab         " use spaces for tabs
  set softtabstop=4     " 4 space tab
  set shiftwidth=4
  set nomodeline	    " http://www.vim.org/scripts/script.php?script_id=1876 instead
  filetype indent on
  filetype plugin on
  set autoindent

" UI Layout
  set number            " show line numbers
  set showcmd           " show command in bottom bar
  set nocursorline      " highlight current line
  set lazyredraw
  set showmatch         " higlight matching parenthesis
  set guifont=Monospace\ 11,Fira\ Code\ 11,Dejavu\ Sans\ Mono\ 11

" Window
  if has("gui_running")
    set lines=100 "very high numbers, need to be explicitly specified
    set columns=400
    set guioptions-=T guioptions-=m
    " Only works on X11
    autocmd GUIEnter * :call system("wmctrl -ir " . v:windowid . " -b add,maximized,vert,maximized horz")<CR><space>
  endif

" Searching
  set ignorecase        " ignore case when searching
  set smartcase		    " use case sensitive search only when capital letters are entered
  set incsearch         " search as characters are entered
  set hlsearch          " highlight all matches
  nnoremap <silent><esc><esc> :noh<return><esc>" turn off search highlighting until the next search

 " Allows skipping over fake line
  nnoremap j gj
  nnoremap k gk

" Misc
  set backspace=indent,eol,start " Allow backspacing over autoindent, line breaks and start of insert action
  set mouse=a		    " enables mouse in all windows
  set confirm		    " instead of failing a command ask if you want to save last changes
  set pastetoggle=<f11>	" Use <F11> to toggle between 'paste' and 'nopaste'
  set noerrorbells visualbell t_vb=

" Display the cursor position on the last line of the screen or in the status
" line of a window
  set ruler

" Always display the status line, even if only one window is displayed
  set laststatus=2

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
  set cmdheight=2

" Quickly time out on keycodes, but never time out on mappings
  set notimeout ttimeout ttimeoutlen=200

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
  map Y y$

" Window Splitsettings
  set splitright
  set splitbelow

" Help automatically splits vertically
  cnoreabbrev <expr> help ((getcmdtype() is# ':'    && getcmdline() is# 'help')?('vert help'):('help'))
  cnoreabbrev <expr> h ((getcmdtype() is# ':'    && getcmdline() is# 'h')?('vert help'):('h'))

" ALE config
  let g:ale_sign_column_always = 1
  let g:ale_fix_on_save = 1
  let g:ale_lint_on_enter = 1
  let g:ale_lint_on_insert_leave = 1
  let g:ale_lint_on_text_changed = 'always'
  let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace']
  \}

" Automatically insert an extra empty line on <CR> press when opening a pair
" of curly brackets
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Split Termdebug properly with code window on the left and debug view on the
" right
let g:termdebug_wide=1
