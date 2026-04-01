-- TODO: look at all the diagnostic config options

local severity = vim.diagnostic.severity

local config = {
  -- disable virtual text
  virtual_text = false,
  -- show signs
  signs = {
    text = {
      [severity.ERROR] = "",
      [severity.WARN] = "",
      [severity.HINT] = "",
      [severity.INFO] = "",
    }
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(config)

-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
--   border = "rounded",
-- })
-- 
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
--   border = "rounded",
-- })

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>b", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gl",
    '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>',
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

local texlab_parse_dbus_monitor_output = function(_, data)
    --[[
    The actual output from dbus-monitor looks something like:
    ```
    signal time=1691002304.407054 sender=:1.6295 -> destination=(null destination) serial=784 path=/org/gnome/evince/Window/0; interface=org.gnome.evince.Window; member=SyncSource
       string "file:///home/lucas/Documents/research/anisotropic-nematic-structure/anisotropic_nematic_structure.tex"
       struct {
          int32 43
          int32 -1
       }
       uint32 620774289
    ```
    so we just grab the 2nd and 4th lines to process
    --]]

    local data_str = ''
    for _, s in ipairs(data) do
        data_str = data_str .. s .. '\n'
    end

    local filename_pattern = 'string "file://(.*%.tex)"'
    local _, _, filename = string.find(data_str, filename_pattern)

    if filename ~= vim.api.nvim_buf_get_name(0) then
        return
    end

    local line_number_pattern = 'int32 (%d+)'
    local line_number
    _, _, line_number = string.find(data_str, line_number_pattern)

    if not line_number then
        return
    end

    local code_row = tonumber(line_number)
    vim.api.nvim_win_set_cursor(0, {code_row, 0})
end

local on_stderr = function(_, data)
    for _, s in pairs(data) do
        print(s)
    end
end

local function buf_inverse()
    vim.fn.jobstart({'dbus-monitor',
                     'type=signal,interface=org.gnome.evince.Window,member=SyncSource'},
                     { on_stdout = texlab_parse_dbus_monitor_output,
                       on_stderr = on_stderr })
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    local bufnr = ev.buf

    if client.name == "tsserver" then
      client.server_capabilities.document_formatting = false
    end
    -- if client.name == 'texlab' then
    --   buf_inverse()
    -- end
    lsp_keymaps(bufnr)
    lsp_highlight_document(client)
  end,
})
