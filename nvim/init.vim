" make neovim to use vundle
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')

set ic smartcase
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'martinda/Jenkinsfile-vim-syntax'
Plugin 'hashivim/vim-terraform'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'tpope/vim-dispatch'
Plugin 'radenling/vim-dispatch-neovim'
Plugin 'tpope/vim-unimpaired'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-obsession'
Plugin 'chase/vim-ansible-yaml'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'wincent/ferret'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-fugitive'
Plugin 'nvie/vim-flake8'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-rhubarb'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'easymotion/vim-easymotion'
Plugin 'flazz/vim-colorschemes'
Plugin 'sainnhe/vim-color-forest-night'
Plugin 'Raphx/modest'
Plugin 'morhetz/gruvbox'
"Plugin 'python-mode/python-mode'
"Plugin 'ycm-core/YouCompleteMe'
"Plugin 'SirVer/ultisnips'
Plugin 'ncm2/ncm2-ultisnips'
Plugin 'andrewstuart/vim-kubernetes'
Plugin 'tarekbecker/vim-yaml-formatter'
Plugin 'jiangmiao/auto-pairs'
Plugin 'yuki-ycino/fzf-preview.vim'
" All of your Plugins must be added before the following line

call vundle#end()
filetype plugin indent on  " allows auto-indenting depending on file type

" colorscheme for neovim
colorscheme gruvbox
set background=dark

" NERDTree toggle
nnoremap <silent> <S-n> :NERDTreeToggle<CR>
" NERDTreefind
nnoremap <silent> ff :NERDTreeFind <Enter>

" Write files without permission
nnoremap :sw :w !sudo tee % > /dev/null

" Copying to system clipboard
vnoremap Y "+y
nnoremap <C-p> :<C-u>FZF<cr>

" Airline Theme
"let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
nnoremap tn :tabnew<Enter>
nnoremap tt :tabnext<Enter>
nnoremap tp :tabprevious<Enter>
nnoremap tf :tabfirst<Enter>
nnoremap tc :tabclose<Enter>
nnoremap te :tabe<Enter>

set nu

" If installed using git
set rtp+=~/.fzf

"fugitive vim
nnoremap gw :Gwrite<Enter>
nnoremap gs :Gstatus<Enter>
nnoremap gc :Gcommit<Enter>
nnoremap gp :Gpush
nnoremap gpl :Gpull<Enter>

let @e='ggIIssue #000 feat: '
let @w='ggIIssue #000 fix: '
let @r='ggIIssue #000 chore: '

" "youcompleteMe selection using enter
" let g:ycm_key_list_stop_completion = [ '<C-y>', '<Enter>' ]

inoremap <C-s> <esc>:w<cr>                 " save files
nnoremap <C-s> :w<cr>
inoremap <C-d> <esc>:wq!<cr>               " save and exit
nnoremap <C-d> :wq!<cr>
inoremap <C-a> <esc>:q!<cr>               " quit discarding changes
nnoremap <C-a> :q!<cr>

"set mouse=a
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

function! Term()
  exec winheight(0)/4."split" | terminal
endfunction

filetype plugin indent on
syntax on

" Use deoplete.
let g:deoplete#enable_at_startup = 1

let g:AutoPairsFlyMode = 1

" Popup window for fzf
" Terminal buffer options for fzf
autocmd! FileType fzf
autocmd  FileType fzf set noshowmode noruler nonu

if has('nvim') && exists('&winblend') && &termguicolors
  set winblend=20

  hi NormalFloat guibg=None
  if exists('g:fzf_colors.bg')
    call remove(g:fzf_colors, 'bg')
  endif

  if stridx($FZF_DEFAULT_OPTS, '--border') == -1
    let $FZF_DEFAULT_OPTS .= ' --border'
  endif

  function! FloatingFZF()
    let width = float2nr(&columns * 0.8)
    let height = float2nr(&lines * 0.6)
    let opts = { 'relative': 'editor',
               \ 'row': (&lines - height) / 2,
               \ 'col': (&columns - width) / 2,
               \ 'width': width,
               \ 'height': height }

    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
  endfunction

  let g:fzf_layout = { 'window': 'call FloatingFZF()' }
endif

command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
