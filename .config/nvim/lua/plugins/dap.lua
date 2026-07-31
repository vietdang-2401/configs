return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- dapui.setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_initialized.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      local php_debug_adapter = vim.fn.stdpath("data") .. "/mason/packages/php-debug-adapter/extension/out/phpDebug.js"

      if vim.fn.filereadable(php_debug_adapter) == 0 then
        vim.notify("php-debug-adapter is not installed. Run :MasonInstall php-debug-adapter", vim.log.levels.ERROR)
        return
      end

      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { php_debug_adapter },
      }

      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Listen for DDEV Xdebug",
          port = 9003,
          pathMappings = {
            ["/var/www/html"] = vim.fn.getcwd(),
          },
        },
      }
    end,
  },
}
