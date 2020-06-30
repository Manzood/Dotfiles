" vim-plug section
" Plug was installed from https://github.com/junegunn/vim-plug
" To look up syntax or help, their README.md is pretty well written

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-sensible'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
call plug#end()

runtime! plugin/sensible.vim

"basic configurations
"set showmatch
"set hlsearch
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set mouse=a
set autoindent
set number
"Adds the ability to leave files without saving, HUGE timesaver for FZF
set hidden      
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set rnu
    autocmd BufLeave,FocusLost,InsertEnter * set nornu
augroup END
augroup Mkdir
  autocmd!
  autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup END
filetype plugin indent on
syntax on
autocmd BufEnter * silent! lcd %:p:h


"Setting the comma as my current leader, although that is subject to change
let mapleader = ","

"For opening up files with fuzzy searching
nnoremap <leader>f :FZF<cr>
nnoremap <leader>F :FZF ~<cr>
if has("nvim")
    " Escape inside a FZF terminal window should exit the terminal window
    " rather than going into the terminal's normal mode.
    autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>
endif


"Useful competitive coding commmands that I have found
nmap <leader>y ggVG"+y''
nmap <leader>d ggdG
nnoremap <leader>o :!gnome-terminal<cr>
nnoremap <leader>c :e ~/.config/nvim/init.vim<cr>
nnoremap <leader>q :wq<cr>
nnoremap <leader>Q :q!<cr>
"The following maps <Ctrl+/> as a comment line command
nnoremap <C-_> I//<esc>
inoremap <C-_> <esc>I//<esc>
"This remap is subject to improvement as it only works in normal mode
autocmd filetype cpp map <F5> :w <bar> !g++ -std=c++17 -Wall -O2 % -o %< <CR>
"the "&& ./%< runs the file,
"Therefore enabling the next line will make F9 compile and run
autocmd filetype cpp nnoremap <F9> :w <bar> !g++ -ulimit -Wall -Wno-unused-result -std=c++11   -O2   % -o %:r && ./%:r <CR>

"Useful for future code templates
"autocmd BufNewFile *.cpp -r ~/cp/template.cpp

colorscheme vim-monokai-tasty
let g:lightline = { 'colorscheme': 'monokai_tasty' }

"Setting up UltiSnips
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
let g:UltiSnipsSnippetDirectories=["UltiSnips","mytemplates"]
