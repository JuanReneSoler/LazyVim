return {
  "rcarriga/nvim-dap-ui",
  dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    --dap.set_log_level("TRACE")
    dapui.setup()

    --config
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
          --local dlls = vim.fn.systemlist("fd --full-path -e dll bin/Debug")
          local dlls = vim.fn.systemlist([[fd -I --full-path --regex 'bin/Debug/net[0-9]+\.[0-9]+/[^/]+\.dll$' \
  | awk -F'/' '{p=$(NF-4); d=$NF; sub(/\.dll$/,"",d); if (p==d) print}'
  ]])

          if vim.tbl_isempty(dlls) then
            vim.notify("No .dll found. Build the project first with: dotnet build", vim.log.levels.ERROR)
            return ""
          end

          --return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
          return coroutine.create(function(coro)
            vim.ui.select(dlls, {
              prompt = "Select .NET DLL to debug:",
              format_item = function(item)
                return item
              end,
            }, function(choice)
              coroutine.resume(coro, choice)
            end)
          end)
        end,
        cwd = "${workspaceForder}",
        stopAtEntry = false,
        console = "integratedTerminal",
      },
    }

    --keymaps
    vim.keymap.set("n", "<leader>dt", dapui.toggle, { desc = "Toggle Debugger" })
    vim.keymap.set("n", "<F5>", function()
      dapui.open()
      dap.continue()
    end)
    vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
    vim.keymap.set("n", "<F10>", dap.step_over)
    vim.keymap.set("n", "<F11>", dap.step_into)
    vim.keymap.set("n", "<F12>", dap.step_out)
  end,
}
