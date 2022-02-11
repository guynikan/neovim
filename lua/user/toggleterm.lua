local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 10,
	open_mapping = [[<C-t>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "horizontal",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = 'float', id=1000 })

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

local node = Terminal:new({ cmd = "node", hidden = true, id=1001 })

function _NODE_TOGGLE()
	node:toggle()
end

local ncdu = Terminal:new({ cmd = "ncdu", direction = 'float', hidden = true, id=1002 })

function _NCDU_TOGGLE()
	ncdu:toggle()
end

local spt = Terminal:new({ cmd = "spt", direction = 'float',  hidden = true, id=1003 })

function _SPT_TOGGLE()
  spt:toggle()
end

local gotop = Terminal:new({ cmd = "gotop", direction = 'float',  hidden = true, id=1004 })


function _GOTOP_TOGGLE()
	gotop:toggle()
end

local python = Terminal:new({ cmd = "python", hidden = true, id=1005 })

function _PYTHON_TOGGLE()
	python:toggle()
end


local cmatrix = Terminal:new({ cmd = "cmatrix", direction = 'float',  hidden = true, id=1005 })

function _CMATRIX_TOGGLE()
	cmatrix:toggle()
end


local chtsh = Terminal:new({ cmd = "cht.sh --shell", direction = 'float',  hidden = true, id=1006 })

function _CHTSH_TOGGLE()
	chtsh:toggle()
end


local bc = Terminal:new({ cmd = "bc", direction = 'float',  hidden = true, id=1007 })

function _BC_TOGGLE()
	bc:toggle()
end
