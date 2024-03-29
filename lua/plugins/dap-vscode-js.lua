return {
  "mxsdev/nvim-dap-vscode-js",
  opt = true,
  run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
  config = function(_, opts)
    require("dap-vscode-js").setup({
      -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
      debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
      -- debugger_cmd = { "extension" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
      adapters = {
        "chrome",
        "pwa-node",
        "pwa-chrome",
        "pwa-msedge",
        "node-terminal",
        "pwa-extensionHost",
        "node",
        "chrome",
      }, -- which adapters to register in nvim-dap
      -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
      -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
      -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
    })

    local dap = require("dap")
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "js-debug-adapter",
        args = { "${port}" },
      },
    }
    for _, language in ipairs({ "typescript", "javascript", "typescriptreact" }) do
      dap.configurations[language] = {
        {
          type = "pwa-chrome",
          request = "launch",
          name = 'start chrome with "localhost"',
          url = "http://localhost:3000",
          webroot = "${workspaceFolder}",
          userdatadir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "attach",
          processid = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "debug jest tests",
          runtimeexecutable = "node",
          runtimeargs = {
            "./node_modules/jest/bin/jest.js",
            "--runinband",
          },
          rootpath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          console = "integratedterminal",
          internalconsoleoptions = "neveropen",
        },
      }
    end
  end,
}
-- return {
--   {
--     "mfussenegger/nvim-dap",
--     config = function(_, opts)
--       local dap = require("dap")
--       dap.adapters["pwa-node"] = {
--         type = "server",
--         host = "localhost",
--         port = "${port}",
--         executable = {
--           command = "js-debug-adapter",
--           args = { "${port}" },
--         },
--       }
--       for _, language in ipairs({ "typescript", "javascript" }) do
--         dap.configurations[language] = {
--           {
--             type = "pwa-chrome",
--             request = "launch",
--             name = 'start chrome with "localhost"',
--             url = "http://localhost:3000",
--             webroot = "${workspacefolder}",
--             userdatadir = "${workspacefolder}/.vscode/vscode-chrome-debug-userdatadir",
--           },
--           {
--             type = "pwa-node",
--             request = "launch",
--             name = "launch file",
--             program = "${file}",
--             cwd = "${workspacefolder}",
--           },
--           {
--             type = "pwa-node",
--             request = "attach",
--             name = "attach",
--             processid = require("dap.utils").pick_process,
--             cwd = "${workspacefolder}",
--           },
--           {
--             type = "pwa-node",
--             request = "launch",
--             name = "debug jest tests",
--             runtimeexecutable = "node",
--             runtimeargs = {
--               "./node_modules/jest/bin/jest.js",
--               "--runinband",
--             },
--             rootpath = "${workspacefolder}",
--             cwd = "${workspacefolder}",
--             console = "integratedterminal",
--             internalconsoleoptions = "neveropen",
--           },
--         }
--       end
--     end,
--   },
-- }
