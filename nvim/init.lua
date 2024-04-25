-- Disable The StatusLine

vim.api.nvim_create_autocmd('User', {
  pattern = { 'AlphaReady', 'Noice' },
  command = 'set laststatus=0',
})

vim.api.nvim_create_autocmd('BufUnload', {
  buffer = 0,
  callback = function()
    vim.opt.laststatus = 2
  end,
})

vim.opt.termguicolors = true
vim.opt.autochdir = true
vim.opt.swapfile = false

local function set_statusline_transparency()
  vim.opt.statusline = ' '
  vim.api.nvim_set_hl(0, 'Statusline', { link = 'Normal' })
end

-- Run the function when Neovim starts
vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = set_statusline_transparency })

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true
vim.o.cmdheight = 1

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = ''

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`

vim.opt.clipboard = 'unnamedplus'
-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', 'bp', '<Cmd>bp<CR>')
vim.keymap.set('n', 'bn', '<Cmd>bn<CR>')
vim.keymap.set('n', '<F9>', '<Cmd>bd<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('v', 'ss', '<Cmd>SessionsSave<CR>')
vim.keymap.set('v', 'sr', '<Cmd>SessionsLoad<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- debug.lua
  --
  -- Shows how to use the DAP plugin to debug your code.
  --
  -- Primarily focused on configuring the debugger for Go, but can
  -- be extended to other languages as well. That's why it's called
  -- kickstart.nvim and not kitchen-sink.nvim ;)

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    lazy = false,
    opts = {},
  },

  {

    -- NOTE: Yes, you can install new plugins here!
    'mfussenegger/nvim-dap',
    -- NOTE: And you can specify dependencies as well
    dependencies = {
      -- Creates a beautiful debugger UI
      'rcarriga/nvim-dap-ui',

      -- Required dependency for nvim-dap-ui
      'nvim-neotest/nvim-nio',

      -- Installs the debug adapters for you
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- Add your own debuggers here
      'leoluz/nvim-dap-go',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      require('mason-nvim-dap').setup {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_setup = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          'delve',
        },
      }

      -- Basic debugging keymaps, feel free to change to your liking!
      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
      vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
      vim.keymap.set('n', '<leader>B', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = 'Debug: Set Breakpoint' })

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      dapui.setup {
        -- Set icons to characters that are more likely to work in every terminal.
        --    Feel free to remove or use ones that you like more! :)
        --    Don't feel like these are good choices.
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
      }

      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      -- Install golang specific config
      require('dap-go').setup()
    end,

    { -- Add indentation guides even on blank lines
      'lukas-reineke/indent-blankline.nvim',
      -- Enable `lukas-reineke/indent-blankline.nvim`
      -- See `:help ibl`
      main = 'ibl',
      opts = {},
    },

    {
      'sachinsenal0x64/hot.nvim',
      config = function()
        local opts = require('hot.params').opts

        -- Update the Lualine Status
        Reloader = opts.tweaks.default
        Reloader = '💤'

        Pattern = opts.tweaks.patterns
        Pattern = { 'main.py', 'main.go' }

        opts.tweaks.start = '🚀'
        opts.tweaks.stop = '💤'
        opts.tweaks.test = '🧪'
        opts.tweaks.test_done = '🧪.✅'
        opts.tweaks.test_fail = '🧪.❌'

        -- If the 'main.*' file doesn't exist, it will fall back to 'index.*'
        opts.tweaks.custom_file = 'index'

        -- Add Languages
        opts.set.languages.python = {
          cmd = 'python3',
          desc = 'Run Python file asynchronously',
          kill_desc = 'Kill the running Python file',
          emoji = '🐍',
          test = 'python -m unittest -v',
          ext = { '.py' },
        }

        opts.set.languages.go = {
          cmd = 'go run',
          desc = 'Run Go file asynchronously',
          kill_desc = 'Kill the running Go file',
          emoji = '🐹',
          test = 'go test',
          ext = { '.go' },
        }

        -- Thot Health Check
        vim.api.nvim_set_keymap('n', 'ho', '<Cmd>lua require("thot").check()<CR>', { noremap = true, silent = true })

        -- Keybinds

        -- Start
        vim.api.nvim_set_keymap('n', '<F3>', '<Cmd>lua require("hot").restart()<CR>', { noremap = true, silent = true })
        -- Silent
        vim.api.nvim_set_keymap('n', '<F4>', '<Cmd>lua require("hot").silent()<CR>', { noremap = true, silent = true })
        -- Stop
        vim.api.nvim_set_keymap('n', '<F5>', '<Cmd>lua require("hot").stop()<CR>', { noremap = true, silent = true })
        -- Test
        vim.api.nvim_set_keymap('n', '<F6>', '<Cmd>lua require("hot").test_restart()<CR>', { noremap = true, silent = true })
        -- Close Buffer
        vim.api.nvim_set_keymap('n', '<F8>', '<Cmd>lua require("hot").close_output_buffer()<CR>', { noremap = true, silent = true })
        -- Open Buffer
        vim.api.nvim_set_keymap('n', '<F7>', '<Cmd>lua require("hot").open_output_buffer()<CR>', { noremap = true, silent = true })

        -- Auto Reload on Save

        local save_group = vim.api.nvim_create_augroup('save_mapping', { clear = true })
        vim.api.nvim_create_autocmd('BufWritePost', {
          desc = 'Reloader',
          group = save_group,
          pattern = Pattern,
          callback = function()
            require('hot').silent()
          end,
        })
      end,
    },
    {
      'yanskun/gotests.nvim',
      ft = 'go',
      config = function()
        require('gotests').setup()
      end,
    },
    {
      'rolv-apneseth/tfm.nvim',
      lazy = false,
      opts = {
        -- TFM to use
        -- Possible choices: "ranger" | "nnn" | "lf" | "vifm" | "yazi" (default)
        file_manager = 'yazi',
        -- Replace netrw entirely
        -- Default: false
        replace_netrw = true,
        -- Enable creation of commands
        -- Default: false
        -- Commands:
        --   Tfm: selected file(s) will be opened in the current window
        --   TfmSplit: selected file(s) will be opened in a horizontal split
        --   TfmVsplit: selected file(s) will be opened in a vertical split
        --   TfmTabedit: selected file(s) will be opened in a new tab page
        enable_cmds = true,
        -- Custom keybindings only applied within the TFM buffer
        -- Default: {}
        keybindings = {
          ['<ESC>'] = 'q',
          -- Override the open mode (i.e. vertical/horizontal split, new tab)
          -- Tip: you can add an extra `<CR>` to the end of these to immediately open the selected file(s) (assuming the TFM uses `enter` to finalise selection)
          ['<C-v>'] = "<C-\\><C-O>:lua require('tfm').set_next_open_mode(require('tfm').OPEN_MODE.vsplit)<CR>",
          ['<C-x>'] = "<C-\\><C-O>:lua require('tfm').set_next_open_mode(require('tfm').OPEN_MODE.split)<CR>",
          ['<C-t>'] = "<C-\\><C-O>:lua require('tfm').set_next_open_mode(require('tfm').OPEN_MODE.tabedit)<CR>",
        },
        -- Customise UI. The below options are the default
        ui = {
          border = 'rounded',
          height = 0.8,
          width = 0.8,
          x = 0.5,
          y = 0.5,
        },
      },
      keys = {
        -- Make sure to change these keybindings to your preference,
        -- and remove the ones you won't use
        {
          '<leader>e',
          ':Tfm<CR>',
          desc = 'TFM',
        },
        {
          '<leader>mh',
          ':TfmSplit<CR>',
          desc = 'TFM - horizontal split',
        },
        {
          '<leader>mv',
          ':TfmVsplit<CR>',
          desc = 'TFM - vertical split',
        },
        {
          '<leader>mt',
          ':TfmTabedit<CR>',
          desc = 'TFM - new tab',
        },
      },
    },
    {
      'siawkz/nvim-cheatsh',
      dependencies = {
        'nvim-telescope/telescope.nvim',
      },
      opts = {
        cheatsh_url = 'https://cht.sh/', -- URL of the cheat.sh instance to use, support self-hosted instances
        position = 'bottom', -- position of the window can be: bottom, top, left, right
        height = 20, -- height of the cheat when position is top or bottom
        width = 100, -- width of the cheat when position is left or right
      },
    },

    -- SESSION MANAGER

    {
      'natecraddock/sessions.nvim',
      config = function()
        require('sessions').setup {
          session_filepath = vim.fn.stdpath 'data' .. '/sessions',
          absolute = true,
          autosave = true,
          save = true,
        }
      end,
    },

    -- IMAGE PREVIEW
    {
      '3rd/image.nvim',
      config = function()
        require('image').setup {
          backend = 'kitty',
          integrations = {
            markdown = {
              enabled = true,
              clear_in_insert_mode = true,
              download_remote_images = true,
              only_render_image_at_cursor = true,
              filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
            },
            neorg = {
              enabled = true,
              clear_in_insert_mode = true,
              download_remote_images = true,
              only_render_image_at_cursor = true,
              filetypes = { 'norg' },
            },
          },
          max_width = nil,
          max_height = nil,
          max_width_window_percentage = nil,
          max_height_window_percentage = 50,
          window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
          window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
          editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
          tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
          hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp' }, -- render image files as images when opened
        }
      end,
    },
    -- Here is a more advanced example where we pass configuration
    -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
    --    require('gitsigns').setup({ ... })
    --
    -- See `:help gitsigns` to understand what the configuration keys do
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
      'lewis6991/gitsigns.nvim',

      config = function()
        require('gitsigns').setup {

          signs = {
            add = { text = '┃' },
            change = { text = '┃' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
            untracked = { text = '┆' },
          },
          signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
          numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
          linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
          word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
          watch_gitdir = {
            follow_files = true,
          },
          auto_attach = true,
          attach_to_untracked = false,
          current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
          current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
            virt_text_priority = 100,
          },
          current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
          current_line_blame_formatter_opts = {
            relative_time = false,
          },
          sign_priority = 6,
          update_debounce = 100,
          status_formatter = nil, -- Use default
          max_file_length = 40000, -- Disable if file is longer than this (in lines)
          preview_config = {
            -- Options passed to nvim_open_win
            border = 'single',
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1,
          },
        }
      end,
    },
    -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
    --
    -- This is often very useful to both group configuration, as well as handle
    -- lazy loading plugins that don't need to be loaded immediately at startup.
    --
    -- For example, in the following configuration, we use:
    --  event = 'VimEnter'
    --
    -- which loads which-key before all the UI elements are loaded. Events can be
    -- normal autocommands events (`:help autocmd-events`).
    --
    -- Then, because we use the `config` key, the configuration only runs
    -- after the plugin has been loaded:
    --  config = function() ... end

    -- VENV SWITCHER

    {
      'linux-cultist/venv-selector.nvim',
      dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
      opts = {
        -- Your options go here
        venvwrapper_path = '~/Documents/venv/',
        auto_refresh = true,
      },
      event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
      keys = {
        -- Keymap to open VenvSelector to pick a venv.
        { '<leader>vs', '<cmd>VenvSelect<cr>' },
        -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
        { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
      },
    },

    -- GO

    {
      'ray-x/go.nvim',
      dependencies = { -- optional packages
        'ray-x/guihua.lua',
      },
      config = function()
        require('go').setup()
      end,
      event = { 'CmdlineEnter' },
      ft = { 'go', 'gomod' },
      build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    },

    { -- Linting
      'mfussenegger/nvim-lint',
      event = { 'BufReadPre', 'BufNewFile' },
      config = function()
        local lint = require 'lint'
        lint.linters_by_ft = {
          python = { 'pylint', 'ruff', 'mypy' },
          clojure = { 'clj-kondo' },
          dockerfile = { 'hadolint' },
          inko = { 'inko' },
          janet = { 'janet' },
          json = { 'jsonlint' },
          markdown = { 'vale' },
          rst = { 'vale' },
          ruby = { 'ruby' },
          terraform = { 'tflint' },
          text = { 'vale' },
        }

        -- To allow other plugins to add linters to require('lint').linters_by_ft,
        -- instead set linters_by_ft like this:
        -- lint.linters_by_ft = lint.linters_by_ft or {}
        -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
        --
        -- However, note that this will enable a set of default linters,
        -- which will cause errors unless these tools are available:
        --
        -- You can disable the default linters by setting their filetypes to nil:
        -- lint.linters_by_ft['clojure'] = nil
        -- lint.linters_by_ft['dockerfile'] = nil
        -- lint.linters_by_ft['inko'] = nil
        -- lint.linters_by_ft['janet'] = nil
        -- lint.linters_by_ft['json'] = nil
        -- lint.linters_by_ft['markdown'] = nil
        -- lint.linters_by_ft['rst'] = nil
        -- lint.linters_by_ft['ruby'] = nil
        -- lint.linters_by_ft['terraform'] = nil
        -- lint.linters_by_ft['text'] = nil

        -- Create autocommand which carries out the actual linting
        -- on the specified events.
        local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
          group = lint_augroup,
          callback = function()
            require('lint').try_lint()
          end,
        })
        -- Set pylint to work in virtualenv
        require('lint').linters.pylint.cmd = 'python'
        require('lint').linters.pylint.args = { '-m', 'pylint', '-f', 'json' }
      end,
    },

    { -- Useful plugin to show you pending keybinds.
      'folke/which-key.nvim',
      event = 'VimEnter', -- Sets the loading event to 'VimEnter'
      config = function() -- This is the function that runs, AFTER loading
        require('which-key').setup()

        -- Document existing key chains
        require('which-key').register {
          ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
          ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
          ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
          ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
          ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
        }
      end,
    },
    {
      'NeogitOrg/neogit',
      dependencies = {
        'nvim-lua/plenary.nvim', -- required
        'sindrets/diffview.nvim', -- optional - Diff integration

        -- Only one of these is needed, not both.
        'nvim-telescope/telescope.nvim', -- optional
        'ibhagwan/fzf-lua', -- optional
      },
      config = function()
        require('neogit').setup { config = true }
      end,
    },
    { 'sitiom/nvim-numbertoggle' },
    {
      'brenoprata10/nvim-highlight-colors',
      config = function()
        require('nvim-highlight-colors').setup {
          ---Render style
          ---@usage 'background'|'foreground'|'virtual'
          render = 'background',

          ---Set virtual symbol (requires render to be set to 'virtual')
          virtual_symbol = '■',

          ---Highlight named colors, e.g. 'green'
          enable_named_colors = true,

          ---Highlight tailwind colors, e.g. 'bg-blue-500'
          enable_tailwind = true,

          ---Set custom colors
          ---Label must be properly escaped with '%' to adhere to `string.gmatch`
          --- :help string.gmatch
          custom_colors = {
            { label = '%-%-theme%-primary%-color', color = '#0f1219' },
            { label = '%-%-theme%-secondary%-color', color = '#5a5d64' },
          },
        }
      end,
    },
    {
      'xiyaowong/transparent.nvim',
      config = function()
        require('transparent').setup { -- Optional, you don't have to run setup.
          groups = { -- table: default groups
            'Normal',
            'NormalNC',
            'Comment',
            'Constant',
            'Special',
            'Identifier',
            'Statement',
            'PreProc',
            'Type',
            'Underlined',
            'Todo',
            'String',
            'Function',
            'Conditional',
            'Repeat',
            'Operator',
            'Structure',
            'LineNr',
            'NonText',
            'SignColumn',
            'CursorLine',
            'CursorLineNr',
            'StatusLine',
            'StatusLineNC',
            'EndOfBuffer',
          },
          extra_groups = {
            'NormalFloat', -- plugins which have float panel such as Lazy, Mason, LspInfo
            'NvimTreeNormal',
            'Float',
            'Pmenu',
            'PmenuSbar',
            'PmenuThumb',
            'PmenuSel',
          }, -- table: additional groups that should be cleared
          exclude_groups = {}, -- table: groups you don't want to clear
        }
      end,
    },
    {
      'ellisonleao/gruvbox.nvim',
      config = function()
        require('gruvbox').setup {
          terminal_colors = true, -- add neovim terminal colors
          undercurl = true,
          underline = true,
          bold = true,
          italic = {
            strings = true,
            emphasis = true,
            comments = true,
            operators = false,
            folds = true,
          },
          strikethrough = true,
          invert_selection = false,
          invert_signs = false,
          invert_tabline = false,
          invert_intend_guides = false,
          inverse = true, -- invert background for search, diffs, statuslines and errors
          contrast = 'hard', -- can be "hard", "soft" or empty string
          palette_overrides = {},
          overrides = {},
          dim_inactive = true,
          transparent_mode = true,
        }
        vim.cmd 'colorscheme gruvbox'
      end,
    },
    {
      'fedepujol/move.nvim',
      config = function()
        require('move').setup {
          line = {
            enable = true, -- Enables line movement
            indent = true, -- Toggles indentation
          },
          block = {
            enable = true, -- Enables block movement
            indent = true, -- Toggles indentation
          },
          word = {
            enable = true, -- Enables word movement
          },
          char = {
            enable = true, -- Enables char movement
          },
        }
        local opts = { noremap = true, silent = true }
        -- Normal-mode commands
        vim.keymap.set('n', '<A-j>', ':MoveLine(1)<CR>', opts)
        vim.keymap.set('n', '<A-k>', ':MoveLine(-1)<CR>', opts)
        vim.keymap.set('n', '<A-h>', ':MoveHChar(-1)<CR>', opts)
        vim.keymap.set('n', '<A-l>', ':MoveHChar(1)<CR>', opts)
        vim.keymap.set('n', '<leader>wf', ':MoveWord(1)<CR>', opts)
        vim.keymap.set('n', '<leader>wb', ':MoveWord(-1)<CR>', opts)

        -- Visual-mode commands
        vim.keymap.set('v', '<A-j>', ':MoveBlock(1)<CR>', opts)
        vim.keymap.set('v', '<A-k>', ':MoveBlock(-1)<CR>', opts)

        vim.keymap.set('n', '<lt>', '<lt><lt>', { silent = true, desc = 'Outdent' })

        vim.keymap.set('n', '>', '>>', { silent = true, desc = 'Indent' })

        vim.keymap.set('v', '<lt>', '<lt>gv', { silent = true, desc = 'Indent' })

        vim.keymap.set('v', '>', '>gv', { silent = true, desc = 'Indent' })
      end,
    },
    {
      'linrongbin16/lsp-progress.nvim',
      config = function()
        require('lsp-progress').setup {
          client_format = function(client_name, spinner, series_messages)
            if #series_messages == 0 then
              return nil
            end
            return {
              name = client_name,
              body = spinner .. ' ' .. table.concat(series_messages, ', '),
            }
          end,
          format = function(client_messages)
            -- @param name string
            -- @param msg string?
            -- @return string
            local function stringify(name, msg)
              return msg and string.format('%s', name) or string.format('%s', name)
            end

            local lsp_clients = vim.lsp.get_active_clients()
            local client_names = {}

            for _, cli in ipairs(lsp_clients) do
              if type(cli) == 'table' and type(cli.name) == 'string' and string.len(cli.name) > 0 then
                table.insert(client_names, cli.name)
              end
            end

            local sign = '  LSP' -- nf-fa-gear \uf013
            local messages_map = {}

            for _, climsg in ipairs(client_messages) do
              messages_map[climsg.name] = climsg.body
            end

            if #lsp_clients > 0 then
              table.sort(lsp_clients, function(a, b)
                return a.name < b.name
              end)

              local builder = {}
              for _, name in ipairs(client_names) do
                if messages_map[name] then
                  table.insert(builder, stringify(name, messages_map[name]))
                else
                  table.insert(builder, stringify(name))
                end
              end

              if #builder > 0 then
                return sign .. ' [' .. table.concat(builder, ', ') .. ']'
              end
            end

            return ''
          end,
        }
      end,
    },
    {
      'folke/noice.nvim',
      dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        'MunifTanjim/nui.nvim',
        'rcarriga/nvim-notify',
      },
      init = function()
        require('notify').setup {
          -- other stuff
          background_colour = '#000000',
        }
      end,

      config = function()
        require('noice').setup {
          cmdline = {
            enabled = true, -- enables the Noice cmdline UI
            view = 'cmdline_popup', -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
            opts = {}, -- global options for the cmdline. See section on views
            ---@type table<string, CmdlineFormat>
            format = {
              -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
              -- view: (default is cmdline view)
              -- opts: any options passed to the view
              -- icon_hl_group: optional hl_group for the icon
              -- title: set to anything or empty string to hide
              cmdline = { pattern = '^:', icon = '', lang = 'vim' },
              search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
              search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
              filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
              lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
              help = { pattern = '^:%s*he?l?p?%s+', icon = '' },
              input = {}, -- Used by input()
              -- lua = false, -- to disable a format, set to `false`
            },
          },
          messages = {
            -- NOTE: If you enable messages, then the cmdline is enabled automatically.
            -- This is a current Neovim limitation.
            enabled = true, -- enables the Noice messages UI
            view = 'notify', -- default view for messages
            view_error = 'notify', -- view for errors
            view_warn = 'notify', -- view for warnings
            view_history = 'messages', -- view for :messages
            view_search = 'virtualtext', -- view for search count messages. Set to `false` to disable
          },
          popupmenu = {
            enabled = true, -- enables the Noice popupmenu UI
            ---@type 'nui'|'cmp'
            backend = 'nui', -- backend to use to show regular cmdline completions
            ---@type NoicePopupmenuItemKind|false
            -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
            kind_icons = {}, -- set to `false` to disable icons
          },
          -- default options for require('noice').redirect
          -- see the section on Command Redirection
          ---@type NoiceRouteConfig
          redirect = {
            view = 'popup',
            filter = { event = 'msg_show' },
          },
          notify = {
            -- Noice can be used as `vim.notify` so you can route any notification like other messages
            -- Notification messages have their level and other properties set.
            -- event is always "notify" and kind can be any log level as a string
            -- The default routes will forward notifications to nvim-notify
            -- Benefit of using Noice for this is the routing and consistent history view
            enabled = true,
            view = 'notify',
          },
          lsp = {
            progress = {
              enabled = false,
            },
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
              ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
              ['vim.lsp.util.stylize_markdown'] = true,
              ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
            },
          },
          -- you can enable a preset for easier configuration
          presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = true, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
          },
        }
      end,
    },
    {
      'ThePrimeagen/harpoon',
      branch = 'harpoon2',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'letieu/harpoon-lualine',
      },
      init = function()
        -- Harpoon telescope extension
        require('telescope').load_extension 'harpoon'
      end,
      config = function()
        local harpoon = require 'harpoon'

        harpoon:setup()
        vim.keymap.set('n', '<leader>h', '<cmd>Telescope harpoon marks<cr>')
        vim.keymap.set('n', '<A-a>', function()
          harpoon:list():add()
        end, { silent = true, desc = 'Append current file to harpoon' })
        vim.keymap.set('n', '<C-h>', function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { silent = true, desc = 'Toggle harpoon quick menu' })

        vim.keymap.set('n', '<leader>d', function()
          harpoon:list():remove()
        end, { silent = true, desc = 'Toggle to delete files from harpoon' })

        vim.keymap.set('n', '<leader>hn', function()
          harpoon:list():next { ui_nav_wrap = true }
        end, { silent = true, desc = 'Next Section' })

        vim.keymap.set('n', '<leader>hp', function()
          harpoon:list():prev { ui_nav_wrap = true }
        end, { silent = true, desc = 'Previous Section' })

        vim.keymap.set('n', '<A-1>', function()
          harpoon:list():select(1)
        end, { silent = true, desc = 'Jumps to item 1 in the list' })
        vim.keymap.set('n', '<A-2>', function()
          harpoon:list():select(2)
        end, { silent = true, desc = 'Jumps to item 2 in the list' })
        vim.keymap.set('n', '<A-3>', function()
          harpoon:list():select(3)
        end, { silent = true, desc = 'Jumps to item 3 in the list' })
        vim.keymap.set('n', '<A-4>', function()
          harpoon:list():select(4)
        end, { silent = true, desc = 'Jumps to item 4 in the list' })
      end,
    },
    {

      'nvim-lualine/lualine.nvim',
      dependencies = {
        'nvim-tree/nvim-web-devicons',
        'letieu/harpoon-lualine',
      },
      config = function()
        local lualine = require 'lualine'
        local colors = {
          bg = '#1e1e2e',
          fg = '#cdd6f4',
          yellow = '#f9e2af',
          cyan = '#89dceb',
          darkblue = '#89b4fa',
          green = '#a6e3a1',
          orange = '#fab387',
          violet = '#f5c2e7',
          magenta = '#cba6f7',
          blue = '#74c7ec',
          red = '#f38ba8',
          lightgreen = '#4f9e6f',
        }

        local conditions = {
          hide_in_width = function()
            return vim.fn.winwidth(0) > 80
          end,
        }

        local mode_color = {
          n = colors.red,
          i = colors.green,
          v = colors.blue,
          [''] = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          [''] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ['r?'] = colors.cyan,
          ['!'] = colors.red,
          t = colors.red,
        }

        local mode = {
          'mode',
          icon = ' ',
          separator = { left = '', right = '' },
          right_padding = 2,
          color = function()
            return { bg = mode_color[vim.fn.mode()], fg = colors.bg }
          end,
        }
        local filename = {
          'filename',
          file_status = true,
          color = { fg = colors.magenta, bg = 'None', gui = 'bold' },
        }
        local branch = {
          'branch',
          icon = '',
          color = { fg = colors.violet, bg = 'None', gui = 'bold' },
          on_click = function()
            vim.cmd 'Neogit'
          end,
        }
        local diagnostics = {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          symbols = { error = ' ', warn = ' ', info = ' ' },
          diagnostics_color = {
            color_error = { fg = colors.red, bg = 'None', gui = 'bold' },
            color_warn = { fg = colors.yellow, bg = 'None', gui = 'bold' },
            color_info = { fg = colors.cyan, bg = 'None', gui = 'bold' },
          },
          color = { bg = mode, gui = 'bold' },
        }
        local hot = {
          'Reloader',
        }
        local harpoon = {
          'harpoon2',
          icon = '󰀱',
          indicators = { '1', '2', '3', '4' },
          active_indicators = { '[1]', '[2]', '[3]', '[4]' },
          _separator = ' ',
          separator = { left = '', right = '' },
          color = function()
            return { bg = mode_color[vim.fn.mode()], fg = colors.bg, gui = 'bold' }
          end,
        }
        local diff = {
          'diff',
          symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
          diff_color = {
            added = { fg = colors.green, bg = 'None' },
            modified = { fg = colors.orange, bg = 'None' },
            removed = { fg = colors.red, bg = 'None' },
          },
          cond = conditions.hide_in_width,
        }
        local fileformat = {
          'fileformat',
          fmt = string.upper,
          color = { fg = colors.green, bg = 'None', gui = 'bold' },
        }

        local buffers = {
          function()
            local bufs = vim.api.nvim_list_bufs()
            local bufNumb = 0
            local function buffer_is_valid(buf_id, buf_name)
              return 1 == vim.fn.buflisted(buf_id) and buf_name ~= ''
            end
            for idx = 1, #bufs do
              local buf_id = bufs[idx]
              local buf_name = vim.api.nvim_buf_get_name(buf_id)
              if buffer_is_valid(buf_id, buf_name) then
                bufNumb = bufNumb + 1
              end
            end

            if bufNumb == 0 then
              return 'No buffs'
            elseif bufNumb == 1 then
              return bufNumb .. ' buff'
            else
              return bufNumb .. ' buffs'
            end
          end,
          color = { fg = colors.darkblue, bg = 'None' },
          on_click = function()
            require('buffer_manager.ui').toggle_quick_menu()
          end,
        }
        local filetype = {
          'filetype',
          icon_only = true,
          color = { fg = colors.darkblue, bg = 'None' },
        }
        local progress = {
          'progress',
          color = { fg = colors.magenta, bg = 'None' },
        }
        local location = {
          'location',
          separator = { left = '', right = '' },
          left_padding = 2,
          color = function()
            return { bg = mode_color[vim.fn.mode()], fg = colors.bg }
          end,
        }
        local sep = {
          '%=',
          color = { fg = colors.bg, bg = 'None' },
        }
        local lsp = {
          function()
            return require('lsp-progress').progress()
          end,
          color = { fg = colors.lightgreen, bg = 'None', gui = 'bold' },
        }

        lualine.setup {
          options = {
            extensions = { 'fzf', 'neo-tree' },
            theme = {
              normal = {
                a = { bg = 'None', gui = 'bold' },
                b = { bg = 'None', gui = 'bold' },
                c = { bg = 'None', gui = 'bold' },
                x = { bg = 'None', gui = 'bold' },
                y = { bg = 'None', gui = 'bold' },
                z = { bg = 'None', gui = 'bold' },
              },
              insert = {
                a = { bg = 'None', gui = 'bold' },
                b = { bg = 'None', gui = 'bold' },
                c = { bg = 'None', gui = 'bold' },
                x = { bg = 'None', gui = 'bold' },
                y = { bg = 'None', gui = 'bold' },
                z = { bg = 'None', gui = 'bold' },
              },
              visual = {
                a = { bg = 'None', gui = 'bold' },
                b = { bg = 'None', gui = 'bold' },
                c = { bg = 'None', gui = 'bold' },
                x = { bg = 'None', gui = 'bold' },
                y = { bg = 'None', gui = 'bold' },
                z = { bg = 'None', gui = 'bold' },
              },
              replace = {
                a = { bg = 'None', gui = 'bold' },
                b = { bg = 'None', gui = 'bold' },
                c = { bg = 'None', gui = 'bold' },
                x = { bg = 'None', gui = 'bold' },
                y = { bg = 'None', gui = 'bold' },
                z = { bg = 'None', gui = 'bold' },
              },
              command = {
                a = { bg = 'None', gui = 'bold' },
                b = { bg = 'None', gui = 'bold' },
                c = { bg = 'None', gui = 'bold' },
                x = { bg = 'None', gui = 'bold' },
                y = { bg = 'None', gui = 'bold' },
                z = { bg = 'None', gui = 'bold' },
              },
              inactive = {
                a = { bg = 'None', gui = 'bold' },
                b = { bg = 'None', gui = 'bold' },
                c = { bg = 'None', gui = 'bold' },
                x = { bg = 'None', gui = 'bold' },
                y = { bg = 'None', gui = 'bold' },
                z = { bg = 'None', gui = 'bold' },
              },
            },
            component_separators = '',
            section_separators = { left = '', right = '' },
            always_divide_middle = false,
          },
          winbar = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
          },
          sections = {
            lualine_a = { mode },
            lualine_b = {
              filename,
              hot,
              branch,
              diff,
              {
                require('noice').api.status.command.get,
                cond = require('noice').api.status.command.has,
                color = { fg = '#ff9e64' },
              },
            },
            lualine_c = {
              diagnostics,
              sep,
              harpoon,
            },
            lualine_x = { fileformat, lsp },
            lualine_y = { buffers, { 'filetype', cond = nil, padding = { left = 1, right = 1 }, color = { fg = colors.darkblue, bg = 'None' } }, progress },
            lualine_z = { location },
          },
          inactive_sections = {
            lualine_a = { 'filename' },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = { 'location' },
          },
          tabline = {},
        }
      end,
    },

    -- DASHBOARD

    {

      'goolord/alpha-nvim',
      dependencies = {
        'nvim-tree/nvim-web-devicons',
      },
      config = function()
        local alpha = require 'alpha'
        local dashboard = require 'alpha.themes.dashboard'

        _Gopts = {
          position = 'center',
          hl = 'Type',
          wrap = 'overflow',
        }

        -- DASHBOARD HEADER

        local function getGreeting(name)
          local tableTime = os.date '*t'
          local datetime = os.date ' %Y-%m-%d-%A   %H:%M:%S '
          local hour = tableTime.hour
          local greetingsTable = {
            [1] = '  Sleep well',
            [2] = '  Good morning',
            [3] = '  Good afternoon',
            [4] = '  Good evening',
            [5] = '󰖔  Good night',
          }
          local greetingIndex = 0
          if hour == 23 or hour < 7 then
            greetingIndex = 1
          elseif hour < 12 then
            greetingIndex = 2
          elseif hour >= 12 and hour < 18 then
            greetingIndex = 3
          elseif hour >= 18 and hour < 21 then
            greetingIndex = 4
          elseif hour >= 21 then
            greetingIndex = 5
          end
          return datetime .. '  ' .. greetingsTable[greetingIndex] .. ', ' .. name
        end

        local logo = [[


                                              
       ████ ██████           █████      ██
      ███████████             █████ 
      █████████ ███████████████████ ███   ███████████
     █████████  ███    █████████████ █████ ██████████████
    █████████ ██████████ █████████ █████ █████ ████ █████
  ███████████ ███    ███ █████████ █████ █████ ████ █████
 ██████  █████████████████████ ████ █████ █████ ████ ██████

      ]]

        local userName = 'Lazy'
        local greeting = getGreeting(userName)
        local marginBottom = 0
        dashboard.section.header.val = vim.split(logo, '\n')

        -- Split logo into lines
        local logoLines = {}
        for line in logo:gmatch '[^\r\n]+' do
          table.insert(logoLines, line)
        end

        -- Calculate padding for centering the greeting
        local logoWidth = logo:find '\n' - 1 -- Assuming the logo width is the width of the first line
        local greetingWidth = #greeting
        local padding = math.floor((logoWidth - greetingWidth) / 2)

        -- Generate spaces for padding
        local paddedGreeting = string.rep(' ', padding) .. greeting

        -- Add margin lines below the padded greeting
        local margin = string.rep('\n', marginBottom)

        -- Concatenate logo, padded greeting, and margin
        local adjustedLogo = logo .. '\n' .. paddedGreeting .. margin

        dashboard.section.buttons.val = {
          dashboard.button('n', '  New file', ':ene <BAR> startinsert <CR>'),
          dashboard.button('f', '  Find file', ':cd $HOME | silent Telescope find_files hidden=true no_ignore=true <CR>'),
          dashboard.button('t', '  Find text', ':Telescope live_grep <CR>'),
          dashboard.button('r', '󰄉  Recent files', ':Telescope oldfiles <CR>'),
          dashboard.button('u', '󱐥  Update plugins', '<cmd>Lazy update<CR>'),
          dashboard.button('c', '  Settings', ':e $HOME/.config/nvim/init.lua<CR>'),
          dashboard.button('p', '  Projects', ':e $HOME/Documents/github <CR>'),
          dashboard.button('d', '󱗼  Dotfiles', ':e $HOME/dotfiles <CR>'),
          dashboard.button('q', '󰿅  Quit', '<cmd>qa<CR>'),
        }

        -- local function footer()
        -- 	return "Footer Text"
        -- end

        -- dashboard.section.footer.val = vim.split('\n\n' .. getGreeting 'Lazy', '\n')

        vim.api.nvim_create_autocmd('User', {
          pattern = 'LazyVimStarted',
          desc = 'Add Alpha dashboard footer',
          once = true,
          callback = function()
            local stats = require('lazy').stats()
            local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
            dashboard.section.footer.val = { ' ', ' ', ' ', ' Loaded ' .. stats.count .. ' plugins  in ' .. ms .. ' ms ' }
            dashboard.section.header.opts.hl = 'DashboardFooter'
            pcall(vim.cmd.AlphaRedraw)
          end,
        })

        dashboard.opts.opts.noautocmd = true
        alpha.setup(dashboard.opts)
      end,
    },

    -- NOTE: Plugins can specify dependencies.
    --
    -- The dependencies are proper plugin specifications as well - anything
    -- you do for a plugin at the top level, you can do for a dependency.
    --
    -- Use the `dependencies` key to specify the dependencies of a particular plugin

    { -- Fuzzy Finder (files, lsp, etc)
      'nvim-telescope/telescope.nvim',
      event = 'VimEnter',
      branch = '0.1.x',
      dependencies = {
        'nvim-lua/plenary.nvim',
        { -- If encountering errors, see telescope-fzf-native README for installation instructions
          'nvim-telescope/telescope-fzf-native.nvim',

          -- `build` is used to run some command when the plugin is installed/updated.
          -- This is only run then, not every time Neovim starts up.
          build = 'make',

          -- `cond` is a condition used to determine whether this plugin should be
          -- installed and loaded.
          cond = function()
            return vim.fn.executable 'make' == 1
          end,
        },
        { 'nvim-telescope/telescope-ui-select.nvim' },

        -- Useful for getting pretty icons, but requires a Nerd Font.
        { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
      },
      config = function()
        -- Telescope is a fuzzy finder that comes with a lot of different things that
        -- it can fuzzy find! It's more than just a "file finder", it can search
        -- many different aspects of Neovim, your workspace, LSP, and more!
        --
        -- The easiest way to use Telescope, is to start by doing something like:
        --  :Telescope help_tags
        --
        -- After running this command, a window will open up and you're able to
        -- type in the prompt window. You'll see a list of `help_tags` options and
        -- a corresponding preview of the help.
        --
        -- Two important keymaps to use while in Telescope are:
        --  - Insert mode: <c-/>
        --  - Normal mode: ?
        --
        -- This opens a window that shows you all of the keymaps for the current
        -- Telescope picker. This is really useful to discover what Telescope can
        -- do as well as how to actually do it!

        -- [[ Configure Telescope ]]
        -- See `:help telescope` and `:help telescope.setup()`
        require('telescope').setup {
          -- You can put your default mappings / updates / etc. in here
          --  All the info you're looking for is in `:help telescope.setup()`
          --
          -- defaults = {
          --   mappings = {
          --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
          --   },
          -- },
          -- pickers = {}
          extensions = {
            ['ui-select'] = {
              require('telescope.themes').get_dropdown(),
            },
          },
        }

        -- Enable Telescope extensions if they are installed
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')

        -- See `:help telescope.builtin`
        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

        -- Slightly advanced example of overriding default behavior and theme
        vim.keymap.set('n', '<leader>/', '<CMD>Telescope current_buffer_fuzzy_find<CR>')

        -- It's also possible to pass additional configuration options.
        --  See `:help telescope.builtin.live_grep()` for information about particular keys
        vim.keymap.set('n', '<leader>s/', function()
          builtin.live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end, { desc = '[S]earch [/] in Open Files' })

        -- Shortcut for searching your Neovim configuration files
        vim.keymap.set('n', '<leader>sn', function()
          builtin.find_files { cwd = vim.fn.stdpath 'config' }
        end, { desc = '[S]earch [N]eovim files' })
      end,
    },

    { -- LSP Configuration & Plugins
      'neovim/nvim-lspconfig',
      dependencies = {
        -- Automatically install LSPs and related tools to stdpath for Neovim
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',

        -- Useful status updates for LSP.
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`

        -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        { 'folke/neodev.nvim', opts = {} },
      },

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      config = function()
        -- Brief aside: **What is LSP?**
        --
        -- LSP is an initialism you've probably heard, but might not understand what it is.
        --
        -- LSP stands for Language Server Protocol. It's a protocol that helps editors
        -- and language tooling communicate in a standardized fashion.
        --
        -- In general, you have a "server" which is some tool built to understand a particular
        -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
        -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
        -- processes that communicate with some "client" - in this case, Neovim!
        --
        -- LSP provides Neovim with features like:
        --  - Go to definition
        --  - Find references
        --  - Autocompletion
        --  - Symbol Search
        --  - and more!
        --
        -- Thus, Language Servers are external tools that must be installed separately from
        -- Neovim. This is where `mason` and related plugins come into play.
        --
        -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
        -- and elegantly composed help section, `:help lsp-vs-treesitter`
        --  This function gets run when an LSP attaches to a particular buffer.
        --    That is to say, every time a new file is opened that is associated with
        --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
        --    function will be executed to configure the current buffer
        require('lspconfig.ui.windows').default_options.border = 'rounded'

        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
          callback = function(event)
            -- NOTE: Remember that Lua is a real programming language, and as such it is possible
            -- to define small helper and utility functions so you don't have to repeat yourself.
            --
            -- In this case, we create a function that lets us more easily define mappings specific
            -- for LSP related items. It sets the mode, buffer and description for us each time.
            local map = function(keys, func, desc)
              vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
            end

            -- Jump to the definition of the word under your cursor.
            --  This is where a variable was first declared, or where a function is defined, etc.
            --  To jump back, press <C-t>.
            map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

            -- Find references for the word under your cursor.
            map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

            -- Jump to the implementation of the word under your cursor.
            --  Useful when your language has ways of declaring types without an actual implementation.
            map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

            -- Jump to the type of the word under your cursor.
            --  Useful when you're not sure what type a variable is and you want to see
            --  the definition of its *type*, not where it was *defined*.
            map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

            -- Fuzzy find all the symbols in your current document.
            --  Symbols are things like variables, functions, types, etc.
            map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

            -- Fuzzy find all the symbols in your current workspace.
            --  Similar to document symbols, except searches over your entire project.
            map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

            -- Rename the variable under your cursor.
            --  Most Language Servers support renaming across files, etc.
            map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

            -- Execute a code action, usually your cursor needs to be on top of an error
            -- or a suggestion from your LSP for this to activate.
            map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

            -- Opens a popup that displays documentation about the word under your cursor
            --  See `:help K` for why this keymap.
            map('K', vim.lsp.buf.hover, 'Hover Documentation')

            -- WARN: This is not Goto Definition, this is Goto Declaration.
            --  For example, in C this would take you to the header.
            map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

            -- The following two autocommands are used to highlight references of the
            -- word under your cursor when your cursor rests there for a little while.
            --    See `:help CursorHold` for information about when this is executed
            --
            -- When you move your cursor, the highlights will be cleared (the second autocommand).
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            if client and client.server_capabilities.documentHighlightProvider then
              vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                callback = vim.lsp.buf.document_highlight,
              })

              vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                callback = vim.lsp.buf.clear_references,
              })
            end
          end,
        })

        -- LSP servers and clients are able to communicate to each other what features they support.
        --  By default, Neovim doesn't support everything that is in the LSP specification.
        --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
        --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        -- Enable the following language servers
        --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
        --
        --  Add any additional override configuration in the following tables. Available keys are:
        --  - cmd (table): Override the default command used to start the server
        --  - filetypes (table): Override the default list of associated filetypes for the server
        --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
        --  - settings (table): Override the default settings passed when initializing the server.
        --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/

        local servers = {
          -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
          --
          -- Some languages (like typescript) have entire language plugins that can be useful:
          --    https://github.com/pmizio/typescript-tools.nvim
          --
          -- But for many setups, the LSP (`tsserver`) will work just fine

          -- tsserver = {},

          -- clangd = {},

          taplo = {},

          gopls = {},

          pyright = {},

          rust_analyzer = {},

          jedi_language_server = {
            cmd = { 'jedi-language-server' },
            filetypes = { 'python' },
            single_file_support = true,
            root_dir = function()
              return vim.loop.cwd()
            end,
          },

          ruff_lsp = {},

          lua_ls = {
            -- cmd = {...},
            -- filetypes = { ...},
            -- capabilities = {},
            settings = {
              Lua = {
                runtime = {
                  -- Tell the language server which version of Lua you're using (most likely LuaJIT)
                  version = 'LuaJIT',
                  -- Setup your lua path
                },
                completion = {
                  callSnippet = 'Both',
                },

                -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                -- diagnostics = { disable = { 'missing-fields' } },
              },
            },
          },
        }

        -- Ensure the servers and tools above are installed
        --  To check the current status of installed tools and/or manually install
        --  other tools, you can run
        --    :Mason
        --
        --  You can press `g?` for help in this menu.
        require('mason').setup {
          ui = {
            border = 'rounded',
            height = 0.8,
            icons = {
              package_installed = '✓',
              package_pending = '➜',
              package_uninstalled = '✗',
            },
          },
        }

        -- You can add other tools here that you want Mason to install
        -- for you, so that they are available from within Neovim.
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
          'stylua',
          'pylint',
          'prettier',
          'mypy',
          'isort',
          'ruff',
          'vale',
          'black',
        })
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        require('mason-lspconfig').setup {

          handlers = {
            function(server_name)
              local server = servers[server_name] or {}
              -- This handles overriding only values explicitly passed
              -- by the server configuration above. Useful when disabling
              -- certain features of an LSP (for example, turning off formatting for tsserver)
              server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
              require('lspconfig')[server_name].setup(server)
            end,
          },
        }
      end,
    },
    {
      'stevearc/conform.nvim',
      enabled = true,
      event = { 'BufReadPre', 'BufNewFile' }, -- to disable, comment this out
      config = function()
        local conform = require 'conform'

        conform.setup {
          formatters_by_ft = {
            javascript = { 'prettier' },
            typescript = { 'prettier' },
            javascriptreact = { 'prettier' },
            typescriptreact = { 'prettier' },
            svelte = { 'prettier' },
            css = { 'prettier' },
            html = { 'prettier' },
            json = { 'prettier' },
            yaml = { 'prettier' },
            markdown = { 'prettier' },
            graphql = { 'prettier' },
            lua = { 'stylua' },
            python = { 'isort', 'ruff_format', 'black' },
          },
          format_on_save = {
            lsp_fallback = true,
            async = false,
            timeout_ms = 1000,
          },
        }

        vim.keymap.set({ 'n', 'v' }, '<leader>mf', function()
          conform.format {
            lsp_fallback = true,
            async = false,
            timeout_ms = 1000,
          }
        end, { desc = 'Format file or range (in visual mode)' })
      end,
    },
    { -- Autocompletion
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
        -- Snippet Engine & its associated nvim-cmp source
        {
          'L3MON4D3/LuaSnip',
          build = (function()
            -- Build Step is needed for regex support in snippets.
            -- This step is not supported in many windows environments.
            -- Remove the below condition to re-enable on windows.
            if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
              return
            end
            return 'make install_jsregexp'
          end)(),
          dependencies = {
            -- `friendly-snippets` contains a variety of premade snippets.
            --    See the README about individual language/framework/plugin snippets:
            --    https://github.com/rafamadriz/friendly-snippets
            {
              'rafamadriz/friendly-snippets',
              config = function()
                require('luasnip.loaders.from_vscode').lazy_load()
              end,
            },
          },
        },
        'saadparwaiz1/cmp_luasnip',

        -- Adds other completion capabilities.
        --  nvim-cmp does not ship with all sources by default. They are split
        --  into multiple repos for maintenance purposes.
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
      },
      config = function()
        -- See `:help cmp`
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'
        luasnip.config.setup {}

        cmp.setup {
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },

          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },

          completion = { completeopt = 'menu,menuone,noinsert' },

          -- For an understanding of why these mappings were
          -- chosen, you will need to read `:help ins-completion`
          --
          -- No, but seriously. Please read `:help ins-completion`, it is really good!
          mapping = cmp.mapping.preset.insert {
            -- Select the [n]ext item
            ['<C-n>'] = cmp.mapping.select_next_item(),
            -- Select the [p]revious item
            ['<C-p>'] = cmp.mapping.select_prev_item(),

            -- Scroll the documentation window [b]ack / [f]orward
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),

            -- Accept ([y]es) the completion.
            --  This will auto-import if your LSP supports it.
            --  This will expand snippets if the LSP sent a snippet.
            ['<Return>'] = cmp.mapping.confirm { select = true },

            -- Manually trigger a completion from nvim-cmp.
            --  Generally you don't need this, because nvim-cmp will display
            --  completions whenever it has completion options available.
            ['<C-Space>'] = cmp.mapping.complete {},

            -- Think of <c-l> as moving to the right of your snippet expansion.
            --  So if you have a snippet that's like:
            --  function $name($args)
            --    $body
            --  end
            --
            -- <c-l> will move you to the right of each of the expansion locations.
            -- <c-h> is similar, except moving you backwards.
            ['<C-l>'] = cmp.mapping(function()
              if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              end
            end, { 'i', 's' }),
            ['<C-h>'] = cmp.mapping(function()
              if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              end
            end, { 'i', 's' }),

            -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
            --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
          },
          sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'path' },
            { name = 'buffer' },
          },
        }
      end,
    },

    -- Highlight todo, notes, etc in comments
    { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

    { -- Collection of various small independent plugins/modules
      'echasnovski/mini.nvim',
      config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [']quote
        --  - ci'  - [C]hange [I]nside [']quote
        require('mini.ai').setup { n_lines = 500 }

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        require('mini.surround').setup()

        -- Simple and easy statusline.
        --  You could remove this setup call if you don't like it,
        --  and try some other statusline plugin
        local statusline = require 'mini.statusline'
        -- set use_icons to true if you have a Nerd Font
        statusline.setup { use_icons = vim.g.have_nerd_font }

        -- You can configure sections in the statusline by overriding their
        -- default behavior. For example, here we set the section for
        -- cursor location to LINE:COLUMN
        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_location = function()
          return '%2l:%-2v'
        end

        -- ... and there is more!
        --  Check out: https://github.com/echasnovski/mini.nvim
      end,
    },
    { -- Highlight, edit, and navigate code
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      opts = {
        ensure_installed = { 'bash', 'c', 'html', 'lua', 'luadoc', 'markdown_inline', 'markdown', 'vim', 'vimdoc' },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = {
          enable = true,
          -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
          --  If you are experiencing weird indenting issues, add the language to
          --  the list of additional_vim_regex_highlighting and disabled languages for indent.
          additional_vim_regex_highlighting = { 'ruby' },
        },
        indent = { enable = true, disable = { 'ruby' } },
      },
      config = function(_, opts)
        -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup(opts)

        -- There are additional nvim-treesitter modules that you can use to interact
        -- with nvim-treesitter. You should go explore a few and see what interests you:
        --
        --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
        --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
        --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      end,
    },

    -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
    -- init.lua. If you want these files, they are in the repository, so you can just download them and
    -- place them in the correct locations.

    -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
    --
    --  Here are some example plugins that I've included in the Kickstart repository.
    --  Uncomment any of the lines below to enable them (you will need to restart nvim).
    --
    -- require 'kickstart.plugins.debug',
    -- require 'kickstart.plugins.indent_line',
    -- require 'kickstart.plugins.lint',

    -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
    --    This is the easiest way to modularize your config.
    --
    --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
    --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
    -- { import = 'custom.plugins' },
  },
}, {
  ui = {
    border = 'rounded',
    size = {
      width = 0.8,
      height = 0.8,
    },

    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- listen lsp-progress event and refresh lualine
vim.api.nvim_create_augroup('lualine_augroup', { clear = true })
vim.api.nvim_create_autocmd('User', {
  group = 'lualine_augroup',
  pattern = 'LspProgressStatusUpdated',
  callback = require('lualine').refresh,
})

-- Theline beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et