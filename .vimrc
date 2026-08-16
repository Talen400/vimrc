"" <--Global-->
set mouse=a
set number
syntax enable
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set colorcolumn=81
let mapleader = "\\"
highlight ColorColumn ctermbg=darkgray guibg=darkgray

" Highlight current line "
set cursorline
highlight CursorLine cterm=bold ctermbg=black

" Set /Search highlight "
set hlsearch
" /Search with math case "
set ignorecase
set smartcase

set textwidth=79
set wrap
set expandtab

" Show matching [] {} () "
set showmatch

" Enable Color Themes "
if !has('gui_running')
  set t_Co=256
endif
" enable true colors support "
set termguicolors

" Avoid line breaks mid word "
set linebreak
" Always show status bar "
set laststatus=2
" Delete indents "
set backspace=indent,eol,start

" Fold settings "
set foldmethod=indent
set foldnestmax=3

" Increase command history "
set history=1000
" Set vim auto complete menu "
set wildmenu

filetype plugin indent on
filetype indent on

" set ctags in root
set tags=./tags;,tags;

" regenerate the ctags
autocmd BufWritePost *.c,*.h,*.cpp,*.hpp silent! !ctags -R --exclude=.git --exclude=build . &

autocmd FileType c,cpp setlocal comments=s1:/*,mb:**,elx:*/
autocmd FileType c,cpp setlocal cindent
" headers to C++
autocmd BufNewFile,BufRead *.hpp set filetype=cpp
" indent to public and private
set cinoptions+=g0
nnoremap <F5> :set list!<CR>
set listchars=tab:>-,trail:.,nbsp:.

" commands: PlugInstall
"<--PLUGINS-->
call plug#begin()
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'tomasiser/vim-code-dark'
Plug 'dense-analysis/ale'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()

" nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <silent> <leader>nr :NERDTreeRefreshRoot<CR>

" ALE config
let g:ale_enabled = 1
let g:ale_linters = {
\ 'c': ['gcc'],
\ 'cpp': ['g++'],
\ 'python': ['flake8', 'mypy'],
\ 'java': ['javac']
\}

" to java ensures...
autocmd FileType java call SetJavaSourcepath()
function! SetJavaSourcepath()
  let l:makefile = findfile('Makefile', expand('%:p:h') . ';')
  if !empty(l:makefile)
    let l:root = fnamemodify(l:makefile, ':p:h')
    let b:ale_java_javac_options = '-sourcepath ' . l:root . ' -d /tmp/ale_java_classes'
  endif
endfunction

" to java ensures...
autocmd FileType java call SetJavaSourcepath()

function! SetJavaSourcepath()
  let l:makefile = findfile('Makefile', expand('%:p:h') . ';')
  if !empty(l:makefile)
    let l:root = fnamemodify(l:makefile, ':p:h')
    let b:ale_java_javac_options = '-sourcepath ' . l:root . ' -d /tmp/ale_java_classes'
  endif
endfunction

" Configs of linters for each language
let g:ale_c_gcc_options = '-Wall -Wextra -Werror -pedantic -Iinclude'
let g:ale_cpp_gpp_options = '-Wall -Wextra -Werror -std=c++98'
let g:ale_use_terminal = 0

" Verific
let g:ale_lint_on_text_changed = 'normal'  " Check when type
let g:ale_lint_on_insert_leave = 1         " Check when go out of insert mode
let g:ale_lint_on_save = 1                 " Always checking when save

" Feedback visual clean
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = ' ▶ '
highlight ALEErrorSign ctermfg=red guifg=red
highlight ALEWarningSign ctermfg=yellow guifg=orange
highlight ALEVirtualTextError ctermfg=red guifg=red
highlight ALEVirtualTextWarning ctermfg=yellow guifg=orange

" theme airline
let g:airline_theme='minimalist'
colorscheme codedark
