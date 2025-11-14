return {
  "rcarriga/nvim-dap-ui",
  dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  config = function()
    local dap = require("dap")
    --require("dap").set_log_level("TRACE")
    --local dapui = require("dapui")
    --dapui.setup()
    dap.adapters.coreclr = {
      type = "executable",
      command = "/home/jsoler/.local/share/nvim/mason/bin/netcoredbg",
      args = { "--interpreter=vscode" },
    }
    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end,
        cwd = "${workspaceForder}",
        stopAtEntry = false,
        console = "integratedTerminal",
      },
    }
  end,
}
