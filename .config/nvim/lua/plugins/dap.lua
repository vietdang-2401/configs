return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- 1. Cấu hình giao diện nvim-dap-ui
      dapui.setup()

      -- Tự động bật/tắt UI khi bắt đầu hoặc kết thúc debug
      -- dap.listeners.after.event_initialized["dapui_config"] = function()
      --   dapui.open()
      -- end
      -- dap.listeners.before.event_terminated["dapui_config"] = function()
      --   dapui.close()
      -- end
      -- dap.listeners.before.event_exited["dapui_config"] = function()
      --   dapui.close()
      -- end

      -- 2. Định nghĩa Adapter cho Java (Kéo file jar từ Mason)
      dap.adapters.java = function(callback)
        -- Tự động tìm file jar của java-debug-adapter trong thư mục Mason
        -- local mason_path = vim.fn.glob(
        --   vim.fn.stdpath("data")
        --     .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
        --   true
        -- )
        --
        -- if mason_path == "" then
        --   mason_path = vim.fn.glob(
        --     "~/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
        --     true
        --   )
        -- end
        --
        -- callback({
        --   type = "executable",
        --   command = "java",
        --   args = {
        --     "-jar",
        --     mason_path,
        --   },
        -- })
      end

      -- 3. Cấu hình kiểu Debug: Chỉ Attach từ xa vào ứng dụng đang chạy bên ngoài
      dap.configurations.java = {
        {
          type = "java",
          request = "attach",
          name = "Attach to Java (Port 5005)",
          hostName = "127.0.0.1",
          port = 5005, -- Cổng này phải trùng với cổng trong lệnh `mvn` hoặc `java -agentlib` của bạn
        },
      }
    end,
  },
}
