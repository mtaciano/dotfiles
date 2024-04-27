local dap = require("dap")
local dapui = require("dapui")

dapui.setup({
    controls = {
        icons = {
            disconnect = "✕",
            pause = "||",
            play = "|>",
            run_last = "↻",
            step_back = "↶",
            step_into = "↓",
            step_out = "↑",
            step_over = "↷",
            terminate = "□",
        },
    },
    icons = {
        collapsed = "▶",
        current_frame = "▶",
        expanded = "▼",
    },
})

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end
