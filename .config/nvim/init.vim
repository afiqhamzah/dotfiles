" ===============================================

call plug#begin('~/.config/nvim/plugged')

Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-eunuch'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'yuttie/comfortable-motion.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'honza/vim-snippets'
Plug 'Yggdroot/indentLine'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/vim-peekaboo'
Plug 'romainl/vim-cool'
Plug 'jnurmine/Zenburn'
Plug 'majutsushi/tagbar'
Plug 'markonm/traces.vim'
Plug 'kana/vim-textobj-user'
Plug 'Julian/vim-textobj-variable-segment'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-sensible'
Plug 'junegunn/vim-easy-align'
Plug 'wellle/targets.vim'
Plug 'liuchengxu/vim-clap'
Plug 'liuchengxu/vim-clap', { 'do': function('clap#helper#build_all') }
Plug 'tomasiser/vim-code-dark'
Plug 'machakann/vim-highlightedyank'
Plug 'mhinz/vim-signify'

call plug#end()

" ===============================================

" General
set number                     " Show line numbers
set relativenumber

" set linebreak                  " Break lines at word (requires Wrap lines)
" set showbreak=+++              " Wrap-broken line prefix

set list
set nowrap
set sidescroll=10
set scrolloff=3

set textwidth=100              " Line wrap (number of cols)
set showmatch                  " Highlight matching brace
set visualbell                 " Use visual bell (no beeping)
 
set hlsearch                   " Highlight all search results
set smartcase                  " Enable smart-case search
set ignorecase                 " Always case-insensitive
 
set tabstop=8                  "https://www.reddit.com/r/vim/wiki/tabstop
set softtabstop=4
set shiftwidth=4
set expandtab 

set termguicolors

" Advanced
 
set undolevels=1000            " Number of undo levels
set noshowmode


" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=1

" You will have bad experience for diagnostic messages when it's
" default 4000.
set updatetime=100

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" no swap 
set noswapfile

set clipboard=unnamedplus

set autoread

" set leader to spacebar 
let mapleader = "\<Space>" 

let g:node_host_prog = expand('~/.nvm/versions/node/v12.13.0/bin/neovim-node-host')

let g:coc_node_path = expand('~/.nvm/versions/node/v12.13.0/bin/node')

" ==============================================

" 
" Plugin configuration
"
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

colorscheme zenburn
let g:zenburn_alternate_Visual = 1

" set t_Co=256
" set t_ut=
" colorscheme codedark

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
      \   'right': [
      \            [ 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'filetype' ] 
      \            ],
      \ },
      \ 'component': {
      \   'lineinfo': ' %3l:%-2v',
      \ },
      \ 'component_function': {
      \   'readonly': 'LightlineReadonly',
      \   'fugitive': 'LightlineFugitive',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }
function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction
function! LightlineFugitive()
  if exists('*fugitive#head')
    let branch = fugitive#head()
    return branch !=# '' ? ''.branch : ''
  endif
  return ''
endfunction
function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

let g:lightline.mode_map = {
        \ 'n' : 'N',
        \ 'i' : 'I',
        \ 'R' : 'R',
        \ 'v' : 'V',
        \ 'V' : 'V',
        \ "\<C-v>": 'V',
        \ 's' : 'S',
        \ 'S' : 'S',
        \ "\<C-s>": 'S'
        \ }
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ==============================================
"
" coc.nvim configuration
"

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> <leader>K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>r <Plug>(coc-rename)

" Remap for format selected region
" xmap <leader>fmt  <Plug>(coc-format-selected)
" nmap <leader>fmt  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" xmap <leader>at  <Plug>(coc-codeaction-selected)
" nmap <leader>at  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
" nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
" nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
" xmap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap if <Plug>(coc-funcobj-i)
" omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <leader>p  :<C-u>CocListResume<CR>
" ======================================================================================

" ======================================================================================
" FZF
"

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

nnoremap <silent> <Leader>r :Clap grep<CR>
nnoremap <silent> <Leader>f :Clap files ++finder=rg --files<CR>
nnoremap <silent> <Leader>F :Clap files ++finder=rg --files --hidden --no-ignore<CR>
nnoremap <silent> <Leader>h :Clap history<CR>
nnoremap <silent> <Leader>t :TagbarToggle<CR>
nnoremap <silent> <leader><leader> :Clap buffers<CR>
"=======================================================================================

"=======================================================================================
" Move between wrapped lines, rather than jumping over wrapped segments
nmap j gj
nmap k gk

" Swap 0 and ^. I tend to want to jump to the first non-whitespace character
" " so make that the easier one to do.
nnoremap 0 ^
nnoremap ^ 0

" let g:comfortable_motion_scroll_down_key = "j"
" let g:comfortable_motion_scroll_up_key = "k"
nnoremap <silent> J :call comfortable_motion#flick(50)<CR>
nnoremap <silent> K :call comfortable_motion#flick(-50)<CR>

nmap - :NERDTreeToggle<CR>
nmap _ :NERDTreeFind<CR> 

let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI  = 1
let NERDTreeDirArrows  = 1
let g:NERDTreeWinPos   = "right"
let g:NERDTreeWinSize  = 60
let NERDTreeAutoDeleteBuffer = 1

" If more than one window and previous buffer was NERDTree, go back to it.
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif

" To get the correct comment highlighting for coc config
autocmd FileType json syntax match Comment +\/\/.\+$+:

let g:vue_pre_processors = []

" jk | Escaping!
inoremap jk <Esc>
" xnoremap jk <Esc>
cnoremap jk <C-c>

" Make Y behave like other capitals
nnoremap Y yg_


" ----------------------------------------------------------------------------
"   Moving lines
" ----------------------------------------------------------------------------
  nnoremap <silent> <C-k> :move-2<cr>
  nnoremap <silent> <C-j> :move+<cr>
  nnoremap <silent> <C-h> <<
  nnoremap <silent> <C-l> >>
  xnoremap <silent> <C-k> :move-2<cr>gv
  xnoremap <silent> <C-j> :move'>+<cr>gv
  xnoremap <silent> <C-h> <gv
  xnoremap <silent> <C-l> >gv
  xnoremap < <gv
  xnoremap > >gv

cabbrev h tab help

autocmd FileType help git fugitive noremap <buffer> q :q<cr>

