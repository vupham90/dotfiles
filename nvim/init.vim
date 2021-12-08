call plug#begin('~/.config/nvim/plugged')
" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
" Autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'onsails/lspkind-nvim'
Plug 'ray-x/lsp_signature.nvim'
" Snippets
Plug 'SirVer/ultisnips' 
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'honza/vim-snippets'
" Fuzzy search
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" Status & buffer 
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim'
" Tree
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
" Git
Plug 'tpope/vim-fugitive'
" Syntax highlight
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Auto add brackets
Plug 'windwp/nvim-autopairs'
" Just theme
Plug 'ayu-theme/ayu-vim'
" Dev tools
Plug 'fatih/vim-go'
Plug 'vupham90/protobuf.vim'
call plug#end()

lua << EOF
require("conf.treesitter")
require("conf.nvimtree")
require("conf.cmp")
require("conf.telescope")
require("conf.lualine")
require("conf.gopls")

require "lsp_signature".setup()
require("bufferline").setup()
require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" },
})
EOF

set path+=**
set wildmenu
set autoindent
set smartindent
filetype plugin indent on
set incsearch
set ruler
set mouse=a
set tabstop=4
set shiftwidth=4
set number
set relativenumber
set hidden
set termguicolors
set lazyredraw
set splitright
set splitbelow
set clipboard=unnamed,unnamedplus
set autoread
au CursorHold * checktime

let ayucolor="dark"
colorscheme ayu

let mapleader = "\<Space>"
nnoremap ; :
vnoremap ; :

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nmap <Up> <C-w><Up>
nmap <Down> <C-w><Down>
nmap <Left> <C-w><Left>
nmap <Right> <C-w><Right>

" Find [D]efinitions
nnoremap <Leader>d <cmd>Telescope lsp_definitions<cr>
" Find [R]eferences
nnoremap <Leader>r <cmd>Telescope lsp_references<cr><esc>
" Find [I]mplementation
nnoremap <Leader>i <cmd>Telescope lsp_implementations<cr><esc>
" Find [F]ile
nnoremap <Leader>f <cmd>Telescope find_files<cr>
" Find [S]ymbol
nnoremap <Leader>s <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
" Find [B]uffers
nnoremap <Leader>b <cmd>Telescope buffers<cr><esc>
" Find [T]ext
nnoremap <Leader>t <cmd>Telescope live_grep<cr>
" [A]ction
nnoremap <Leader>a <cmd>Telescope lsp_code_actions<cr><esc>
" Find [G]it [B]ranches
nnoremap <Leader>gb <cmd>Telescope git_branches<cr>
" [R]e[n]ame
nnoremap <Leader>rn <cmd>lua vim.lsp.buf.rename()<cr>
" [N]vim[T]ree
nnoremap <Leader>nt :NvimTreeToggle<CR>

" Autoformat on save with LSP
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.go.in lua vim.lsp.buf.formatting_sync(nil, 1000)

"Reload Nvim config
nnoremap <C-r> :source $MYVIMRC<cr>
nnoremap <C-s> :up<cr>
nnoremap <C-q> :q<cr>

let g:UltiSnipsJumpForwardTrigger="<C-l>"
let g:UltiSnipsJumpBackwardTrigger="<C-h>"

" Background colors for active vs inactive windows
hi InactiveWindow guibg=#17252c
hi ActiveWindow guibg=#0D1B22

" Call method on window enter
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END

" Change highlight group of active/inactive windows
function! Handle_Win_Enter()
  setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
endfunction
