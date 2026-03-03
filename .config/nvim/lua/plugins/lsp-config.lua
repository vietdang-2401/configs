return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = { eslint = {} },
    setup = {
      eslint = function()
        Snacks.util.lsp.on(function(buf, client)
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == "vue_ls" then
            client.server_capabilities.documentFormattingProvider = false
          end
        end)
        -- require("lazyvim.util").lsp.on_attach(function(client)
        --   if client.name == "eslint" then
        --     client.server_capabilities.documentFormattingProvider = true
        --   elseif client.name == "vue_ls" then
        --     client.server_capabilities.documentFormattingProvider = false
        --   end
        -- end)
      end,
    },
  },
}
