set exrc
set secure
set nocompatible          " get rid of Vi compatibility mode. SET FIRST!
set guifont=Meslo\ LG\ S\ Regular\ for\ Powerline:h12
set guioptions+=LlRrb
set guioptions-=LlRrb
set lines=100             " maximized window default osx
filetype plugin indent on " filetype detection[ON] plugin[ON] indent[ON]
set t_Co=256              " enable 256-color mode.
syntax enable             " enable syntax highlighting (previously syntax on).
colorscheme monokai        " set colorscheme
set number                " show line numbers
set laststatus=2          " last window always has a statusline
set nohlsearch            " Don't continue to highlight searched phrases.
set incsearch             " But do highlight as you type your search.
set ignorecase            " Make searches case-insensitive.
set ruler                 " Always show info along bottom.
set autoindent            " auto-indent
set tabstop=4             " tab spacing
set softtabstop=4         " unify
set shiftwidth=4          " indent/outdent by 4 columns
set shiftround            " always indent/outdent to the nearest tabstop
set expandtab             " use spaces instead of tabs
set smarttab              " use tabs at the start of a line, spaces elsewhere
set nowrap                " don't wrap text
set omnifunc=syntaxcomplete#Complete
" configure tags - add additional tags here or comment out not-used ones
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
"ignore ti files for ctrlp file search
let g:ycm_global_ycm_extra_conf = '/Users/riccardo/dotfiles/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](.git|.hg|.svn|bower_components|node_modules|venel)$',
    \ }
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
execute pathogen#infect()
" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction
map <C-z> :ZoomWin<CR>
"map ctrl-n to nerdtree toggle open
map <C-n> :NERDTreeToggle<CR>
map <space>n :NERDTreeFind<CR>
"map alt-left mouse to visual block selection
vmap <A-LeftMouse> <C-v><LeftMouse>msgv`s
set runtimepath^=~/.vim/bundle/ctrlp.vim
nmap <C-Tab> <C-W><C-W>
"window resize maps
nmap <D-S-Left> <C-W><C-<>
nmap <D-S-Right> <C-W><C->>
nmap <D-S-Up> <C-W><C-->
nmap <D-S-Down> <C-W><C-+>
map <C-J> :call JsBeautify()<cr>
"automplete
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
nmap <C-T> :TagbarToggle<CR>
nmap <C-E> :BreezeMatchTag<CR>
" persistent undo file
set undodir=~/.vim/undo
set undofile
"trailing white spaces
if has('autocmd')
    " Show trailing whitespace:
    highlight ExtraWhitespace ctermbg=red guibg=red
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
endif
"ask for a password and become super user if :w!!
ca w!! w !sudo tee "%"
let b:thisdir=expand("%:p:h")
let b:vim=b:thisdir."/.vim"
if (filereadable(b:vim))
    execute "source ".b:vim
endif


"csslint
autocmd BufNewFile,BufRead .csslintrc setlocal filetype=javascript

"remove trailing spaces
map <S-F4> :%s/\s\+$//<CR>


au BufNewFile,BufRead *.blade.php set filetype=blade
autocmd Filetype html,scss,css,liquid,blade imap <buffer> <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
" vim-liquid: Set subtype for Shopify alternate templates
au BufNewFile,BufRead */templates/**.liquid,*/layout/**.liquid,*/snippets/**.liquid
      \ let b:liquid_subtype = 'html' |
      \ set ft=liquid |
au BufNewFile,BufRead *.js.liquid
      \ let b:liquid_subtype = 'javascript' |
      \ set ft=liquid |


" Unite
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <space>y :Unite history/yank<cr>
nnoremap <space>b :Unite -quick-match buffer<cr>
nnoremap <space>p :<C-u>Unite -start-insert file_rec/async:<cr>
nnoremap <space>f :<C-u>Unite grep:.<cr>
nnoremap <space>F :<C-u>Unite grep<CR>
nnoremap <space>u :<C-u>UniteResume<CR>
" Custom mappings for the unite buffer

if executable('pt')
  let g:unite_source_rec_async_command = 'pt --nocolor --nogroup -g .'
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_encoding = 'utf-8'
endif

autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  " Not showing the trailing space as red if has vim-trailing-color installed
  autocmd InsertLeave <buffer> match ExtraWhitespace //
  autocmd InsertEnter <buffer> match ExtraWhitespace //
  autocmd BufWinEnter <buffer> match ExtraWhitespace //
  " Other Customizations
  nnoremap <silent><buffer><expr> <C-x> unite#do_action('split')
  nnoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  nnoremap <silent><buffer><expr> <C-t> unite#do_action('tabopen')

  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction

let g:syntastic_cpp_compiler_options="-std=c++1y"

au BufNewFile,BufRead *.ejs set filetype=html
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'liquid' : 1,
    \}

let g:tern_show_argument_hints = 'on_move'
let g:tern_map_keys=1
