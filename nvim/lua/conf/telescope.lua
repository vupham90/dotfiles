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
