local Remap = require("bad.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

inoremap ("jj", "<Esc>")
-- Clear Highlights
nnoremap ("<Leader><space>", ":noh<cr>")
-- No recommended but needed to stop me fatfingering
-- Pause does not work in Terminal at this time.
nnoremap ("<c-z>", ":u<CR>") 
-- Window Navigation with Ctrl-[hjkl]
nnoremap ("<C-J>", "<C-W>j")
nnoremap ("<C-K>", "<C-W>k")
nnoremap ("<C-H>", "<C-W>h")
nnoremap ("<C-L>", "<C-W>l")
-- tabsman
nmap ("<leader>tn", ":tabnew<cr>")
nmap ("<leader>tl", ":tabnext<cr>")
nmap ("<leader>th", ":tabprevious<cr>")
nmap ("<leader>tm", ":tabmove")
nmap ("<leader>tc", ":tabclose<cr>")
nmap ("<leader>to", ":tabonly<cr>")
-- split
nnoremap ("<leader>sv", ":vsplit<CR>")
nnoremap ("<leader>sh", ":split<CR>")
-- Move text
nnoremap ("<A-j>", ":m .+1<CR>==")
nnoremap ("<A-k>", ":m .-2<CR>==")
inoremap ("<A-j>", "<Esc>:m .+1<CR>==gi")
inoremap ("<A-k>", "<Esc>:m .-2<CR>==gi")
vnoremap ("<A-j>", ":m '>+1<CR>gv=gv")
vnoremap ("<A-k>", ":m '<-2<CR>gv=gv")
-- Explorer
nnoremap ("<leader>h", ":Ex<CR>")
-- delete without yanking
nnoremap ("<leader>d", "\"_d")
vnoremap ("<leader>d", "\"_d")
-- paste no yank
vnoremap ("<leader>p", "\"_dP")
