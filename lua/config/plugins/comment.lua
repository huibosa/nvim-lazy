return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
    require("Comment").setup({
      toggler = {
        line = '<C-_>',
      },
      opleader = {
        line = '<C-_>',
    },
    })
  end
}
