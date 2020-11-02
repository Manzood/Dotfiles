" -------------------------------Notes and tips-----------------------------
" 1) To get rid of all ^M occurances in a file, use the command :s/^M$//
" 2) This is actually not the first file nvim looks at, but I've set up my init.vim to source this file
" 3) Look at :h NerdCommentary to customise how comments work


" I've set up the comma as my current leader, although I am considering switching to space
let mapleader = ","


" ----------------------------vim-plug section-------------------------------
" Plug was installed from https://github.com/junegunn/vim-plug
" To look up syntax or help, their README.md is pretty well written

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'jiangmiao/auto-pairs'
Plug 'ycm-core/YouCompleteMe'
Plug 'preservim/nerdcommenter'
" Colorschemes:
Plug 'patstockwell/vim-monokai-tasty'
Plug 'overcache/NeoSolarized'
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'joshdick/onedark.vim'
Plug 'ThePrimeagen/vim-be-good'
call plug#end()
runtime! plugin/sensible.vim


" --------------------------general configuration---------------------------
" this is going to make copy and paste sync with the system buffer
" set clipboard=unnamedplus
set noerrorbells
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
filetype plugin indent on
syntax on
set ruler
set nowrap
set mouse=a
set autoindent
set smartindent
set cindent
set number
set hidden      
set incsearch
" stops nvim from adding those awful line breaks
set tw=0
let g:NERDSpaceDelims=1
let NERDCreateDefaultMappings=0 "Set it to 1 to re-enable the default mappings
" the following are currently unused
" let g:loaded_matchparen=1
" set noshowmatch

" Adds the ability to leave files without saving, HUGE timesaver for FZF
autocmd BufEnter * silent! lcd %:p:h
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set rnu
    autocmd BufLeave,FocusLost,InsertEnter * set nornu
augroup END
if has("autocmd")
" When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal g'\"" |
  \ endif
endif


"----------------------------------FZF---------------------------------------
" For opening up files with fuzzy searching
nnoremap <leader>f :FZF<cr>
nnoremap <leader>F :FZF ~<cr>
if has("nvim")
    " Escape inside a FZF terminal window should exit the terminal window
    " rather than going into the terminal's normal mode.
    autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>
endif


" --------------------------------Helpful for CP-------------------------------
" -------------------------------and useful remaps-----------------------------
nmap <leader>y ggVG"+y''
nmap <leader>d ggdG
nnoremap <space>h :wincmd h<cr>
nnoremap <space>l :wincmd l<cr>
nnoremap <space>j :wincmd j<cr>
nnoremap <space>k :wincmd k<cr>
nnoremap <leader>gd :YcmCompleter GoTo<cr>
nnoremap <leader>o :!gnome-terminal<cr>
nnoremap <leader>c :e ~/Dotfiles/init.vim<cr>
nnoremap <leader>wq :wq<cr>
nnoremap <leader>Q :q!<cr>
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
tnoremap <C-\> <C-\><C-n>
nnoremap <leader>t :split <bar> resize 30 <bar> :wincmd j <bar> :term<cr>a

" commentary remaps
map <C-_> <plug>NERDCommenterInvert

autocmd filetype cpp map <C-B> :w <bar> silent !g++ -std=c++17 -Wshadow -Wall -Wno-unused-result % -D local -o %< <CR>
autocmd filetype cpp nnoremap <leader>r :w <bar> !g++ -std=c++17 -Wshadow -Wall -Wno-unused-result % -D local -o %< && ./%< < in <cr>

" Useful for future code templates
" autocmd BufNewFile *.cpp -r ~/cp/template.cpp


"-------------------------------Visual Customization------------------------------

set termguicolors

" ---Colorscheme setup---
"colorscheme molokai; let g:molokai_original=1; let g:rehash256 = 1;
" colorscheme vim-monokai-tasty
autocmd vimenter * colorscheme onedark
autocmd vimenter * AirlineTheme onedark
" colorscheme NeoSolarized
" colorscheme nord
" set background=light

" You can experiment with airline themes using the command :AirlineTheme
" Setting up the AirlineTheme breaks airline at the moment, so the following command is useless. Instead, I use an autocmd to make it work
let g:airline_theme="onedark"

" The following commands makes integers match the color scheme of Sublime more accurately
"hi Type ctermfg=LightBlue cterm=Italic
hi MatchParen cterm=underline ctermbg=none ctermfg=none

" Air-Line customisation
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = '☰'
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.dirty='⚡'
