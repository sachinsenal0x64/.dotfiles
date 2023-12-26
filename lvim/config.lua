-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- Misc

vim.opt.mouse = ""
lvim.transparent_window = true
lvim.leader = "space"
lvim.colorscheme = "pywal"
vim.opt.termguicolors = true

-- Keybindigs

-- lvim.builtin.which_key.mappings = {
--   ["c"] = { "<cmd>BufferClose!<CR>", "Close Buffer" },
--   ["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
--   ["h"] = { '<cmd>let @/=""<CR>', "No Highlight" },
--   ["i"] = { "<cmd>Lazy install<cr>", "Install" },
--   ["z"] = { "<cmd>Lazy sync<cr>", "Sync" },
--   ["S"] = { "<cmd>Lazy clear<cr>", "Status" },
--   ["u"] = { "<cmd>Lazy update<cr>", "Update" },
--  }

-- Plugins

lvim.plugins = {
	{
		"AlphaTechnolog/pywal.nvim",
		config = function()
			require("pywal").setup()
		end,
	},

	-- DASHBOARD
	{
		"glepnir/dashboard-nvim",
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
		event = "VimEnter",
		opts = function()
			return {
				theme = "hyper",
				config = {
					week_header = {
						enable = true,
					},
					shortcut = {
						{
							desc = "Restore Session",
							icon = " ",
							icon_hl = "@function",
							action = 'lua require("persistence").load()',
							key = "s",
						},
						{
							desc = "Files",
							icon = " ",
							icon_hl = "@variable",
							group = "Label",
							action = "Telescope find_files",
							key = "f",
						},
						{
							desc = "Oil",
							icon = "󰈙 ",
							icon_hl = "@variable",
							group = "Label",
							action = ":Oil",
							key = ".",
						},
						{
							desc = "MRU",
							icon = " ",
							group = "DiagnosticHint",
							action = "Telescope oldfiles",
							key = "r",
						},
						{
							desc = "dotfiles",
							icon = " ",
							action = "Config",
							key = "d",
						},
						{
							desc = "Lazy",
							icon = "󰒲 ",
							icon_hl = "@property",
							group = "Label",
							action = "Lazy",
							key = "z",
						},
						{
							desc = "Quit",
							icon = " ",
							icon_hl = "@property",
							action = "qa",
							key = "q",
						},
					},
				},
			}
		end,
	},

	-- LSP

	{
		"pappasam/jedi-language-server",
		config = function()
			require("lspconfig").jedi_language_server.setup({
				cmd = { "jedi-language-server" },
				filetypes = { "python" },
				single_file_support = true,
				root_dir = function()
					return vim.loop.cwd()
				end,
			})
		end,
	},

	-- FORMATTNG

	{
		"stevearc/conform.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					svelte = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					graphql = { "prettier" },
					lua = { "stylua" },
					python = { "isort", "black" },
				},
				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>mf", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Format file or range (in visual mode)" })
		end,
	},

	-- TYPE CHECKING

	{
		"mfussenegger/nvim-lint",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				svelte = { "eslint_d" },
				python = { "pylint" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})

			vim.keymap.set({ "n", "v" }, "<leader>ml", function()
				lint.try_lint()
			end, { desc = "Trigger linting for current file" })
		end,
	},
}
