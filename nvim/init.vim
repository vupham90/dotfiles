call plug#begin('~/.config/nvim/plugged')

" LSP & Autocomplete
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

" Autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'onsails/lspkind-nvim'

" Snippets
Plug 'dcampos/nvim-snippy'
Plug 'dcampos/cmp-snippy'
Plug 'honza/vim-snippets'

Plug 'fatih/vim-go'

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

let ayucolor="dark"   " for dark version of theme
colorscheme ayu

nnoremap ; :
vnoremap ; :

" Panel & buffer navigation
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nmap <Up> <C-w><Up>
nmap <Down> <C-w><Down>
nmap <Left> <C-w><Left>
nmap <Right> <C-w><Right>

let mapleader = "\<Space>"

" Jump
nnoremap gd <cmd>Telescope lsp_definitions<cr>
nnoremap gr <cmd>Telescope lsp_references<cr>
nnoremap gi <cmd>Telescope lsp_implementations<cr>
nnoremap gf <cmd>Telescope find_files<cr>
nnoremap gs <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap gb <cmd>Telescope buffers<cr>
nnoremap gt <cmd>Telescope live_grep<cr>
nnoremap ggb <cmd>Telescope git_branches<cr>

" Action
nnoremap <Leader>rn <cmd>lua vim.lsp.buf.rename()<cr>

" NvimTree
nnoremap <Leader>t :NvimTreeToggle<CR>

" Autoformat on save with LSP
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.go.in lua vim.lsp.buf.formatting_sync(nil, 1000)

"Reload Nvim config
nnoremap <Leader>rl :source $MYVIMRC<cr>
nnoremap <Leader>s :up<cr>
nnoremap <Leader>w :q<cr>

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
	defaults = {
		mappings = {
			i = {
				['<C-k>'] = require "telescope.actions".move_selection_previous,
				['<C-j>'] = require "telescope.actions".move_selection_next,
				["<Esc>"] = require "telescope.actions".close,}
		}
	},
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
