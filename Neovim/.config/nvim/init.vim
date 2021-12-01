" to be considered later
" nnoremap cn *``cgn
" nnoremap cN *``cgN

" - Go on top of a word you want to change
" - Press cn or cN
" - Type the new word you want to replace it with
" - Smash that dot '.' multiple times to change all the other occurrences of the word
" It's quicker than searching or replacing. It's pure magic.


" ---------------------------- most important mappings --------------------------

" mapping leader to space
let mapleader = " "

"mapping jk as escape
:imap jk <Esc>
:cmap jk <Esc>
" :imap kj <Esc>
" :cmap kj <Esc>
:imap JK <Esc>
:cmap JK <Esc>
:imap Jk <Esc>
:cmap Jk <Esc>

" ---------------------------- vim-plug section -------------------------------
" Plug was installed from https://github.com/junegunn/vim-plug

call plug#begin('~/.config/nvim/plugged')

" getting the dashboard
Plug 'glepnir/dashboard-nvim'

Plug 'tpope/vim-sensible'
Plug 'jiangmiao/auto-pairs'
" Plug 'ycm-core/YouCompleteMe'
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
" Plug 'octol/vim-cpp-enhanced-highlight' " Disabled it for now, but it'll probably be useful at some point anyway? It seems to work better with monokai pro
Plug 'luochen1990/rainbow'
" Plug 'vimwiki/vimwiki'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'kyazdani42/nvim-web-devicons' " lua
Plug 'SirVer/ultisnips'

" Plug 'lukas-reineke/indent-blankline.nvim' " appears to have terrible performance honestly
Plug 'akinsho/bufferline.nvim'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

"LSPKind and LSP-colors
Plug 'onsails/lspkind-nvim'
" Plug 'folke/lsp-colors.nvim'
Plug 'glepnir/lspsaga.nvim'

" Getting Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'


" Colorschemes:
" Plug 'romgrk/doom-one.vim'
" Plug 'patstockwell/vim-monokai-tasty'
Plug 'overcache/NeoSolarized'
Plug 'morhetz/gruvbox'
" Plug 'joshdick/onedark.vim'
" Plug 'reedes/vim-colors-pencil'
Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'sickill/vim-monokai'
Plug 'chriskempson/base16-vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'phanviet/vim-monokai-pro'
Plug 'Mofiqul/vscode.nvim'
Plug 'mangeshrex/uwu.vim'
Plug 'olimorris/onedarkpro.nvim' " This hasn't been set up properly yet. Set this up properly,eventually


" Plug 'Mofiqul/codedark.nvim' , {'branch' : 'main'}
" Plug 'tjdevries/colorbuddy.nvim'
" Plug 'marko-cerovac/material.nvim', { 'branch': 'colorbuddy' }
Plug 'marko-cerovac/material.nvim'


" vim-be-good'
" Plug 'ThePrimeagen/vim-be-good'
" call remove(g:plugs, 'YouCompleteMe')
" Plug 'ycm-core/YouCompleteMe', { 'on': [] }

call plug#end()
runtime! plugin/sensible.vim


" --------------------------general configuration---------------------------
" set lazyredraw
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o "stops comments from showing up on newlines
set noerrorbells
" Changing the timeout, i.e. the amount of time vim waits for a mapped key
set timeoutlen=200
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
set signcolumn=no " toggle the signcolumn to yes for YouCompleteMe
set inccommand=nosplit
set pumblend=20
let g:python3_host_prog = '/usr/bin/python3'

" augroup vimrc
  " autocmd!
  " au BufReadPre * setlocal foldmethod=syntax
  " au BufWinEnter * if &fdm == 'syntax' | setlocal foldmethod=manual | endif
" augroup END

" Adds the ability to leave files without saving, HUGE timesaver for FZF
autocmd BufEnter * silent! lcd %:p:h
" adding relative line numbers in Normal mode, but not in insert mode
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

augroup highlight_yankk
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

" au! BufWritePost $MYVIMRC source % " Auto source my vimrc

" cursor line stuff
" augroup CursorLine
  " au!
  " au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  " au WinLeave * setlocal nocursorline
" augroup END
:nnoremap <Leader>\c :set cursorline! cursorcolumn!<CR>


"----------------------------------Plugin Config---------------------------------------
" -- rainbow config --
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" -- auto pairs --
" the line below fixes the multiline issue, really
let g:AutoPairsMultilineClose = 0

" -- FZF --
" For opening up files with fuzzy searching
" nnoremap <leader>f :FZF<cr>
" nnormap <leader>F :FZF ~<cr>
" if has("nvim")
    " Escape inside a FZF terminal window should exit the terminal window
    " rather than going into the terminal's normal mode.
    " autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>
" endif

" -- NERDCommentary --
let g:NERDSpaceDelims=1
let NERDCreateDefaultMappings=0 "Set it to 1 to re-enable the default mappings

" -- NERDtree --
" closes NERDtree if it is the only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1

"-- VimWiki --

" let g:vimwiki_list = [{'path':'~/VimWiki', 'syntax': 'markdown', 'ext': '.md'}]
" let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
" let g:vimwiki_markdown_link_ext = 1                   " Makes vimwiki markdown links as [text](text.md) instead of [text](text)
" let g:markdown_folding = 1

" -- YouCompleteMe --
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/.ycm_extra_conf.py'


" --------------------------------Helpful for CP-------------------------------
" -------------------------------and useful remaps-----------------------------

" Make Y behave consistently, similar to D and C
nnoremap Y y$

" Keep screen centered when you move around
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

"Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap ; ;<c-g>u

" cool text movements in all modes
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" inoremap <C-j> <esc>:m .+1<CR>==
" inoremap <C-k> <esc>:m .-2<CR>==
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==

" better tabbing
vnoremap < <gv
vnoremap > >gv


"^S to save file
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a
vnoremap <c-c> "+y
nmap <leader>y :%y+<cr>
nmap <leader>d ggdG
nnoremap <C-h> :wincmd h<cr>
nnoremap <C-l> :wincmd l<cr>
nnoremap <C-j> :wincmd j<cr>
nnoremap <C-k> :wincmd k<cr>
nnoremap <M-h> :vertical resize +2<cr>
nnoremap <M-l> :vertical resize -2<cr>
nnoremap <M-j> :resize -2<cr>
nnoremap <M-k> :resize +2<cr>
" nnoremap <leader>gd :YcmCompleter GoTo<cr>
nnoremap <leader>o :!alacritty<cr>
nnoremap <leader>c :e ~/Dotfiles/Neovim/.config/nvim/init.vim<cr>
nnoremap <leader>Q :q!<cr>
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
tnoremap <C-\> <C-\><C-n>
nnoremap <leader>t :split <bar> resize 16 <bar> :term<cr>a
nnoremap <leader>s :e ~/Coding/Competitive-Programming/Snippets/

" commentary remaps
map <C-_> <plug>NERDCommenterInvert
" nerdtree
map <C-n> :NERDTreeToggle<CR>
" vimwiki
nmap <C-t> <C-Space>

autocmd filetype cpp map <C-B> :wall <bar> !g++ -std=c++17 -Wall -Wextra -Wshadow -Wno-unused-result % -D local -o %< <CR>
autocmd filetype cpp map <C-Q> :wall <bar> !g++ -std=c++17 -Wall -Wextra -O2 -Wshadow -Wfloat-equal -Wconversion -Wshift-overflow=2 -Wduplicated-cond -Wno-unused-result -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -fsanitize=address -fsanitize=undefined -fno-sanitize-recover -fsanitize=undefined % -D local -o %< <CR>
autocmd filetype cpp nnoremap <leader>r :wall <bar> !g++ -std=c++17 -Wall -Wextra -Wshadow -Wno-unused-result % -D local -o %< && ./%< < in <cr>
autocmd filetype cpp nnoremap <leader>n :wall <bar> !g++ -std=c++17 -Wall -Wextra -Wshadow -Wno-unused-result % -D local -o %< && ./%< <cr>
autocmd filetype c map <C-B> :wall <bar> !gcc -std=c17 -Wall -Wextra -Wshadow -Wno-unused-result % -D local -o %< <CR>
autocmd filetype c nnoremap <leader>n :wall <bar> !gcc -std=c17 -Wall -Wextra -Wshadow -Wno-unused-result % -D local -o %< && ./%< <cr>

" Useful for future code templates
" autocmd BufNewFile *.cpp -r ~/Coding/Templates/template.cpp | :9 | :delete | :7


"-------------------------------Visual Customization------------------------------

set t_Co=256
set termguicolors
"let g:solarized_termcolors=256

" ---Colorscheme setup---
" colorscheme vim-monokai-tasty
" autocmd vimenter * colorscheme doom-one
" autocmd vimenter * colorscheme my-base16-monokai
" autocmd vimenter * colorscheme monokai_pro      " monokai pro is so good
colorscheme monokai_pro
" autocmd vimenter * AirlineTheme onedark
" autocmd vimenter * AirlineTheme base16_monokai
let g:onedark_terminal_italics=1
" colorscheme NeoSolarized
" set background=light

" You can experiment with airline themes using the command :AirlineTheme
" let g:airline_theme="onedark"

" The following commands makes integers match the color scheme of Sublime more accurately
" hi Type ctermfg=LightBlue cterm=Italic
hi MatchParen cterm=underline ctermbg=none ctermfg=none

" Air-Line customisation
" let g:airline_powerline_fonts = 1
" if !exists('g:airline_symbols')
    " let g:airline_symbols = {}
" endif
  " let g:airline_left_sep = ''
  " let g:airline_left_alt_sep = ''
  " let g:airline_right_sep = ''
  " let g:airline_right_alt_sep = ''
  " let g:airline_symbols.branch = ''
  " let g:airline_symbols.readonly = ''
  " let g:airline_symbols.linenr = '☰'
  " let g:airline_symbols.maxlinenr = ''
  " let g:airline_symbols.dirty='⚡'


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




" let g:tokyonight_style = 'storm' " available: night, storm
" let g:tokyonight_enable_italic = 1

" colorscheme tokyonight


let g:material_style = 'palenight'

let g:UltiSnipsExpandTrigger="<c-x>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="c-x"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


lua require ('eviline')
lua require ('lsp-and-cmp')
lua require ('treesitter')
lua require ('mylspsaga')
lua require ('telescope-config')
lua require ('finders')
lua require ('my-dashboard')
" lua require ('my-nvim-tree')

" ------------------------------------------------ nvim-cmp --------------------------------------------------------

set completeopt=menu,menuone,noselect




" ---------------------------------------- Telescope keybinds ------------------------------------------------------------------------------
" This section has to go after telescope config is sourced

" Using lua functions
nnoremap <leader>ff <cmd>lua require('telescope-config').project_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>ft <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fe <cmd>lua require('telescope.builtin').file_browser()<cr>
nnoremap <leader>fc <cmd>lua require('telescope.builtin').colorscheme()<cr>
" nnoremap <leader>s <cmd>cd ~/Coding/Competitive-Programming/Snippets <bar> lua require('telescope.builtin').find_files()<cr>
" nnoremap <leader>c <cmd>cd ~/Dotfiles/Neovim/.config/nvim <bar> lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>c <cmd>lua require('finders').fd_in_nvim()<cr>
nnoremap <leader>s <cmd>lua require('finders').fd_in_snippets()<cr>


" ------------------------------------------------ Transparency ------------------------------------------------------


" transparent background, uncomment to make background transparent
" hi Normal guibg=none ctermbg=none
" hi LineNr guibg=none ctermbg=none
" hi Folded guibg=none ctermbg=none
" hi NonText guibg=none ctermbg=none
" hi SpecialKey guibg=none ctermbg=none
" hi VertSplit guibg=none ctermbg=none
" hi SignColumn guibg=none ctermbg=none
" hi EndOfBuffer guibg=none ctermbg=none
" hi NormalFloat guibg=none ctermbg=none
" hi Pmenu guibg=none ctermbg=none


" ---------------------------------------------- Activating Bufferline -------------------------------------------------

lua << EOF
require("bufferline").setup{}
EOF

" These commands will navigate through buffers in order regardless of which mode you are using
" e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
nnoremap <silent>[b :BufferLineCycleNext<CR>
nnoremap <silent>]b :BufferLineCyclePrev<CR>

" These commands will move the current buffer backwards or forwards in the bufferline
nnoremap <silent>[B :BufferLineMoveNext<CR>
nnoremap <silent>]B :BufferLineMovePrev<CR>

" These commands will sort buffers by directory, language, or a custom criteria
" nnoremap <silent>be :BufferLineSortByExtension<CR>
" nnoremap <silent>bd :BufferLineSortByDirectory<CR>

" Making monokai pro better
hi LineNr ctermfg=246 ctermbg=59 cterm=NONE guifg=#959394 guibg=NONE gui=NONE

nnoremap <silent>K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>

" let g:markdown_folding = 1

