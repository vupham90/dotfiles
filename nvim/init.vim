call plug#begin('~/.config/nvim/plugged')

" LSP & Autocomplete
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/vim-vsnip'

" Fuzzy search
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" UI stuffs
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

Plug 'tpope/vim-fugitive'

" Syntax highlight
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Just theme
Plug 'ayu-theme/ayu-vim'

call plug#end()

" Common sense
set path+=**
set wildmenu
set autoindent
set smartindent
set incsearch
set ruler
set mouse=a
set tabstop=4
set shiftwidth=4
set number relativenumber

set termguicolors
set lazyredraw
set splitright
set splitbelow

set autoread
au CursorHold * checktime

let ayucolor="dark"   " for dark version of theme
colorscheme ayu

" Remap
nnoremap <Right> :bnext<CR>
nnoremap <Left> :bprevious<CR>
nnoremap ; :

let mapleader = "\\"

" LSP
nnoremap <Leader>f <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap <Leader>g <cmd>Telescope live_grep<cr>
nnoremap <Leader>d <cmd>Telescope lsp_definitions<cr>
nnoremap <Leader>r <cmd>Telescope lsp_references<cr>
nnoremap <Leader>i <cmd>Telescope lsp_implementations<cr>
nnoremap <Leader>rn <cmd>lua vim.lsp.buf.rename()<cr>

" NvimTree
nnoremap <Leader>t :NvimTreeToggle<CR>

" Copy/paste with clipboard
noremap <Leader>y "*y
noremap <Leader>p "*P
noremap <Leader>Y "+y
noremap <Leader>P "+P

" Autoformat on save with LSP
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.go.in lua vim.lsp.buf.formatting_sync(nil, 1000)

"Reload Nvim config
nnoremap <Leader>sv :source $MYVIMRC<cr>

" Complex configs
lua require("cmp_lsp")
lua require("treesitter")
lua require("nvim_tree")

" Simple configs
lua << EOF
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff',
                  {'diagnostics', sources={'nvim_lsp', 'coc'}}},
    lualine_c = {
		{
			'filename',
			path = 1
		}
	},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
require('telescope').load_extension('fzf')
EOF
lua require("bufferline").setup()

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
