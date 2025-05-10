local function setup()
	ps.sub("cd", function()
		local cwd = cx.active.parent.cwd
		local folder_names = { "konkour" } -- Add all the folder names you want to match here

		-- Function to check if any of the parent directories match the folder names
		local function check_parent_folders(path)
			while path do
				for _, folder in ipairs(folder_names) do
					if path:ends_with(folder) then
						return true
					end
				end
				-- Move to the parent directory
				path = path:parent()
			end
			return false
		end

		-- Check if the current directory or any of its parents match
		if check_parent_folders(cwd) then
			ya.manager_emit("sort", { "natural", reverse = false, dir_first = true })
		else
			ya.manager_emit("sort", { "mtime", reverse = true, dir_first = true })
		end
	end)
end

return { setup = setup }
