set nu
set rnu
"set highlight
set incsearch
set ignorecase
set smartcase
set cindent
set autoindent
set wrapmargin=7
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
set cmdheight=2
nmap <C-j> :wa!<CR>
nnoremap <C-q> :qa<CR>
colorscheme industry

syntax on
filetype plugin indent on

" <C-o> switches to normal mode for one command,
" then switches back to insert mode
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>0
inoremap <C-d> <C-o><<

noremap gV '[v']
vnoremap < <gv
vnoremap > >gv
noremap Y y$

" Move with long lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" gtags-cscope
if filereadable("GTAGS")
  " To use the default key/mouse mapping:
   let GtagsCscope_Auto_Map = 1
  " To ignore letter case when searching:
   let GtagsCscope_Ignore_Case = 1
  " To use absolute path name:
  " let GtagsCscope_Absolute_Path = 1
  " To deterring interruption:
   let GtagsCscope_Keep_Alive = 1
  " If you hope auto loading:
   let GtagsCscope_Auto_Load = 1
  " To use 'vim -t ', ':tag' and '<C-]>'
  set cscopetag
  " To auto update tags when a file is saved 
  " let GtagsCscope_Auto_Update = 1
endif

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

Plug 'junegunn/fzf', {'do' : { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
Plug 'multilobyte/gtags-cscope'


" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" If you don't have nodejs and yarn
" use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
" see: https://github.com/iamcco/markdown-preview.nvim/issues/50
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Initialize plugin system
call plug#end()

if has("cscope")
	set csprg=/opt/homebrew//bin/cscope
	set csto=0
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
	    cs add cscope.out
	" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
	    cs add $CSCOPE_DB
	endif
	set csverb
endif

set rtp+=/opt/homebrew/bin/fzf

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>a :cs find a <C-R>=expand("<cword>")<CR><CR>

command! -nargs=1 Csfs :cs find s <args>
command! -nargs=1 Csfg :cs find g <args>
command! -nargs=1 Csfc :cs find c <args>
command! -nargs=1 Csft :cs find t <args>
command! -nargs=1 Csfe :cs find e <args>
command! -nargs=1 Csff :cs find f <args>
command! -nargs=1 Csfi :cs find i ^<args>
command! -nargs=1 Csfd :cs find d <args>
command! -nargs=1 Csfa :cs find a <args>

cnoreabbrev csfs Csfs 
cnoreabbrev csfg Csfg 
cnoreabbrev csfc Csfc 
cnoreabbrev csft Csft 
cnoreabbrev csfe Csfe 
cnoreabbrev csff Csff 
cnoreabbrev csfi Csfi 
cnoreabbrev csfd Csfd 
cnoreabbrev csfa Csfa 

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

:map * :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<C-M>
:map # :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<C-M>

nnoremap <C-9> :Tags<CR>
nnoremap <C-h> :History<CR>
nnoremap <C-n> :Buffers<CR>
nnoremap <C-p> :Files<CR>

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --glob "!.git/*" -g "!cscope.*" -g "!tags" -g "!out/*" -g "!*.o" -g  "!tmp/*" -g "!*.patch" --color "always" '.shellescape(<q-args>), 1, <bang>0)
nnoremap <C-k> :Find <C-r><C-w><CR>
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
set textwidth=80
