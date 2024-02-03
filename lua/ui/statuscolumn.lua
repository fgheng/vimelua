-- vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart = 99
-- vim.opt.foldcolumn = "1"
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldtext = ""
-- vim.opt.fillchars = "foldopen:,foldclose:"
--
-- local fcs = vim.opt.fillchars:get()
--
-- -- Stolen from Akinsho
-- local function get_fold(lnum)
--     if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then
--         return " "
--     end
--     local fold_sym = vim.fn.foldclosed(lnum) == -1 and fcs.foldopen or fcs.foldclose
--     return fold_sym
-- end
--
-- _G.get_statuscol = function()
--     local cbuf = vim.api.nvim_get_current_buf()
--     local filetype = vim.api.nvim_buf_get_option(cbuf, "filetype")
--
--     if filetype == "neo-tree" or filetype == "aerial" or filetype == "toggleterm" then
--         return ""
--     else
--         -- return "%@SignCb@%s%=%T%@NumCb@%l│" .. get_fold(vim.v.lnum) .. "%T"
--         return "%s%=%l│" .. get_fold(vim.v.lnum) .. " "
--     end
-- end
--
-- -- vim.o.statuscolumn = "%!v:lua.get_statuscol()"
--
-- vim.api.nvim_create_autocmd("BufEnter", {
--     callback = function(args)
--         local winid = vim.api.nvim_get_current_win()
--         vim.wo[winid].statuscolumn = "%!v:lua.get_statuscol()"
--     end,
-- })

local gitsigns_bar = '▌'

local gitsigns_hl_pool = {
	GitSignsAdd          = "DiagnosticOk",
	GitSignsChange       = "DiagnosticWarn",
	GitSignsChangedelete = "DiagnosticWarn",
	GitSignsDelete       = "DiagnosticError",
	GitSignsTopdelete    = "DiagnosticError",
	GitSignsUntracked    = "NonText",
}

local diag_signs_icons = {
	DiagnosticSignError = " ",
	DiagnosticSignWarn = " ",
	DiagnosticSignInfo = " ",
	DiagnosticSignHint = "",
	DiagnosticSignOk = " "
}


local function get_sign_name(cur_sign)
	if (cur_sign == nil) then
		return nil
	end

	cur_sign = cur_sign[1]

	if (cur_sign == nil) then
		return nil
	end

	cur_sign = cur_sign.signs

	if (cur_sign == nil) then
		return nil
	end

	cur_sign = cur_sign[1]

	if (cur_sign == nil) then
		return nil
	end

	return cur_sign["name"]
end

local function mk_hl(group, sym)
	return table.concat({ "%#", group, "#", sym, "%*" })
end

local function get_name_from_group(bufnum, lnum, group)
	local cur_sign_tbl = vim.fn.sign_getplaced(bufnum, {
		group = group,
		lnum = lnum
	})

	return get_sign_name(cur_sign_tbl)
end

_G.get_statuscol_gitsign = function(bufnr, lnum)
	local cur_sign_nm = get_name_from_group(bufnr, lnum, "gitsigns_vimfn_signs_")

	if cur_sign_nm ~= nil then
		return mk_hl(gitsigns_hl_pool[cur_sign_nm], gitsigns_bar)
	else
		return " "
	end
end

_G.get_statuscol_diag = function(bufnum, lnum)
	local cur_sign_nm = get_name_from_group(bufnum, lnum, "*")

	if cur_sign_nm ~= nil and vim.startswith(cur_sign_nm, "DiagnosticSign") then
		return mk_hl(cur_sign_nm, diag_signs_icons[cur_sign_nm])
	else
		return " "
	end
end

_G.get_statuscol = function()
	local str_table = {}

	local parts = {
		["diagnostics"] = "%{%v:lua.get_statuscol_diag(bufnr(), v:lnum)%}",
		["fold"] = "%C",
		["gitsigns"] = "%{%v:lua.get_statuscol_gitsign(bufnr(), v:lnum)%}",
		["num"] = "%{v:relnum?v:relnum:v:lnum}",
		["sep"] = "%=",
		["signcol"] = "%s",
		["space"] = " "
	}

	local order = {
		"diagnostics",
		"sep",
		"num",
		"space",
		"gitsigns",
		"fold",
		"space",
	}

	for _, val in ipairs(order) do
		table.insert(str_table, parts[val])
	end

	return table.concat(str_table)
end 
