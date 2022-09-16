""""""""""""""""基础配置""""""""""""""""
"显示设置
set nu
set ruler
set cursorline
set cmdheight=2
set enc=utf-8
set termencoding=utf-8
set fileencodings=utf-8,gb2312,gbk,gb18030
"缩进
set smartindent
set cindent
set autoindent
set shiftwidth=4
set tabstop=4
"搜索
set hlsearch
set incsearch
"set ignorecase
"set smartcase
"其他
set wildmenu
set nocompatible
set noerrorbells
set nobackup
set nowb
set noswapfile
set autoread
set history=2000
set shortmess=atI
set completeopt=longest,menu
set mouse=a
set helplang=cn
set backspace=indent,eol,start
"set fileformats=unix
"set encoding=prc
"set list lcs=tab:\|\
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
filetype off
filetype indent on
filetype plugin indent on
filetype plugin on
syn on

"""""""""""""""""""""""""用vim-plug管理插件"""""""""""""""""""""""""
call plug#begin()

Plug 'boydos/emmet-vim' "html插件
Plug 'preservim/nerdtree' "目录树
Plug 'preservim/nerdcommenter' "注释插件
Plug 'jiangmiao/auto-pairs' "自动补全括号
Plug 'vim-airline/vim-airline' "状态栏美化
Plug 'Chiel92/vim-autoformat' "格式化代码
Plug 'tomasr/molokai' "配色
Plug 'neoclide/coc.nvim', { 'branch': 'release' } "自动补全利器，基于nodejs

call plug#end()
" coc配置
set nowritebackup
set updatetime=300
set signcolumn=yes
"tab切换待选项
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
"回车确定补全，C-g撤销
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"检查回退键
function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" 使用 `[g` and `]g` 诊断行跳转
" 使用 `:CocDiagnostics` 获取位置列表中当前缓冲区的所有诊断信息
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" 代码跳转.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" 按住光标时高亮显示符号及其引用.
autocmd CursorHold * silent call CocActionAsync('highlight')
" 符号重命名.
nmap <leader>rn <Plug>(coc-rename)
" 格式化选中代码.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

""""""""""""""""""""""""""""常用热键""""""""""""""""""""""""""""
"在当前文件和目录树之间切换光标焦点
"map <Tab> <C-w>w  
"调节目录树相对窗口大小
map l <C-w>>
map h <C-w><
map U <C-r> 
nnoremap s :w<CR>
nnoremap q ZZ
"格式化代码
noremap <F2> :Autoformat<CR>:Autoformat ><CR>
noremap <C-a> :Autoformat<CR>
"打开nerdtree
"alt+t 或 F3打开 插入模式先按ctrl+v，再按alt+键即可输入t
noremap t :NERDTreeToggle<CR>
noremap <F3> :NERDTreeToggle<CR>
"打开taglist
"noremap <F4> :TlistToggle<CR>
"打开/关闭粘贴模式
nnoremap <F4> :set invpaste paste?<CR>
imap <F4> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F4> 
"打开tagbar
noremap <F6> :TagbarToggle<CR>
"编译运行文件
map z :call CompileRunGcc()<CR>
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
"exec !gcc % -lm -lmysqlclient -lmosquitto -o %<
		exec "!gcc % -lm -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'rust'
		exec "!rustc %"
		exec "!time ./%<"
	elseif &filetype == 'sh'
		exec "!time bash %"
	elseif &filetype == 'php'
		exec "!time php %"
	elseif &filetype == 'python'
		exec "!time python3 %"
	elseif &filetype == 'html'
		exec "!firefox % &"
	elseif &filetype == 'go'
		exec "!go build %<"
		exec "!time go run %"
	elseif &filetype == 'mkd'
		exec "!~/.vim/markdown.pl % > %.html &"
		exec "!firefox %.html &"
	elseif &filetype == 'javascript'
		exec "!time node %"
	endif
endfunc

""""""""""""""""""""""""""""""""自动执行命令""""""""""""""""""""""""""""""""""""""""
""au bufwinenter * NERDTree
""autocmd VimEnter * wincmd p
"autocmd VimEnter * if argc() == 1 | tabedit % | endif


"""""""""""""""""主题"""""""""""""""""
"colorscheme molokai
colorscheme desert

"""""""""""""""""""实时格式化代码"""""""""""""""""""
"au InsertLeave *.c,*.cpp,*.sh :call Af()
func Af()
	if &filetype == 'c'
		:Autoformat
	elseif &filetype == 'cpp'
		:Autoformat
	elseif &filetype == 'sh'
		:Autoformat
	elseif &filetype == 'python'
		:Autoformat
	endif
endfunc

"""""""""""""""""""""窗口管理"""""""""""""""""""""
let g:winManagerWindowLayout='FileExplorer|TagList|NERDTree'
"nmap <F7> :WMToggle<cr>

""""""""""""""""""""""""""""nerdtree配置""""""""""""""""""""""""""""
let NERDTreeHighlightCursorline = 1       " 高亮当前行
let NERDTreeShowLineNumbers     = 1       " 显示行号
let g:NERDTreeWinSize=20
" 忽略列表中的文件
let NERDTreeIgnore = [ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.egg$', '^\.git$', '^\.repo$', '^\.svn$', '^\.hg$' ]
" 启动 vim 时打开 NERDTree
"autocmd vimenter * NERDTree
" 当打开 VIM，没有指定文件时和打开一个目录时，打开 NERDTree
"autocmd StdinReadPre * let s:std_in = 1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" 关闭 NERDTree，当没有文件打开的时候
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" <leader>nt 打开 nerdtree 窗口，在左侧栏显示
map <leader>nt :NERDTreeToggle<CR>
" <leader>tc 关闭当前的 tab
map <leader>tc :tabc<CR>
" <leader>to 关闭所有其他的 tab
map <leader>to :tabo<CR>
" <leader>ts 查看所有打开的 tab
map <leader>ts :tabs<CR>
" <leader>tp 前一个 tab
"nmap tp :tabp<CR>
" <leader>tn 后一个 tab
"nmap tn :tabn<CR>
""""""""""""""""""""""状态栏显示配置""""""""""""""""""""""
let g:airline_powerline_fonts                   = 1 " 使用 powerline 打过补丁的字体
let g:airline#extensions#tabline#enabled        = 1 " 开启 tabline
"let g:airline#extensions#tabline#buffer_nr_show = 1 " 显示 buffer 编号
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_left_sep          = '|'
let g:airline_left_alt_sep      = '|'
let g:airline_right_sep         = '|'
let g:airline_right_alt_sep     = '|'
let g:airline_symbols.crypt     = '?'
let g:airline_symbols.linenr    = '|'
let g:airline_symbols.branch    = '|'
" 切换 buffer
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>
" 关闭当前 buffer
"noremap <C-x> :w<CR>:bd<CR>
" <leader>1~9 切到 buffer1~9
map <leader>1 :b 1<CR>
map <leader>2 :b 2<CR>
map <leader>3 :b 3<CR>
map <leader>4 :b 4<CR>
map <leader>5 :b 5<CR>
map <leader>6 :b 6<CR>
map <leader>7 :b 7<CR>
map <leader>8 :b 8<CR>
map <leader>9 :b 9<CR>


