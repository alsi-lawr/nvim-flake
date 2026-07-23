local function set_csharp_regex_highlights()
	local links = {
		regexComment = "@comment",
		regexCharacterClass = "@string.regexp",
		regexAnchor = "@operator",
		regexQuantifier = "@operator",
		regexGrouping = "@punctuation.bracket",
		regexAlternation = "@operator",
		regexText = "@string.regexp",
		regexSelfEscapedCharacter = "@string.escape",
		regexOtherEscape = "@string.escape",
	}

	for token_type, target in pairs(links) do
		vim.api.nvim_set_hl(0, "@lsp.type." .. token_type .. ".cs", { link = target })
	end
end

set_csharp_regex_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = set_csharp_regex_highlights,
})
