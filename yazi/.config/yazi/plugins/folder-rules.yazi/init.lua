local function setup()
	ps.sub("cd", function()
		local cwd = cx.active.parent.cwd
		if cwd:ends_with("konkour") then
			ya.manager_emit("sort", { "natural", reverse = false, dir_first = true })
		else
			ya.manager_emit("sort", { "mtime", reverse = true, dir_first = true })
		end
	end)
end

return { setup = setup }
