local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
  ["r"] = { "<cmd>NvimTreeRefresh<cr>", "Refresh Explorer" },

  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  -- ["m"] = { ":MaximizerToggle<CR>", 'Maximizer' },
  ["c"] = {
    name = "Config",
    ["r"] = { ":luafile %<CR>", "Reload config" },
    ["c"] = { ":vsplit | e $HOME/.config/nvim/init.lua<CR>", "Edit config" },
  },
  ["q"] = { ":q<CR>", "Quit"},
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["f"] = {
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false, hidden = true})<cr>",
    "Find files",
  },
  ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
  ["P"] = { "<cmd>Telescope projects<cr>", "Projects" },

  b = {
    name = "Buffer",
    ["b"] = {
      "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      "Buffers"},
    ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
    ["h"] = { "<cmd>BufferLineCloseLeft<cr>", "Close buffer left"},
    ["l"] = { "<cmd>BufferLineCloseRight<cr>", "Close buffer right"},
    ["p"] = { "<cmd>BufferLinePick<cr>", "Pick buffer"},
    ["t"] = {
      name = "Toggle groups",
      ["d"] = { "<cmd>BufferLineGroupToggle Docs<cr>", "Docs"},
      ["c"] = { "<cmd>BufferLineGroupToggle Config<cr>", "Config"},
      ["t"] = { "<cmd>BufferLineGroupToggle Tests<cr>", "Tests"},
    },
    ["T"] = {
      name = "Tabs",
      ["n"] = { ":tab split<cr>", "New tab"},
      ["c"] = { ":tabclose<cr>", "Close tab"},
      ["l"] = { ":tabnext<cr>", "Next tab"},
      ["h"] = { ":tabprevious<cr>", "Previous tab"},
    }
  },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>DiffviewOpen<cr>",
      "Diff",
    },
  },

  T = {
    name = "+Trouble",
    d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
    j = {
      "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>Trouble loclist<cr>", "LocationList" },
    q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace diagnostics" },
  },

  v = {
    name = "Vimwiki",

    w = { ":VimwikiIndex<CR>", "Index" },
    i = { ":VimwikiDiaryIndex<CR>", "Diary index" },
    g = { ":VimwikiDiaryGenerateLinks<CR>", "Generate diary links" },
    n = { ":VimwikiMakeDiaryNote<CR>", "Diary note" },
    d = { ":VimwikiDeleteFile<CR>", "Delete file" },
    t = { ":VimwikiTable ", "Create table" },
    c = { ":VimwikiTOC<CR>", "Create TOC" },
  },

  w = {
    name = "+Windows",
    m = { ":FocusMaximise<CR>", "Maximise" },
    e = { ":FocusEqualise<CR>", "Equalise" },
    f = { ":FocusToggle<CR>", "Focus Toggle" },
    h = { ":FocusSplitLeft<CR>", "Split left" },
    j = { ":FocusSplitDown<CR>", "Split down" },
    k = { ":FocusSplitUp<CR>", "Split up" },
    l = { ":FocusSplitRight<CR>", "Split right" },
  },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    r = { "<cmd>Trouble lsp_references<cr>", "Find References" },
    d = { "<cmd>Trouble lsp_definitions<cr>", "Go to Definition" },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    -- s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help" },
    h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    i = { "<cmd>Telescope media_files<cr>", "Media files" },
    c = { "<cmd>Telescope command_history<cr>", "Command history" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    o = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    f = { "<cmd>lua require('telescope.builtin').find_files({hidden = true})<cr>", "Find file" },
    r = { ":SearchBoxReplace confirm=menu<CR>", "Replace" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    t = { "<cmd>Telescope live_grep<cr>", "Text" }
  },

  t = {
    name = "Terminal",
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    t = { "<cmd>lua _GOTOP_TOGGLE()<cr>", "Gotop" },
    s = { "<cmd>lua _SPT_TOGGLE()<cr>", "Spotify" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    m = { "<cmd>lua _CMATRIX_TOGGLE()<cr>", "Cmatrix" },
    c = { "<cmd>lua _CHTSH_TOGGLE()<cr>", "Cht.sh" },
    b = { "<cmd>lua _BC_TOGGLE()<cr>", "bc" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)
