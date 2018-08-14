set visualbell
"fg inspiration:
" https://github.com/timbertson/app-customisations/blob/master/vim/vimrc
syntax on
syntax sync minlines=200  " don't lose track when in large syntax blocks
set background=dark
colorscheme solarized
if has("multi_byte")
	if &termencoding == ""
		let &termencoding = &encoding
	endif
	set encoding=utf-8
	setglobal fileencoding=utf-8
	"setglobal bomb
	"set fileencodings=ucs-bom,utf-8,latin1
endif
set autoindent
set formatoptions=crqln
set clipboard=unnamed
set preserveindent
set copyindent
" insert a tab at the start of the line, without messing up existing (mixed) indents
nmap <leader><tab> m'0i<tab><esc>`'l
set nojoinspaces " just one space after a period (when joining)
set nocompatible
set nonumber
"set smartcase
set softtabstop=0
set textwidth=0
set tabstop=4 shiftwidth=4
set wrapmargin=0

" reload filetype detection
filetype plugin indent on
filetype off
" run time path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
call vundle#end()

filetype plugin indent on
"execute pathogen#infect()

" do not interfere with syntastic checkers Valloric/YouCompleteMe/commit/bc4e7f
"if clang build fails even after cmake clean i.e. removal of build directory contents
"let g:ycm_register_as_syntastic_checker = 0

"let g:syntastic_cpp_check_header = 1
"let g:syntastic_cpp_auto_refresh_includes = 1

let g:syntastic_c_checkers = ['gcc']
let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_javascript_closurecompiler_path = '~/google-javascript-closure-compiler/closure-compiler.jar'
let g:syntastic_python_checkers = ['python']


" replace white space on blank lines:
"autocmd BufNewFile,BufRead * exe "g/\\s\\+$/s/\\s\\+$//gc"

" replace tabsize white space by tab:
"autocmd BufNewFile,BufRead * exe "g/[ ]{" . &shiftwidth . "}/s/[ ]{" . &shiftwidth . "}/\\t/gc"


" draw tabs
"autocmd BufNewFile,BufRead * set list listchars=tab:>-
"set list listchars=tab:▸\
"set listchars=tab:>-,trail:_ list

" highlight any spaces that are followed by a tab (the horror!)
" and any _single_ space that comes after ^\t+ (this is usually accedental)
" and also trailing spaces
autocmd BufNewFile,BufRead * match Error /\( \+\t\@=\)\|\(^\(\t\+\)\zs \ze[^ *]\)\|\([^ \t]\zs\s\+$\)\|\(\s\+$\)/
match Error /\( \+\t\@=\)\|\(^\(\t\+\)\zs \ze[^ *]\)\|\([^ \t]\zs\s\+$\)/
" Highlight as Tag or Error if a blank/empty line contains tabs: (spaces only
" are already handled by the above match)




"command! -nargs=0 Spaces set et noet< | retab
fun! Tabsize(sz)
	let &l:shiftwidth=a:sz
	let &l:tabstop=a:sz
	let &l:softtabstop=a:sz
endfun
fun! GlobalTabsize(sz)
	let &shiftwidth=a:sz
	let &tabstop=a:sz
	let &softtabstop=a:sz
endfun
command! -nargs=1 Tabsize call Tabsize(<args>)
set noexpandtab
call GlobalTabsize(4)
" defaults for indent-finder when no other preference is clear from the file
let g:indent_finder_default_style="tab"
let g:indent_finder_default_width="4"


command! -nargs=* SpacesToTab call SpacesToTab()
function! SpacesToTab()
	let spaces = ""
	let x = 0
	while x < &l:shiftwidth
		let spaces = spaces . " "
		let x = x + 1
	endwhile
	exe "g/" . spaces . "/%s/" . spaces . "/\\t/gic"
endfunction


command! -nargs=* TabToSpaces call TabToSpaces()
function! TabToSpaces()
	let spaces = ""
	let x = 0
	while x < &l:shiftwidth
		let spaces = spaces . " "
		let x = x + 1
	endwhile
	exe "g/\\t/%s/\\t/" . spaces . "/gic"
endfunction


" Set exandtab (insert spaces instead of tabs)
" http://stackoverflow.com/questions/1562336/tab-vs-space-preferences-in-vim#answer-1610732
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set shiftwidth=')

  if l:tabstop > 0
    " do we want expandtab as well?
    let l:expandtab = confirm('set expandtab?', "&Yes\n&No\n&Cancel")
    if l:expandtab == 3
      " abort?
      return
    endif

    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop

    if l:expandtab == 1
      setlocal expandtab
      TabToSpaces()
    else
      setlocal noexpandtab
      SpacesToTab()
    endif
  endif

  " show the selected options
  try
    echohl ModeMsg
    echon 'set tabstop='
    echohl Question
    echon &l:ts
    echohl ModeMsg
    echon ' shiftwidth='
    echohl Question
    echon &l:sw
    echohl ModeMsg
    echon ' sts='
    echohl Question
    echon &l:sts . ' ' . (&l:et ? '  ' : 'no')
    echohl ModeMsg
    echon 'expandtab'
  finally
    echohl None
  endtry
endfunction

"already loaded automatically:source $HOME/.vim/plugin/cscope_maps.vim
" any location below plugin is on the runtime path

" Pyclewn GDB interface maps:
" :map <F8> :Cfile /path/to/foobar <Bar> Cbreak main <Bar> Crun <CR>
"
:map <F11> :Cstepi <CR>  " step instruction
:map <F10> :Cstep <CR>
:map <F9> :Cnext <CR>
:map <F8> :Ccontinue <CR>
:map <F7> :Cwhere <CR>
:map <F6> :Creverse-next <CR>
:map <F5> :Clist <CR>
:map <F4> :Cprint $sp<CR>
" stack pointer
:map <F3> :Cprint $pc<CR>


" Needed for tmux and vim to play nice
map <Esc>[A <Up>
map <Esc>[B <Down>
map <Esc>[C <Right>
map <Esc>[D <Left>

" Console movement
cmap <Esc>[A <Up>
cmap <Esc>[B <Down>
cmap <Esc>[C <Right>
cmap <Esc>[D <Left>

" https://superuser.com/questions/401926/how-to-get-shiftarrows-and-ctrlarrows-working-in-vim-in-tmux
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
