local leet_arg = "lc"

return {
	"kawre/leetcode.nvim",
	lazy = leet_arg ~= vim.fn.argv(0, -1),
	opts = {
		arg = leet_arg,
		-- @type lc.lang
		lang = "python3",

		picker = { provider = nil },
	},
}
