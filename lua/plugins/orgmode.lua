return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    -- Setup orgmode
    require('orgmode').setup({
      org_agenda_files = '~/Dropbox/Apps/Orgzly Revived/**/*',
      org_default_notes_file = '~/Dropbox/Apps/Orgzly/refile.org',
    })

    -- Experimental LSP support
    vim.lsp.enable('org')
  end,
  tag = '0.7.2'
}
