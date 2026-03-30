-- Other common options to uncomment:
-- local colorscheme = "desert"
-- local colorscheme = "solarized"
local colorscheme = 'duskfox'

-- pcall just makes it so Neovim doesn't freak out if the colorscheme isn't 
-- available
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
-- vim.cmd("set background=light")
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
