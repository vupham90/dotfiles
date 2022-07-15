local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
		vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<C-h>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
    })
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
	{ name = 'snippy' },
	{ name = 'ultisnips' },
  }),
  formatting = {
    format = require("lspkind").cmp_format({with_text = true, menu = ({
      buffer = "[Buffer]",
      nvim_lsp = "[LSP]",
	  ultisnips = "[UltiSnips]",
    })}),
  },
})

-- Setup lspconfig.
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>fm', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

