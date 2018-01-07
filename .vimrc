" This is leoatchina's vim config forked from https://github.com/spf13/spf13-vim
" Sincerely thank him for his great job, and I have made some change according to own requires.
" These ones whole use this config can also make changes,
" For my pool English , I sometimes type in Chines comments
"                    __ _ _____              _
"         ___ _ __  / _/ |___ /      __   __(_)_ __ ___
"        / __| '_ \| |_| | |_ \ _____\ \ / /| | '_ ` _ \
"        \__ \ |_) |  _| |___) |_____|\ V / | | | | | | |
"        |___/ .__/|_| |_|____/        \_/  |_|_| |_| |_|
"            |_|
" You can find spf13's greate config at http://spf13.com
" Os detect functions have been move to .vimrc.bundles
" Basics
set nocompatible        " Must be first line
set background=dark     " Assume a dark background
set mouse=a             " Automatically enable mouse usage
set mousehide           " Hide the mouse cursor while typing

" Use before config
if filereadable(expand("~/.vimrc.before"))
    source ~/.vimrc.before
endif
" Use bundles config
if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif

set noimdisable
set shortmess+=c
set encoding=utf-8
scriptencoding utf-8
set fileencodings=utf-8,chinese,latin-1,gbk,gb18030,gk2312

" set timeout
set timeout
set timeoutlen=500 ttimeoutlen=50


" Gui
if !has('gui')
    if !has('nvim')
        set term=$TERM          " Make arrow and other keys work
    endif
elseif WINDOWS()
    set guifont=YaHei\ Consolas\ Hybrid:h11
endif

" Arrow Key Fix
" https://github.com/spf13/spf13-vim/issues/780
if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
    inoremap <silent> <C-[>OC <RIGHT>
endif

" Clipboard
if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else         " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif
" Key (re)Mappings
" The default leader is '\', spf13 prefer ';' as it's in a standard location
" But leatchina prefer space. To override this behavior and set it back to '\'
" (or any other character) add the following to your .vimrc.before.local file:
if !exists('g:spf13_leader')
    let mapleader=' '
else
    let mapleader=g:spf13_leader
endif
if !exists('g:spf13_localleader')
    let maplocalleader = '\'
else
    let maplocalleader=g:spf13_localleader
endif
" 不同文件类型加载不同插件
filetype plugin indent on   " Automatically detect file types.
filetype on                 " 开启文件类型侦测
filetype plugin on          " 根据侦测到的不同类型:加载对应的插件
syntax on
" take config into effect after saving
au! bufwritepost .vimrc source %
au! bufwritepost .vimrc.before source %
au! bufwritepost .vimrc.bundles source %
au! bufwritepost .vimrc.local source %
au! bufwritepost .vimrc.before.local source %
au! bufwritepost .vimrc.bundles.local source %
" Some useful shortcuts by spf13
" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>
" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>
" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null
" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
" Map <Leader>fw to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>fw [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>
" fullscreen mode for GVIM and Terminal, need 'wmctrl' in you PATH
if !WINDOWS()
    map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>
else
    au GUIEnter * simalt ~x
    " 按 F11 切换全屏
    noremap <F11> <esc>:call libcallnr('gvim_fullscreen.dll', 'ToggleFullscreen', 0)<cr>
    " 按 S-F11 切换窗口透明度
    noremap <S-F11> <esc>:call libcallnr('gvim_fullscreen.dll', 'ToggleTransparency', "247,180")<cr>
endif
set pastetoggle=<F12>      " pastetoggle (sane indentation on pastes)
noremap <leader>fp :set nopaste! nopaste?<CR>

" shortcuts by leatchina
if !exists('g:no_leoatchina_config')
    " move to last or first position of a line
    nmap <silent><C-e> $
    vmap <silent><C-e> $
    inoremap <silent><expr> <C-e> pumvisible()? "\<C-e>":"\<ESC>A"

    nmap <silent><C-y> ^
    vmap <silent><C-y> ^
    inoremap <silent><expr> <C-y> pumvisible()? "\<C-y>":"\<ESC>I"
    nmap <silent><C-m> %
    vmap <silent><C-m> %
    if isdirectory(expand("~/.vim/bundle/vim-toggle-quickfix"))
        nmap <F10> <Plug>window:quickfix:toggle
        imap <F10> <Plug>window:quickfix:toggle
    endif
    " tab contral
    set tabpagemax=10 " Only show 10 tabs
    nnoremap <silent><F7>   :tabprevious<CR>
    nnoremap <silent><F8>   :tabnext<CR>
    nnoremap <leader><F7> :tabm -1<CR>
    nnoremap <leader><F8> :tabm +1<CR>
    nnoremap <leader>tn :tabnew<CR>
    nnoremap <Leader>ts :tabs<CR>
    nnoremap <Leader>tp :tab split<CR>
    nnoremap <Leader>te :tabe<SPACE>
    nnoremap <Leader>tm :tabm<SPACE>
    " 设置快捷键将选中文本块复制至系统剪贴板
    vnoremap  <leader>y  "+y
    nnoremap  <leader>y  "+y
    nnoremap  <leader>Y  "+yg
    nnoremap  <leader>yy  "+yy
    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$
    " p and P for paste
    nnoremap <leader>p "+p
    nnoremap <leader>P "+P
    vnoremap <leader>p "+p
    vnoremap <leader>P "+P
    " Easier horizontal scrolling
    map zl zL
    map zh zH
    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk
    "F1 help
    nmap <F1> :tab help<SPACE>
    "F2 toggleFold
    noremap <F2> :set nofoldenable! nofoldenable?<CR>
    noremap <leader>fd :set nofoldenable! nofoldenable?<CR>
    "F3 toggleWrap
    noremap <F3> :set nowrap! nowrap?<CR>
    noremap <leader>fr :set nowrap! nowrap?<CR>
    "F4 toggle hlsearch
    noremap <F4> :set nohlsearch! nohlsearch?<CR>
    noremap <leader>fh :set nohlsearch! nohlsearch?<CR>
    " F5运行脚本
    noremap <F5> :call CompileRunGcc()<CR>
    noremap <leader>R :call CompileRunGcc()<CR>
    func! CompileRunGcc()
        exec "w"
        if &filetype == 'c'
            exec "!g++ % -o %<"
            exec "!./%<"
        elseif &filetype == 'cpp'
            exec "!g++ % -o %<"
            exec "!./%<"
        elseif &filetype == 'java'
            exec "!javac %"
            exec "!java %<"
        elseif &filetype == 'sh'
            exec "!bash %"
        elseif &filetype == 'perl'
            exec "!perl %"
        elseif &filetype == 'go'
            exec "!go run %"
        endif
    endfunc
    " S-F5 time the program testing
    noremap <S-F5> :call TimeCompileRunGcc()<CR>
    func! TimeCompileRunGcc()
        exec "w"
        " asyncrun 是一个异步执行脚本的插件，要vim8.0以上才支持
        if isdirectory(expand("~/.vim/bundle/asyncrun.vim"))
            if &filetype == 'c'
                exec ":AsyncRun g++ % -o %<"
                exec ":AsyncRun ./%<"
            elseif &filetype == 'cpp'
                exec ":AsyncRun g++ % -o %<"
                exec ":AsyncRun ./%<"
            elseif &filetype == 'java'
                exec ":AsyncRun javac %"
                exec ":AsyncRun java %<"
            elseif &filetype == 'sh'
                exec ":AsyncRun bash %"
            elseif &filetype == 'python'
                exec ":AsyncRun python %"
            elseif &filetype == 'perl'
                exec ":AsyncRun perl %"
            elseif &filetype == 'go'
                exec ":AsyncRun go run %"
            endif
        else
            if &filetype == 'c'
                exec "!g++ % -o %<"
                exec "!time ./%<"
            elseif &filetype == 'cpp'
                exec "!g++ % -o %<"
                exec "!time ./%<"
            elseif &filetype == 'java'
                exec "!javac %"
                exec "!time java %<"
            elseif &filetype == 'sh'
                exec "!time bash %"
            elseif &filetype == 'python'
                exec "!time python %"
            elseif &filetype == 'perl'
                exec "!time perl %"
            elseif &filetype == 'go'
                exec "!time go run %"
            endif
        endif
    endfunc
    " buffer switch
    nnoremap <F6> :bn<CR>
    nnoremap <leader><F6> :bp<CR>
    " 定义快捷键保存当前窗口内容
    nmap <Leader>w :w<CR>
    nmap <Leader>W :wq!<CR>
    " 定义快捷键保存所有窗口内容并退出 vim
    nmap <Leader>WQ :wa<CR>:q<CR>
    " 定义快捷键关闭当前窗口
    nmap <Leader>q :q<CR>
    " 不做任何保存，直接退出 vim
    nmap <Leader>Q :qa!
    " Q
    nnoremap ~ Q
    nmap Q :q!
    " 设置分割页面
    nmap <Leader>- :split<Space>
    nmap <leader>\ :vsplit<Space>
    nmap <leader>= <C-W>=
    "设置垂直高度减增
    nmap <Leader>< :resize -3<CR>
    nmap <Leader>> :resize +3<CR>
    "设置水平宽度减增
    nmap <Leader>[ :vertical resize -3<CR>
    nmap <Leader>] :vertical resize +3<CR>
    "至左方的子窗口
    nnoremap <Leader>HH <C-W>H
    nnoremap <Leader>hh <C-W>h
    "至右方的子窗口
    nnoremap <Leader>LL <C-W>L
    nnoremap <Leader>ll <C-W>l
    "至上方的子窗口
    nnoremap <Leader>KK <C-W>K
    nnoremap <Leader>kk <C-W>k
    "至下方的子窗口
    nnoremap <Leader>JJ <C-W>J
    nnoremap <Leader>jj <C-W>j
    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv
    " Ctrl-m for switch between brackets
    map <C-m> %
endif
" Formatting
" auto close qfixwindows when leave vim
aug QFClose
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END
"set number                      " show line number
au BufWinEnter * set number
set autoindent                  " Indent at the same level of the previous line
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
" 不生成back文件
set nobackup
"set noswapfile
set nowritebackup
"set noundofile
" 关闭拼写检查
set nospell
" 关闭声音
set noeb
set vb
" 关闭列光标加亮
set nocursorcolumn
" 关闭行光标加亮
set nocursorline
" 允许折行
set wrap
" 不折叠
set nofoldenable
" 标签控制
set showtabline=2
" 开启实时搜索功能
set incsearch
" 显示光标当前位置
set ruler
" 高亮显示搜索结果
set hlsearch
set incsearch                   " Find as you type search
set smartcase                   " Case sensitive when uc present
set ignorecase                  " Case insensitive search
" 一些格式
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set showmatch                   " Show matching brackets/parenthesis
set winminheight=0              " Windows can be 0 line high
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespacetextwidth=200
set formatoptions-=tc           " Not aut break a line into multiple lines
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
" 没有滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
" 没有菜单和工具条
set guioptions-=m
set guioptions-=T
" 总是显示状态栏
set laststatus=2
" sepcial setting for different type of files
au BufNewFile,BufRead *.py
            \set shiftwidth=4
            \set tabstop=4
            \set softtabstop=4
            \set expandtab
            \set autoindent
            \set foldmethod=indent
au FileType python au BufWritePost <buffer> :%retab
" yaml
au BufNewFile,BufRead *.yml
            \set shiftwidth=2
            \set tabstop=2
            \set softtabstop=2
            \set expandtab
            \set autoindent
            \set foldmethod=indent
" Remove trailing whitespaces and ^M chars
au FileType markdown,vim,c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql,vim au BufWritePre <buffer> if !exists('g:spf13_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif
au BufNewFile,BufRead *.html.twig set filetype=html.twig
au BufNewFile,BufRead *.md,*.markdown set filetype=markdown
au BufNewFile,BufRead *.pandoc set filetype=pandoc
au FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
" preceding line best in a plugin but here for now.
au BufNewFile,BufRead *.coffee set filetype=coffee
" Workaround vim-commentary for Haskell
au FileType haskell setlocal commentstring=--\ %s
" Workaround broken colour highlighting in Haskell
au FileType haskell,rust setlocal nospell
" General
" Most prefer to automatically switch to the current file directory when
" a new buffer is opened; to prevent this behavior, add the following to
" your .vimrc.before.local file:
"   let g:spf13_no_autochdir = 1
if !exists('g:spf13_no_autochdir')
    au BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    " Always switch to the current file directory
endif
" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" Restore cursor to file position in previous editing session
" To disable this, add the following to your .vimrc.before.local file:
"   let g:spf13_no_restore_cursor = 1
if !exists('g:spf13_no_restore_cursor')
    function! ResCur()
        if line("'\"") <= line("$")
            silent! normal! g`"
            return 1
        endif
    endfunction
    augroup resCur
        au!
        au BufWinEnter * call ResCur()
    augroup END
endif
" To disable views add the following to your .vimrc.before.local file:
"   let g:spf13_no_views = 1
if !exists('g:spf13_no_views')
    " Add exclusions to mkview and loadview
    " eg: *.*, svn-commit.tmp
    let g:skipview_files = [
                \ '\[example pattern\]'
                \ ]
endif
" Vim UI
if !exists('g:override_spf13_bundles') && !exists('g:no_colorscheme')
    if count(g:spf13_bundle_groups, 'material') && isdirectory(expand("~/.vim/bundle/vim-quantum"))
        set background=dark
        set termguicolors
        colorscheme quantum
    else
        if  filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
            let g:solarized_termcolors=256
            let g:solarized_termtrans=1
            let g:solarized_visibility="normal"
            colorscheme solarized
            color solarized
        endif
    endif
endif
if has('cmdline_info')
    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                 " Show partial commands in status line and
endif
if has('statusline')
    set laststatus=2
    " Broken down into easily includeable segments
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    if !exists('g:override_spf13_bundles')
        if isdirectory(expand("~/.vim/bundle/fugitive"))
            set statusline+=%{fugitive#statusline()} " Git Hotness
        endif
    endif
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif
" End/Start of line motion keys act relative to row/wrap width in the
" presence of `:set wrap`, and relative to line for `:set nowrap`.
" Default vim behaviour is to act relative to text line in both cases
" If you prefer the default behaviour, add the following to your
" .vimrc.before.local file:
"   let g:spf13_no_wrapRelMotion = 1
if !exists('g:spf13_no_wrapRelMotion')
    " Same for 0, home, end, etc
    function! WrapRelativeMotion(key, ...)
        let vis_sel=""
        if a:0
            let vis_sel="gv"
        endif
        if &wrap
            execute "normal!" vis_sel . "g" . a:key
        else
            execute "normal!" vis_sel . a:key
        endif
    endfunction

    " Map g* keys in Normal, Operator-pending, and Visual+select
    noremap $ :call WrapRelativeMotion("$")<CR>
    noremap 0 :call WrapRelativeMotion("0")<CR>
    noremap ^ :call WrapRelativeMotion("^")<CR>
    " Overwrite the operator pending $/<End> mappings from above
    " to force inclusive motion with :execute normal!
    onoremap $ v:call WrapRelativeMotion("$")<CR>
    onoremap <End> v:call WrapRelativeMotion("$")<CR>
    " Overwrite the Visual+select mode mappings from above
    " to ensuwe the correct vis_sel flag is passed to function
    vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
    vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
    vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
    vnoremap <Home> :<C-U>call WrapRelativeMotion("^", 1)<CR>
    vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>
endif
" Stupid shift key fixes
if !exists('g:spf13_no_keyfixes')
    if has("user_commands")
        command! -bang -nargs=* -complete=file E e<bang> <args>
        command! -bang -nargs=* -complete=file W w<bang> <args>
        command! -bang -nargs=* -complete=file Wq wq<bang> <args>
        command! -bang -nargs=* -complete=file WQ wq<bang> <args>
        command! -bang Wa wa<bang>
        command! -bang WA wa<bang>
        command! -bang Q q<bang>
        command! -bang QA qa<bang>
        command! -bang Qa qa<bang>
    endif
    cmap Tabe tabe
endif
" Plugins
" ywvim,vim里的中文输入法
if isdirectory(expand("~/.vim/bundle/ywvim"))
    let g:ywvim_ims=[
                \['wb', '五笔', 'wubi.ywvim'],
                \['py', '拼音', 'pinyin.ywvim'],
                \]
    let g:ywvim_py = { 'helpim':'wb', 'gb':0 }
    let g:ywvim_zhpunc = 0
    let g:ywvim_listmax = 8
    let g:ywvim_esc_autoff = 1
    let g:ywvim_autoinput = 2
    let g:ywvim_circlecandidates = 1
    let g:ywvim_helpim_on = 0
    let g:ywvim_matchexact = 0
    let g:ywvim_chinesecode = 1
    let g:ywvim_gb = 0
    let g:ywvim_preconv = 'g2b'
    let g:ywvim_conv = ''
    let g:ywvim_lockb = 1
    imap <silent> <C-\> <C-R>=Ywvim_toggle()<CR>
    cmap <silent> <C-\> <C-R>=Ywvim_toggle()<CR>
endif
" Ag
if isdirectory(expand("~/.vim/bundle/ag.vim"))
    nnoremap <leader>ag :Ag<space>
    nnoremap <leader>af :AgFile<space>
    let g:ag_working_path_mode="r"
    set runtimepath^=~/.vim/bundle/ag.vim"
endif
" NerdTree
if isdirectory(expand("~/.vim/bundle/nerdtree"))
    nmap <leader>nn :NERDTreeTabsToggle<CR>
    nmap <leader>nf :NERDTreeFind<CR>

    let g:NERDShutUp=1
    let s:has_nerdtree = 1
    let g:nerdtree_tabs_open_on_gui_startup=0
    let g:nerdtree_tabs_open_on_console_startup = 0
    let g:nerdtree_tabs_smart_startup_focus = 2
    let g:nerdtree_tabs_focus_on_files = 1
    let g:NERDTreeWinSize=30
    let g:NERDTreeShowBookmarks=1
    let g:nerdtree_tabs_smart_startup_focus = 0
    let g:NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
    let g:NERDTreeChDirMode=0
    let g:NERDTreeQuitOnOpen=1
    let g:NERDTreeMouseMode=2
    let g:NERDTreeShowHidden=1
    let g:NERDTreeKeepTreeInNewTab=1
    let g:nerdtree_tabs_focus_on_files = 1
    let g:nerdtree_tabs_open_on_gui_startup = 0
    let g:NERDTreeWinPos=0
    let g:NERDTreeDirArrowExpandable = '▸'
    let g:NERDTreeDirArrowCollapsible = '▾'
    au bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif
    " nerdtree-git
    if isdirectory(expand("~/.vim/bundle/nerdtree-git-plugin"))
        let g:NERDTreeIndicatorMapCustom = {
                    \ "Modified"  : "*",
                    \ "Staged"    : "+",
                    \ "Untracked" : "★",
                    \ "Renamed"   : "→ ",
                    \ "Unmerged"  : "=",
                    \ "Deleted"   : "X",
                    \ "Dirty"     : "●",
                    \ "Clean"     : "√",
                    \ "Unknown"   : "?"
                    \ }
    endif
endif
" Shell
if isdirectory(expand("~/.vim/bundle/vimshell.vim"))
    nmap <C-k>v :vsplit<cr>:VimShell<cr>
    nmap <C-k>s :split<cr>:VimShell<cr>
    nmap <C-k>V :VimShell<Space>
    nmap <C-k>S :VimShellSendBuffer<Space>
    nmap <C-k>c :VimShellClose<Cr>
    nmap <C-k>t :VimShellTab<Space>
    nmap <C-k>p :VimShellPop<Space>
    nmap <C-k>d :VimShellCurrentDir<Space>
    nmap <C-k>b :VimShellBufferDir<Space>
    nmap <C-k>e :VimShellExecute<Space>
    nmap <C-k>i :VimShellInteractive<Space>
    nmap <C-k>n :VimShellCreate<Space>
    vmap <C-k>  :VimShellSendString<cr>
    let g:vimshell_prompt_expr = 'escape(fnamemodify(getcwd(), ":~").">", "\\[]()?! ")." "'
    let g:vimshell_prompt_pattern = '^\%(\f\|\\.\)\+> '
    let g:vimshell_force_overwrite_statusline=1
endif
" VOom
if isdirectory(expand("~/.vim/bundle/VOom"))
    let g:voom_ft_modes = {'md':'markdown','markdown': 'markdown', 'pandoc': 'pandoc','c':'fmr2', 'cpp':'fmr2', 'python':'python','vim':'vimwiki'}
    nmap <silent><leader>vt :VoomToggle<CR>
    nmap <leader>vo :Voom<Space>
endif
" markdown
if isdirectory(expand("~/.vim/bundle/markdown-preview.vim"))
    nmap <leader>mk <Plug>MarkdownPreview
    if OSX()
        let g:mkdp_path_to_chrome = "OPEN -a Google\\ Chrome"
    else
        let g:mkdp_path_to_chrome = "google-chrome"
    endif
endif
" PIV
if isdirectory(expand("~/.vim/bundle/PIV"))
    let g:DisableAutoPHPFolding = 0
    let g:PIVAutoClose = 0
endif
" fugitive
if isdirectory(expand("~/.vim/bundle/vim-fugitive"))
    nmap <leader>GG :Git<Space>
endif
" AsyncRun
if isdirectory(expand("~/.vim/bundle/asyncrun.vim"))
    nmap <Leader><F5> :AsyncRun<Space>
endif
" Misc
if isdirectory(expand("~/.vim/bundle/matchit.zip"))
    let b:match_ignorecase = 1
endif
" TagBar
if isdirectory(expand("~/.vim/bundle/tagbar/"))
    set tags=./tags;/,~/.vimtags
    " Make tags placed in .git/tags file available in all levels of a repository
    let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
    if gitroot != ''
        let &tags = &tags . ',' . gitroot . '/.git/tags'
    endif
    nmap <silent><leader>tt :TagbarToggle<CR>
    nnoremap <silent><leader>jt :TagbarOpen j<CR>
    let g:tagbar_sort = 0
    " AutoCloseTag
    " Make it so AutoCloseTag works for xml and xhtml files as well
    au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
    nmap <Leader>ta <Plug>ToggleAutoCloseMappings
endif
" Tabularize
if isdirectory(expand("~/.vim/bundle/tabular"))
    vmap <C-t>& :Tabularize /&<CR>
    vmap <C-t>% :Tabularize /%<CR>
    vmap <C-t>$ :Tabularize /\$<CR>
    vmap <C-t>= :Tabularize /^[^=]*\zs=<CR>
    vmap <C-t>=> :Tabularize /=><CR>
    vmap <C-t>: :Tabularize /:<CR>
    vmap <C-t>:: :Tabularize /:\zs<CR>
    vmap <C-t>, :Tabularize /,<CR>
    vmap <C-t>,, :Tabularize /,\zs<CR>
    vmap <C-t>. :Tabularize /\.<CR>
    vmap <C-t><Bar> :Tabularize /<Bar><CR>
endif
" Session List
set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
if isdirectory(expand("~/.vim/bundle/sessionman.vim/"))
    nmap <leader>sl : SessionList<CR>
    nmap <leader>ss : SessionSave<CR>
    nmap <leader>sc : SessionClose<CR>n
endif
" Nvim-R
if isdirectory(expand("~/.vim/bundle/Nvim-R"))
    let R_rconsole_width = 0
    let R_objbr_place = "script,right"
    " R console windows
    au VimResized * let R_rconsole_height = winheight(0) /3
    let R_objbr_h = 25
    let R_objbr_opendf = 1    " Show data.frames elements
    let R_objbr_openlist = 1  " Show lists elements
    let R_objbr_allnames = 0  " Show .GlobalEnv hidden objects
    let R_objbr_labelerr = 1  " Warn if label is not a valid text
    let R_in_buffer = 1
    let R_hl_term = 1
    let R_close_term = 1
    let Rout_more_colors = 1
    let R_hi_fun_paren = 1
    let R_rmd_environment = "new.env()"
    nmap <leader>rr <localleader>rf<localleader>ro<C-w>h
    nmap <leader>rq <localleader>rq
endif
" GoLang
if count(g:spf13_bundle_groups, 'go')
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1
    let g:go_fmt_command = "goimports"
    let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
    let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
    au FileType go nmap <Leader>S <Plug>(go-implements)
    au FileType go nmap <Leader>S <Plug>(go-info)
    au FileType go nmap <Leader>E <Plug>(go-rename)
    au FileType go nmap <leader>R <Plug>(go-run)
    au FileType go nmap <leader>B <Plug>(go-build)
    au FileType go nmap <leader>T <Plug>(go-test)
    au FileType go nmap <Leader>gd <Plug>(go-doc)
    au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
    au FileType go nmap <leader>co <Plug>(go-coverage)
endif
" JSON
nmap <leader>jst <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
let g:vim_json_syntax_conceal = 0
" PyMode
if isdirectory(expand("~/.vim/bundle/python-mode"))
    " Disable if python support not present
    if !has('python') && !has('python3')
        let g:pymode = 0
    endif
    " python version
    if has('python3')
        let g:pymode_python = 'python3'
    else
        let g:pymode_python = 'python'
    endif
    " pymode check
    let g:pymode_lint = 1
    nmap <F9> :PymodeLint<CR>
    let g:pymode_lint_signs = 1
    let g:pymode_trim_whitespaces = 1
    let g:pymode_options = 0
    " no check when white
    let g:pymode_lint_on_write = 0
    " check when save
    let g:pymode_lint_unmodified = 0
    " not check of fly
    let g:pymode_lint_on_fly = 0
    " show message of error line
    let g:pymode_lint_message = 1
    " checkers
    let g:pymode_lint_checkers = ['pyflakes','pep8']
    "let g:pymode_lint_checkers = ['pep8']
    let g:pymode_lint_ignore = "E128,E2,E3,E501"
    " not Auto open cwindow (quickfix) if any errors have been found
    let g:pymode_lint_cwindow = 0
    " python syntax highlight
    if isdirectory(expand("~/.vim/bundle/python-syntax"))
        let g:pymode_syntax = 0
        let g:pymode_syntax_all = 0
    else
        let g:pymode_syntax = 1
        let g:pymode_syntax_all = 1
    endif
    " doc for python
    let g:pymode_doc = 0
    " motion
    let g:pymode_motion = 1
    " run python
    let g:pymode_run_bind = '<F5>'
    " breakpoint
    let g:pymode_breakpoint = 1
    let g:pymode_breakpoint_bind = '<C-g>'
    let g:pymode_breakpoint_cmd = 'import pdb;pdb.set_trace()'
    " disable pymode_rope and pymode_folding for slow problem
    let g:pymode_rope = 0
    let g:pymode_folding = 0
endif
if isdirectory(expand("~/.vim/bundle/python-syntax"))
    let g:python_highlight_all = 1
endif
" ctrlp
if isdirectory(expand("~/.vim/bundle/ctrlp.vim/"))
    let g:ctrlp_working_path_mode = 'ar'
    nnoremap <silent> <D-t> :CtrlP<CR>
    nnoremap <silent> <D-r> :CtrlPMRU<CR>
    let g:ctrlp_custom_ignore = {
                \ 'dir':  '\.git$\|\.hg$\|\.svn$',
                \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }
    if executable('ag')
        let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
    elseif executable('ack-grep')
        let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
    elseif executable('ack')
        let s:ctrlp_fallback = 'ack %s --nocolor -f'
        " On Windows use "dir" as fallback command.
    elseif WINDOWS()
        let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
    else
        let s:ctrlp_fallback = 'find %s -type f'
    endif
    if exists("g:ctrlp_user_command")
        unlet g:ctrlp_user_command
    endif
    let g:ctrlp_user_command = {
                \ 'types': {
                \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ },
                \ 'fallback': s:ctrlp_fallback
                \ }
    if isdirectory(expand("~/.vim/bundle/ctrlp-funky/"))
        " CtrlP extensions
        let g:ctrlp_extensions = ['funky']
        " funky
        nnoremap <Leader>fu :CtrlPFunky<Cr>
    endif
endif
" Rainbow
if isdirectory(expand("~/.vim/bundle/rainbow/"))
    let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
endif
" Youcompleteme
if g:completable == 1
    au InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后关闭预览窗口
    let g:ycm_python_binary_path = 'python'
    let g:acp_enableAtStartup = 0
    let g:ycm_add_preview_to_completeopt = 1
    "  补全后关键窗口
    let g:ycm_autoclose_preview_window_after_completion = 1
    "  插入后关键窗口
    let g:ycm_autoclose_preview_window_after_insertion = 1
    " enable completion from tags
    let g:ycm_collect_identifiers_from_tags_files = 1
    let g:ycm_key_invoke_completion = '<Tab>'
    let g:ycm_key_list_select_completion = ['<C-n>','<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p','<Up>']
    let g:ycm_filetype_blacklist = {
                \ 'tagbar' : 1,
                \ 'nerdtree' : 1,
                \}
    let g:ycm_filetype_whitelist = {
                \ 'cpp': 1,
                \ 'c': 1,
                \ 'perl':1,
                \ 'python':1,
                \ 'vim':1,
                \ 'js':1,
                \ 'html':1,
                \ 'php':1,
                \}
    " Haskell post write lint and check with ghcmod
    " $ `cabal install ghcmod` if missing and ensure
    " ~/.cabal/bin is in your $PATH.
    if !executable("ghcmod")
        au BufWritePost *.hs GhcModCheckAndLintAsync
    endif
    let g:ycm_confirm_extra_conf=1 "加载.ycm_extra_conf.py提示
    let g:ycm_collect_identifiers_from_tags_files=1    " 开启 YC基于标签引擎
    let g:ycm_min_num_of_chars_for_completion=2   " 从第2个键入字符就开始罗列匹配项
    let g:ycm_cache_omnifunc=0 " 禁止缓存匹配项,每次都重新生成匹配项
    let g:ycm_seed_identifiers_with_syntax=1   " 语法关键字补全
    ""在注释输入中也能补全
    let g:ycm_complete_in_comments = 1
    "在字符串输入中也能补全
    let g:ycm_complete_in_strings = 1
    "注释和字符串中的文字也会被收入补全
    let g:ycm_collect_identifiers_from_comments_and_strings = 0
    " 跳转到定义处
    nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
    imap <expr><C-j> pumvisible()? "\<C-y>":"\<CR>"
    smap <expr><C-j> pumvisible()? "\<C-y>":"\<CR>"
    " nvim completion
elseif g:completable == 2
    imap <expr><C-j> pumvisible()? "\<C-y>":"\<CR>"
    smap <expr><C-j> pumvisible()? "\<C-y>":"\<CR>"
    " deoplete
elseif g:completable == 3
    let g:deoplete#enable_at_startup = 1
    if !has('nvim')
        let g:deoplete#enable_yarp=1
    endif
    let g:deoplete#enable_camel_case=1
    " Enable heavy omni completion.
    if !exists('g:deoplete#keyword_patterns')
        let g:deoplete#keyword_patterns = {}
        let g:deoplete#keyword_patterns.tex = '\\?[a-zA-Z_]\w*'
    endif
    if !exists('g:deoplete#omni_patterns')
        let g:deoplete#omni_patterns = {}
        let g:deoplete#omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
        let g:deoplete#omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
        let g:deoplete#omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
        let g:deoplete#omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
        let g:deoplete#omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
        let g:deoplete#omni_patterns.go = '\h\w*\.\?'
        let g:deoplete#omni_patterns.java = '[^. *\t]\.\w*'
    endif
    " <BS>: close popup and delete backword char.
    inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
    " c-j to complete pum
    imap <expr><C-j> pumvisible()? deoplete#close_popup():'\<CR>'
    smap <expr><C-j> pumvisible()? deoplete#close_popup():'\<CR>'
    if g:use_ultisnips
        call deoplete#custom#set('ultisnips', 'matchers', ['matcher_fuzzy'])
    endif
    " neocomplete
elseif g:completable == 4
    let g:acp_enableAtStartup = 1
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_auto_select = 0
    let g:neocomplete#enable_camel_case = 1
    let g:neocomplete#enable_auto_delimiter = 0
    let g:neocomplete#max_list = 15
    let g:neocomplete#force_overwrite_completefunc = 1
    " Define keyword.
    if !exists('g:neocomplete_keyword_patterns')
        let g:neocomplete_keyword_patterns = {}
        let g:neocomplete_keyword_patterns.tex = '\\?[a-zA-Z_]\w*'
    endif
    " Define dictionary.
    let g:neocomplete_dictionary_filetype_lists = {
                \ 'default' : '',
                \ 'vimshell' : $HOME.'/.vimshell_hist',
                \ 'scheme' : $HOME.'/.gosh_completions'
                \ }
    " Enable heavy omni completion.
    if !exists('g:neocomplete_omni_patterns')
        let g:neocomplete_omni_patterns = {}
        let g:neocomplete_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
        let g:neocomplete_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
        let g:neocomplete_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
        let g:neocomplete_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
        let g:neocomplete_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
        let g:neocomplete_omni_patterns.go = '\h\w*\.\?'
    endif
    " <BS>: close popup and delete backword char.
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    "   to complete pum
    imap <expr><C-j> pumvisible()? neocomplete#close_popup():"\<CR>"
    smap <expr><C-j> pumvisible()? neocomplete#close_popup():"\<CR>"
    " neocomplcache
elseif g:completable == 5
    let g:neocomplcache_enable_insert_char_pre = 1
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_auto_select = 0
    let g:neocomplcache_enable_camel_case_completion = 1
    let g:neocomplcache_enable_smart_case = 1
    let g:neocomplcache_enable_auto_delimiter = 0
    let g:neocomplcache_max_list = 15
    let g:neocomplcache_force_overwrite_completefunc = 1
    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
        let g:neocomplcache_keyword_patterns.tex = '\\?[a-zA-Z_]\w*'
    endif
    " Define dictionary.
    let g:neocomplcache_dictionary_filetype_lists = {
                \ 'default' : '',
                \ 'vimshell' : $HOME.'/.vimshell_hist',
                \ 'scheme' : $HOME.'/.gosh_completions'
                \ }
    " Enable heavy omni completion.
    if !exists('g:neocomplcache_omni_patterns')
        let g:neocomplcache_omni_patterns = {}
        let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
        let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
        let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
        let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
        let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
        let g:neocomplcache_omni_patterns.go = '\h\w*\.\?'
    endif
    " <BS>: close popup and delete backword char.
    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
    " c-j to complete pum
    imap <expr><C-j> pumvisible() ? neocomplcache#close_popup():"\<Cr>"
    smap <expr><C-j> pumvisible() ? neocomplcache#close_popup():"\<Cr>"
endif
" smart completion use neosnippet to expand
if g:completable>0
    " menu style
    set completeopt=menuone,noselect
    "set completeopt=menu,menuone,noinsert,noselect
    " For snippet_complete marker.
    if !exists("g:spf13_no_conceal")
        if has('conceal')
            set conceallevel=2 concealcursor=i
        endif
    endif

    if g:use_ultisnips
        " remap Ultisnips for compatibility
        let g:UltiSnipsListSnippets="<C-l>"
        let g:UltiSnipsExpandTrigger = '<C-k>'
        let g:UltiSnipsJumpForwardTrigger = '<C-f>'
        let g:UltiSnipsJumpBackwardTrigger = '<C-b>'
        " Ulti python version
        if has('python3')
            let g:UltiSnipsUsePythonVersion = 3
        else
            let g:UltiSnipsUsePythonVersion = 2
        endif
        " Ulti的代码片段的文件夹
        let g:UtiSnipsSnippetDirectories=["~/.vim/bundle/vim-snippets/UltiSnips","~/.vim/bundle/vim-snippets/snipets"]
        inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
        inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
        inoremap <expr> <PageDown>  pumvisible() ? "\<PageDown>\<C-n>\<C-p>" : "\<PageDown>"
        inoremap <expr> <PageUp> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
        inoremap <expr> <S-Tab> pumvisible() ? "\<C-n>":"<S-Tab>"
        snoremap <expr> <S-Tab> pumvisible() ? "\<C-n>":"<S-Tab>"
        " tab for ExpandTrigger
        function! s:UltiSnips_Tab()
            if pumvisible()
                call UltiSnips#ExpandSnippet()
                " 0:ExpandSnippet failed
                if g:ulti_expand_res
                    return "\<Right>"
                else
                    if empty(v:completed_item) || !len(get(v:completed_item,'menu'))
                        return "\<C-n>"
                    else
                        return "\<C-y>"
                    endif
                endif
            else
                return "\<Tab>"
            endif
        endfunction
        au BufEnter * exec "inoremap <silent> <Tab> <C-R>=<SID>UltiSnips_Tab()<cr>"
        au BufEnter * exec "snoremap <silent> <Tab> <C-R>=<SID>UltiSnips_Tab()<cr>"
        inoremap <expr><S-Tab> pumvisible() ? "\<C-n>":"<S-Tab>"
        snoremap <expr><S-Tab> pumvisible() ? "\<C-n>":"<S-Tab>"
        function! s:UltiSnips_Cr()
            if pumvisible()
                call UltiSnips#ExpandSnippet()
                " 0:ExpandSnippet failed
                if g:ulti_expand_res
                    return "\<Right>"
                else
                    return "\<C-y>"
                endif
            else
                return "\<CR>"
            endif
        endfunction
        au BufEnter * exec "inoremap <silent> <Cr> <C-R>=<SID>UltiSnips_Cr()<cr>"
        au BufEnter * exec "snoremap <silent> <Cr> <C-R>=<SID>UltiSnips_Cr()<cr>"
    else
        let g:neosnippet#enable_completed_snippet=1
        " c-k to expand
        imap <C-k> <Plug>(neosnippet_expand)
        smap <C-k> <Plug>(neosnippet_expand)
        xmap <C-k> <Plug>(neosnippet_expand_target)
        " c-f to jump
        imap <C-f> <Right><Plug>(neosnippet_jump)
        smap <C-f> <Right><Plug>(neosnippet_jump)
        inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
        inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
        inoremap <expr> <PageDown>  pumvisible() ? "\<C-n>" : "\<PageDown>"
        inoremap <expr> <PageUp> pumvisible() ? "\<C-p>" : "\<PageUp>"
        function! s:Neo_Snippet_Tab()
            if pumvisible() "popup menu apeared
                if neosnippet#expandable()
                    return neosnippet#mappings#expand_impl()
                else
                    if empty(v:completed_item) || !len(get(v:completed_item,'menu'))
                        "if !len(get(v:completed_item,'menu'))
                        return "\<C-n>"
                    else
                        return "\<C-j>"
                    endif
                endif
            else
                return "\<Tab>"
            endif
        endfunction
        inoremap <expr><Tab> <SID>Neo_Snippet_Tab()
        snoremap <expr><Tab> <SID>Neo_Snippet_Tab()
        inoremap <expr><S-Tab> pumvisible() ? "\<C-n>":"<S-Tab>"
        snoremap <expr><S-Tab> pumvisible() ? "\<C-n>":"<S-Tab>"
        function! s:Neo_Snippet_Cr()
            if pumvisible() "popup menu apeared
                if neosnippet#expandable()
                    return neosnippet#mappings#expand_impl()
                else
                    return "\<C-j>"
                endif
            else
                return "\<Cr>"
            endif
        endfunction
        inoremap <expr><CR> <SID>Neo_Snippet_Cr()
        snoremap <expr><CR> <SID>Neo_Snippet_Cr()
        " Use honza's snippets.
        let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
        " Enable neosnippet snipmate compatibility mode
        let g:neosnippet#enable_snipmate_compatibility = 1
        " Enable neosnippets when using go
        let g:go_snippet_engine = "neosnippet"
    endif
endif
" UndoTree
if isdirectory(expand("~/.vim/bundle/undotree/"))
    nnoremap <silent><Leader>u :UndotreeToggle<CR>
    " If undotree is opened, it is likely one wants to interact with it.
    let g:undotree_SetFocusWhenToggle=1
endif
" indent_guides
if isdirectory(expand("~/.vim/bundle/vim-indent-guides/"))
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
    let g:indent_guides_enable_on_vim_startup = 1
endif
" vim-airline
" Default in terminal vim is 'dark'
if isdirectory(expand("~/.vim/bundle/vim-airline-themes/"))
    if !exists('g:no_colorscheme')
        if count(g:spf13_bundle_groups, 'material') && isdirectory(expand("~/.vim/bundle/vim-quantum"))
            let g:airline_theme = 'quantum'
        else
            if  filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
                let g:airline_theme = 'solarized'
            endif
        endif
        if !exists('g:airline_powerline_fonts')
            " Use the default set of separators with a few customizations
            let g:airline_left_sep='›'  " Slightly fancier than '>'
            let g:airline_right_sep='‹' " Slightly fancier than '<'
        endif
    endif
endif
" GUI Settings
" GVIM- (here instead of .gvimrc)
if has('gui_running')
    set guioptions-=T           " Remove the toolbar
    set lines=40                " 40 lines of text instead of 24
endif
" Functions
" Initialize directories
function! InitializeDirectories()
    let parent = $HOME
    let prefix = 'vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }
    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif
    " To specify a different directory in which to place the vimbackup,
    " vimviews, vimundo, and vimswap files/directories, add the following to
    " your .vimrc.before.local file:
    "   let g:spf13_consolidated_directory = <full path to desired directory>
    "   eg: let g:spf13_consolidated_directory = $HOME . '/.vim/'
    if exists('g:spf13_consolidated_directory')
        let common_dir = g:spf13_consolidated_directory . prefix
    else
        let common_dir = parent . '/.' . prefix
    endif
    for [dirname, settingname] in items(dir_list)
        let directory = common_dir . dirname . '/'
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
call InitializeDirectories()
" Strip whitespace
function! StripTrailingWhitespace()
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
" Shell command
function! s:RunShellCommand(cmdline)
    botright new
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal nobuflisted
    setlocal noswapfile
    setlocal nowrap
    setlocal filetype=shell
    setlocal syntax=shell
    call setline(1, a:cmdline)
    call setline(2, substitute(a:cmdline, '.', '=', 'g'))
    execute 'silent $read !' . escape(a:cmdline, '%#')
    setlocal nomodifiable
    1
endfunction
command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:ExpandFilenameAndExecute(command, file)
    execute a:command . " " . expand(a:file, ":p")
endfunction
" Use local vimrc if available
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
" Use local gvimrc if available and gui is running
if has('gui_running')
    if filereadable(expand("~/.gvimrc.local"))
        source ~/.gvimrc.local
    endif
endif
