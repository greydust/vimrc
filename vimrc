" greydust's vimrc
" Forked form vgod's vimrc
" For pathogen.vim: auto load all plugins in .vim/bundle

" Plugin Settings {{{

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin()

Plug 'https://github.com/Houl/vim-repmo.git'

Plug 'https://github.com/majutsushi/tagbar.git'

Plug 'https://github.com/ludovicchabant/vim-gutentags.git'

call plug#end()

" Repmo {{{
" map a motion and its reverse motion:
noremap <expr> h repmo#Key('h', 'l')|sunmap h
noremap <expr> l repmo#Key('l', 'h')|sunmap l

" if you like `:noremap j gj', you can keep that:
noremap <expr> j repmo#Key('gj', 'gk')|sunmap j
noremap <expr> k repmo#Key('gk', 'gj')|sunmap k

" repeat the last [count]motion or the last zap-key:
noremap <expr> ; repmo#LastKey(';')|sunmap ;
noremap <expr> , repmo#LastRevKey(',')|sunmap ,
" Repmo }}}

" Gutentags {{{

let g:gutentags_cache_dir = '~/.vim/gutentags'

" Gutentags }}}

" Mixerbox related
call mixerbox#initialize()

" Plugin Settings }}}

" General Settings {{{

set nocompatible	" not compatible with the old-fashion vi mode
set bs=2			" allow backspacing over everything in insert mode
set history=50		" keep 50 lines of command line history
set ruler			" show the cursor position all the time
set autoread		" auto read when file is changed from outside


filetype off			" necessary to make ftdetect work on Linux
syntax on
filetype on				" Enable filetype detection
filetype indent on		" Enable filetype-specific indenting
filetype plugin on		" Enable filetype-specific plugins


" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc

syntax on			" syntax highlight
set hlsearch		" search highlighting

if has("gui_running")	" GUI color and font settings
	set guifont=Osaka-Mono:h20
	set background=dark 
	set t_Co=256          " 256 color mode
	set cursorline        " highlight current line
	colors moria
	highlight CursorLine          guibg=#003853 ctermbg=24  gui=none cterm=none
else
	" terminal color settings
	colors greydust
endif

set clipboard=unnamed	" yank to the system register (*) by default
set showmatch			" Cursor shows matching ) and }
set showmode			" Show current mode
set wildchar=<TAB>		" start wild expansion in the command line using <TAB>
set wildmenu            " wild char completion menu

" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc

set autoindent		" auto indentation
set incsearch		" incremental search
set nobackup		" no *~ backup files
set copyindent		" copy the previous indentation on autoindenting
set ignorecase		" ignore case when searching
set smartcase		" ignore case if search pattern is all lowercase,case-sensitive otherwise
set smarttab		" insert tabs on the start of a line according to context

" disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set foldmethod=marker
set number

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Enable omni completion. (Ctrl-X Ctrl-O)
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType c setlocal omnifunc=ccomplete#Complete
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP

" make CSS omnicompletion work for SASS and SCSS
autocmd BufNewFile,BufRead *.scss             set ft=scss.css
autocmd BufNewFile,BufRead *.sass             set ft=sass.css

" use syntax complete if nothing else available
if has("autocmd") && exists("+omnifunc")
	autocmd Filetype *
				\	if &omnifunc == "" |
				\		setlocal omnifunc=syntaxcomplete#Complete |
				\	endif
endif

set cot-=preview "disable doc preview in omnicomplete

" General Settings }}}

" Tab Settings {{{
set noexpandtab
set tabstop=4
set shiftwidth=4

au FileType Makefile set noexpandtab
" Tab Settings }}}

" Status Line {{{
set laststatus=2
set statusline=\ %{HasPaste()}%<%-15.25(%f%)%m%r%h\ %w\ \ 
set statusline+=\ \ \ [%{&ff}/%Y] 
set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\ 
set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L

function! CurDir()
	let curdir = substitute(getcwd(), $HOME, "~", "")
	return curdir
endfunction

function! HasPaste()
	if &paste
	    return '[PASTE]'
	else
	    return ''
	endif
endfunction

" Status Line }}}

" Encoding Settings {{{
set encoding=utf-8                                  
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

fun! ViewUTF8()
	set encoding=utf-8                                  
	set termencoding=big5
endfun

fun! UTF8()
	set encoding=utf-8                                  
	set termencoding=big5
	set fileencoding=utf-8
	set fileencodings=ucs-bom,big5,utf-8,latin1
endfun

fun! Big5()
	set encoding=big5
	set fileencoding=big5
endfun
" Encoding Settings }}}
