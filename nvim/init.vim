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
Plug 'christoomey/vim-tmux-navigator'
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

nnoremap <Leader>d <cmd>Telescope lsp_definitions<cr>
nnoremap <Leader>r <cmd>Telescope lsp_references<cr><esc>
nnoremap <Leader>i <cmd>Telescope lsp_implementations<cr><esc>

nnoremap <Leader>ff <cmd>Telescope find_files<cr>
nnoremap <Leader>fs <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap <Leader>fb <cmd>Telescope buffers<cr><esc>
nnoremap <Leader>fib <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <Leader>ft <cmd>Telescope live_grep<cr>
nnoremap <Leader>aa <cmd>Telescope lsp_code_actions<cr><esc>
nnoremap <Leader>ar <cmd>lua vim.lsp.buf.rename()<cr>

nnoremap <Leader>gb <cmd>Telescope git_branches<cr>
nnoremap <Leader>gc <cmd>Telescope git_commits<cr>
nnoremap <Leader>gp <cmd>:Git pull<cr>
nnoremap <Leader>gf <cmd>:Git fetch<cr>
nnoremap <Leader>gt <cmd>:Telescope git_status<cr>
nnoremap <Leader>gg :Git 

nnoremap <Leader>yp <cmd>:let @+ = expand("%")<cr>
nnoremap <Leader>yl <cmd>:let @+=expand("%") . ':' . line(".")<cr>

nnoremap <Leader>nt :NvimTreeToggle<CR>
nnoremap <Leader>nr :NvimTreeRefresh<CR>

" Autoformat on save with LSP
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.go.in lua vim.lsp.buf.formatting_sync(nil, 1000)

"Reload Nvim config
nnoremap <C-r> :source $MYVIMRC<cr>
nnoremap <C-s> :up<cr>
inoremap <C-s> <Esc>:up<cr>
nnoremap <C-d> :q<cr>

let g:UltiSnipsJumpForwardTrigger="<C-n>"
let g:UltiSnipsJumpBackwardTrigger="<C-p>"

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
