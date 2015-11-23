"[环境]->begin{{{
if has("gui_running")
	let g:isGUI = 1
else 
	let g:isGUI = 0
endif
"[环境]->end}}}

"[路径]->begin{{{
"swap的保存路径，一定要保证路径存在
set dir=$VIM/swaptemp
"[路径]->end}}}

"[前置]->begin{{{
set nocompatible "设置不兼容
set nobackup "不备份
set noswapfile "禁止生成临时文件
"[前置]->end}}}

"[界面]->begin{{{
set shortmess=atI "不显示孤儿帮助
set go= "去工具栏
set guioptions-=m "去菜单栏
"[界面]->end}}}

"[乱码]->begin{{{
"软件内部使用的编码与文件编码区分开
set encoding=utf-8

"下面两行解决右键菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

"解决终端输出乱码
if has("win32") || has("win64")
		language messages zh_CN.UTF-8
endif
"[乱码]->end}}}

"[显示]-begin{{{
syntax on "语法显示高亮
syntax enable "开启语法高亮功能
set t_Co=256 "终端配色
set number "显示行
set showmatch "高亮显示括号到匹配
set showcmd "显示命令
set cursorline "突出当前行
set cursorcolumn "突出当前列
set background=light "背景色
set completeopt="menu" "补全不需要生成预览，破坏整体感也不大方便[主要是YCM需要用这个]

if has('gui_running')
	colorscheme torte
else
	colorscheme murphy
endif
"colorscheme solarized
"let g:solarized_termcolor=16
"let g:solarized_termtrans=1
"[显示]->end}}}

"[缩进]->begin{{{
set tabstop=4 "tabs缩进
set smartindent "智能缩进
set autoindent "自动缩进
set cindent "C对齐
"[缩进]->end}}}

"[搜索]->begin{{{
set incsearch "光标定位到查找结果
set hls "高亮搜索结果
set ic "忽略大小写
set nowrapscan "不循环查找
"[搜索]->end}}}

"[文件]->begin{{{
filetype on
filetype plugin indent on
"依次判断文件的编码
"set fileencodings=ucs-bom,utf-8,cp936,gk2312,gb18030,gbk,big5,euc-jp,euc-kr,latin1
set fileencodings=ucs-bom,utf-8,gk2312,gb18030,gbk,big5,euc-jp,euc-kr,latin1
"set fileencodings=utf-8,utf-16,gbk2312,gk2312,gk18030,gbk
"[文件]->end}}}

"[折叠]->begin{{{
:highlight Folded guibg=black
set foldmethod=marker
nnoremap<silent>  <space> @=((foldclosed(line('.')) < 0)?'zc':'zo')<CR>
"[折叠]->end}}}

"[复制]->begin{{{
imap <C-v> <C-o>:set paste<CR><C-R>+<C-o>:set nopaste<CR><C-o>:echo "paste done"<C-R>
imap <C-v> <C-r>+

vmap <C-c> Y:echo "Copy Done"<CR>
vmap Y "+y:echo "Copy Done"<CR>
"[复制]->end}}}

"[鼠标]->begin{{{
set mouse=a	"允许鼠标定位光标
set selection=exclusive
"set selectmode=mouse,key
"[鼠标]->end}}}

"[键盘]->begin{{{
let mapleader="," "映射<Leader>
set backspace=indent,eol,start "backspace键映射三种回退
"编辑状态下光标移动
imap <M-k> <Up>
imap <M-j> <Down>
imap <M-h> <Left>
imap <M-l> <Right>
"[键盘]->end}}}

"[插件]->begin{{{

"[Vundle]->begin{{{
filetype off
set rtp+=$VIM/vimfiles/bundle/vundle/

call vundle#begin("$VIM/vimfiles/bundle/")
Bundle 'gmarik/vundle'
"Bundle 'altercation/vim-colors-solarized' "一个主题
Bundle 'Align'
Bundle 'std_c.zip'
"FuzzyFinder需要L9库
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'bling/vim-airline'
Bundle 'bling/vim-bufferline'
Bundle 'jiangmiao/auto-pairs'
Bundle 'taglist.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'TxtBrowser'
Bundle 'Valloric/YouCompleteMe'
Bundle 'majutsushi/tagbar'
Bundle 'SirVer/ultisnips'
"Bundle 'https://github.com/nathanaelkane/vim-indent-guides.git'
call vundle#end()

filetype plugin indent on
"[Vundle]->end}}}

"[FuzzyFinder]-begin{{{
"文件内按行号、内容搜索
nnoremap <silent> <Leader>l :FufLine<CR> 
"当前目录搜索文件
nnoremap <silent> <Leader>f :FufFile<CR> 
"搜索目录
nnoremap <silent> <Leader>d :FufDir<CR>
"搜索缓冲区
nnoremap <silent> <Leader>b :FufBuffer<CR>
"nnoremap <silent> <C-S-c> :FufMruCmd<CR>
"搜索跳转列表
nnoremap <silent> <Leader>j :FufJumpList<CR>
"[FuzzyFinder]-end}}} 

"[airline]->begin{{{
""https://github.com/powerline/fonts(fonts)"
let g:airline_section_y = 'BN:%{bufnr("%")}'
let g:airline_detect_modified=1
let g:airline_detect_paste=1
set laststatus=2
if g:isGUI
	if has('win32')||has('win64')
		set guifont=Droid_Sans_Mono_for_Powerline:h11

		if !exists('g:airline_symbols')
				let g:airline_symbols = {}
		endif

		let g:airline_left_sep = '⮀'
		let g:airline_left_alt_sep = '⮁'
		let g:airline_right_sep = '⮂'
		let g:airline_right_alt_sep = '⮃'
		let g:airline_symbols.branch = '⭠'
		let g:airline_symbols.readonly = '⭤'
		let g:airline_symbols.linenr = '⭡'
	else
		set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 12
	endif
let g:airline_powerline_fonts=1 
endif

let g:airline_theme="powerlineish"
let g:airline_detect_modified = 1
let g:airline_detect_paste = 1
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#bufferline#overwrite_variables = 0
"[airline]->end}}}

"[snipMate]->begin{{{ 
"1、snipmate与YCM冲突[YCM一旦弹出候选词,snip的原始映射会失效]
"2、snipmate没有修改映射键的配置，所以需要修改snipmate.vim,将映射修改如此可以避免，主要是第一条，第二条顺便改一下。
"ino <M-i> <esc>a<c-r>=TriggerSnippet()<cr>
"snor <M-i> <esc>i<right><c-r>=TriggerSnippet()<cr>
"[snipMate]->end}}}

"[NERDTree配置]->begin"{{{
let NERDTreeDirArrows=1
let g:NERDTreeIgnore = ['\.vim$', '\~$','\.d$','\.o$','\.so$']
nnoremap <F2> :NERDTreeToggle<cr> "显示和隐藏进行切换"
"[NERDTree配置]->end "}}}

"[YouCompleteMe]->begin{{{
let g:ycm_global_ycm_extra_conf = 'F:\Program Files (x86)\Vim\vimfiles\bundle\YouCompleteMe\third_party\ycmd\cpp\ycm\.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 1 "无需提示确认，直接加载文件conf
let g:ycm_enable_diagnostic_signs = 0 "关闭错误高亮,当前不是很实用
let g:ycm_enable_diagnostic_highlighting = 0 "和上面一样一起关了
let g:ycm_auto_start_csharp_server = 0 "关闭自动开启c#的服务
"let g:ycm_use_ultisnips_completer = 0 "没有安装ultsnips，所以关闭
let g:ycm_complete_in_comments = 1 "在注释中也使用补全
"[YouCompleteMe]->end}}}

"[txtbrowser]->begin{{{
filetype plugin on 
au BufEnter *.txt setlocal ft=txt
let Txtbrowser_Search_Engine='http://www.baidu.com/s?wd=text&oq=text&f=3&rsp=2' "搜索引擎
let TxtBrowser_Dict_Url='http://dict.cn/text' "字典
"}}}[txtbrowser]->end

"[indent-line]->begin{{{
"let g:indent_guides_auto_colors = 0
"let g:indent_guides_guide_size = 1 
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
"hi IndentGuidesOdd guibg=red ctermbg=3
"hi IndentGuidesEven guibg=green ctermbg=4
"[indent-line]->end}}}

"[taglist]->begin{{{
nmap <F8> :silent! !ctags -R –c++-kinds=+px –fields=+iaS –extra=+q .<CR>

"nmap <F10> :silent! Tlist<CR>
"let Tlist_Ctags_Cmd='ctags' "生成taglist的程序,需在环境变量加入
"let Tlist_Use_Right_Window=1 "窗口在右边
"let Tlist_Show_One_File=1 "展示多个文件的函数列表
"let Tlist_File_Fold_Auto_Close=1 "非当前文件函数列表折叠隐藏
"let Tlist_Exit_OnlyWindow=0 "taglist为最后一个窗口时是否退出vim
"let Tlist_Process_File_Always=0 "是否一致更新tags
"[taglist]->end}}}

"[Tagbar->begin]{{{
nmap <F10> :silent! TagbarToggle<CR>
autocmd FileType c,cpp nested :TagbarOpen
"[Tagbar->end]}}}

"[tags路径]{{{
set tags=F:/nginx-1.9.6/src/tags
"}}}

"[插件]->end}}}
