-- Set leader key to space
vim.g.mapleader = " "
vim.g.mapleaderlocal = " "

local keymap = vim.keymap.set

keymap("i", "jk", "<ESC>", { desc = "Press `jk` to exit insert mode" })
keymap("i", "<C-c>", "<ESC>", { desc = "Make `CTRL+c` and `ESC behave identically" })

-- move lines up/down with K/J
keymap("v", "K", ":m '<-2<CR>gv=gv")
keymap("v", "J", ":m '>+1<CR>gv=gv")

-- keep cursor position when joining lines
keymap("n", "J", "mzJ`z")

-- keep buffer centered while jumping around
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- clear search highlights
keymap("n", "<leader>hc", "<CMD>nohl<CR>", { desc = "[C]lear search [H]ighlights" })

-- open tmux-sessionizer
keymap("n", "<C-f>", "<CMD>silent !tmux neww tmux-sessionizer<CR>")

-- Increment/Decrement numbers
keymap({ "n", "v" }, "<leader>+", "<C-a>", { desc = "Increment number" })
keymap({ "n", "v" }, "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Window/Splits management
keymap("n", "<leader>sv", "<C-w>v", { desc = "[S]plit window [V]ertically" })
keymap("n", "<leader>sh", "<C-w>s", { desc = "[S]plit window [H]orizontally" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Make [S]plits [E]qual size" })
keymap("n", "<leader>sx", "<cmd>close<CR>", { desc = "E[x]it current [S]plit" })

keymap("n", "<leader>x", "<CMD>!chmod +x %<CR>", { silent = true, desc = "Make the current file e[X]ecutable" })

keymap("n", "<leader><leader>", "<CMD>so<CR>", { desc = "Reload nvim config" })

-- Register manipulation

keymap("x", "<leader>p", '"_dP', { desc = "[P]aste without loosing paste buffer" })
keymap({ "n", "v" }, "<leader>d", '"_d', { desc = "[D]elete without writing into buffer" })
keymap({ "n", "v" }, "<leader>y", '"+y', { desc = "[Y]ank selection into system clipboard" })
keymap("n", "<leader>Y", '"+Y', { desc = "[Y]ank until end of line into system clipboard" })

keymap(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "[S]ubstitute word under cursor" }
)
