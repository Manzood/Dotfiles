" -------------------------------Notes and tips-----------------------------
" NOTE: This init.vim was what I used before switching to neovim 0.5+, using LSP and treesitter. I think the current setup is far superior, but I'm storing this as reference.

" The original dotfile is located at ~/.config/nvim/init.vim
" This is actually not the first file nvim looks at, but I've set up my init.vim to source this file

" NOTE: make sure to fix airline, because it's totally broken at the moment
" I think the key is to switch to a patched font

" My leader is now space, since I would like to use comma to search backwards, and I think it will probably hold me back otherwise
let mapleader = " "

"mapping jk as escape
" :imap jk <Esc>


" ----------------------------vim-plug section-------------------------------
" Plug was installed from https://github.com/junegunn/vim-plug
" To look up syntax or help, their README.md is pretty well written

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'ycm-core/YouCompleteMe'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'luochen1990/rainbow'
Plug 'vimwiki/vimwiki'
" Colorschemes:
Plug 'romgrk/doom-one.vim'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'overcache/NeoSolarized'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'reedes/vim-colors-pencil'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sickill/vim-monokai'
Plug 'chriskempson/base16-vim'

"Plug 'ThePrimeagen/vim-be-good'
" call remove(g:plugs, 'YouCompleteMe')
" Plug 'ycm-core/YouCompleteMe', { 'on': [] }
call plug#end()
runtime! plugin/sensible.vim

" --------------------------general configuration---------------------------
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o "stops comments from showing up on newlines
set noerrorbells
" indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set cindent
filetype plugin indent on
syntax on
set ruler
set nowrap
set mouse=a
set number
set hidden
set incsearch
set nohlsearch
set splitright splitbelow
set tw=0
set ignorecase " I'll probably change this up in the future
set scrolloff=5
set signcolumn=yes
let g:python3_host_prog = '/usr/bin/python3'

augroup vimrc
  autocmd!
  au BufReadPre * setlocal foldmethod=syntax
  au BufWinEnter * if &fdm == 'syntax' | setlocal foldmethod=manual | endif
augroup END

" Adds the ability to leave files without saving, HUGE timesaver for FZF
autocmd BufEnter * silent! lcd %:p:h
" adding rnu in Normal mode, but not in insert mode
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


"----------------------------------Plugin Config---------------------------------------
" -- rainbow config --
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" -- auto pairs --
" the line below fixes the multiline issue, really
let g:AutoPairsMultilineClose = 0

" -- FZF --
" For opening up files with fuzzy searching
nnoremap <leader>f :FZF<cr>
nnoremap <leader>F :FZF ~<cr>
if has("nvim")
    " Escape inside a FZF terminal window should exit the terminal window
    " rather than going into the terminal's normal mode.
    autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>
endif

" -- NERDCommentary --
let g:NERDSpaceDelims=1
let NERDCreateDefaultMappings=0 "Set it to 1 to re-enable the default mappings

" -- NERDtree --
" closes NERDtree if it is the only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1

"-- VimWiki --
let g:vimwiki_list = [{'path':'~/VimWiki', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'mardown'}
"Makes vimwiki markdown links as [text](text.md) instead of [text](text)
let g:vimwiki_markdown_link_ext = 1
let g:markdown_folding = 0

" -- YouCompleteMe --
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/.ycm_extra_conf.py'

" --------------------------------Helpful for CP-------------------------------
" -------------------------------and useful remaps-----------------------------

"^S to save file
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a
vnoremap <c-c> "+y
nmap <leader>y ggVG"+y''
nmap <leader>d ggdG
nnoremap <space>h :wincmd h<cr>
nnoremap <space>l :wincmd l<cr>
nnoremap <space>j :wincmd j<cr>
nnoremap <space>k :wincmd k<cr>
nnoremap <leader>gd :YcmCompleter GoTo<cr>
nnoremap <leader>o :!alacritty<cr>
nnoremap <leader>c :e ~/Dotfiles/init.vim<cr>
nnoremap <leader>wq :wq<cr>
nnoremap <leader>Q :q!<cr>
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
tnoremap <C-\> <C-\><C-n>
nnoremap <leader>t :split <bar> resize 16 <bar> :term<cr>a
nnoremap <leader>s :e ~/Coding/Snippets/

" commentary remaps
map <C-_> <plug>NERDCommenterInvert
" nerdtree
map <C-n> :NERDTreeToggle<CR>
" vimwiki
nmap <C-t> <C-Space>

autocmd filetype cpp map <C-B> :w <bar> !g++ -std=c++17 -Wshadow -Wall -Wno-unused-result % -D local -o %< <CR>
autocmd filetype cpp nnoremap <leader>r :w <bar> !g++ -std=c++17 -Wshadow -Wall -Wno-unused-result % -D local -o %< && ./%< < in <cr>
autocmd filetype c map <C-B> :w <bar> !gcc -std=c17 -Wshadow -Wall -Wno-unused-result % -D local -o %< <CR>

" Useful for future code templates
" Update: I've actually made this command work, of sorts
" autocmd BufNewFile *.cpp -r ~/Coding/Templates/template.cpp | :9 | :delete | :7


"-------------------------------Visual Customization------------------------------

set termguicolors
"let g:solarized_termcolors=256

" ---Colorscheme setup---
" colorscheme vim-monokai-tasty
" autocmd vimenter * colorscheme doom-one
autocmd vimenter * colorscheme my-base16-monokai
" autocmd vimenter * AirlineTheme onedark
autocmd vimenter * AirlineTheme base16_monokai
let g:onedark_terminal_italics=1
" colorscheme NeoSolarized
" set background=light

" You can experiment with airline themes using the command :AirlineTheme
let g:airline_theme="onedark"

" The following commands makes integers match the color scheme of Sublime more accurately
" hi Type ctermfg=LightBlue cterm=Italic
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


"----------------------------Functions for extra convenience-----------------------
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup TEMPGROUP
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
