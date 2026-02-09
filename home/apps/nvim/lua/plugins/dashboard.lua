-- Detect nix-config directory location
local function get_nix_config_path()
  local mac_path = vim.env.HOME .. "/home/nix-config"
  local pc_path = vim.env.HOME .. "/nix-config"

  if vim.fn.isdirectory(mac_path) == 1 then
    return mac_path
  else
    return pc_path
  end
end

local nix_config_root = get_nix_config_path()

return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {

        header = [[
██████╗ ██╗   ██╗██╗      █████╗ ███╗   ██╗██╗██╗  ██╗
██╔══██╗╚██╗ ██╔╝██║     ██╔══██╗████╗  ██║██║╚██╗██╔╝
██║  ██║ ╚████╔╝ ██║     ███████║██╔██╗ ██║██║ ╚███╔╝ 
██║  ██║  ╚██╔╝  ██║     ██╔══██║██║╚██╗██║██║ ██╔██╗ 
██████╔╝   ██║   ███████╗██║  ██║██║ ╚████║██║██╔╝ ██╗
╚═════╝    ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝
]],
         -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "v", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = '" .. nix_config_root .. "/home/apps/nvim'})" },
          { icon = " ", key = "c", desc = "Nix", action = ":chdir " .. nix_config_root },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
  },
}
