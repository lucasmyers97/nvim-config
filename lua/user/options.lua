-- :help options
vim.opt.backup = false                          -- creates a backup file
vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
vim.opt.cmdheight = 2                           -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 2                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2                         -- always show tabs
vim.opt.smartcase = true                        -- smart case
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window 
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 300                        -- faster completion (4000ms default)
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.shiftwidth = 4                          -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4                             -- insert 4 spaces for a tab
vim.opt.cursorline = true                       -- highlight the current line
vim.opt.number = true                           -- set numbered lines
vim.opt.relativenumber = false                  -- set relative numbered lines to false
vim.opt.numberwidth = 4                         -- set number column width to 4 {default 4}
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = true                             -- display lines as one long line
vim.opt.scrolloff = 8                           -- minimal number of lines to keep above and below cursor while scrolling
vim.opt.sidescrolloff = 8                       -- same as above, but horizontal scrolling
vim.opt.guifont = "FiraCode NF:h14"             -- the font used in graphical neovim applications

-- fold text
vim.opt.foldtext = ''                           -- expression to specify text displayed for a closed fold (empty here)
vim.opt.fillchars = 'fold: '                    -- again, show blank character for a closed fold

vim.opt.shortmess:append "c"                    -- don't give insert-completion-menu messages

vim.opt.colorcolumn = "80"                      -- add column highlight at column 80 (for formatting code)

vim.opt.cindent = true                          -- enables automatic C program indenting
vim.opt.cinoptions = { ':0',                    -- place case labels N characters from the indent of the switch()
                       'l0',                    -- indent break after case
                       'g0',                    -- place C++ scope declarations N characters from the indent of the block they are in.
                       't0',                    -- Indent a function return type declaration N characters from the margin.
                       '(0',                    -- When in unclosed parentheses, indent N characters from the line with the unclosed parenthesis.
                       'W4', }                  -- when last line is open parenthesis, indent 4 spaces on next line.
vim.opt.whichwrap:append("<,>,[,],h,l")         -- allow characters that move left/right to move to the next line
vim.opt.iskeyword:append { '-' }

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd "set formatoptions-=cro" -- TODO: this doesn't seem to work
