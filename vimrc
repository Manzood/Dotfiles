let mapleader = " "
:imap jk <Esc>
:cmap jk <Esc>
" :imap kj <Esc>
" :cmap kj <Esc>
:imap JK <Esc>
:cmap JK <Esc>
set timeoutlen=200

filetype plugin indent on
syntax on
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set mouse=a
set autoindent
set incsearch
set hidden
set number
set rnu
colorscheme industry

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set rnu
    autocmd BufLeave,FocusLost,InsertEnter * set nornu
augroup END
