-- Copyright (c) 2018 Ryan David Sheasby
-- 
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local function getass(dir, pattern, func, maketree)
	if pattern == nil then pattern = "^" end
    if func == nil then
        func = function(filepath) return filepath end
        maketree = false
    end
	if maketree == nil then maketree = true end
    local result = {}
    local filenames = love.filesystem.getDirectoryItems(dir)
    for index, filename in ipairs(filenames) do
        local filepath = dir.."/"..filename
        local filetype = love.filesystem.getInfo(filepath).type
        if filetype == "file" then
            if string.find(filepath, pattern) ~= nil then
                local s1, s2 = string.find(filename, pattern)
                local objectname = string.sub(filename, 1, s1 - 1)..string.sub(filename, s2 + 1)
                local s1 = string.find(objectname, "%..*$")
                if s1 ~= nil then
                    objectname = string.sub(objectname, 1, s1 - 1)
                end
                if maketree then
                    result[objectname] = func(filepath)
                else
                    table.insert(result, func(filepath))
                end
            end
        elseif filetype == "directory" then
            local deepresult = getass(filepath, pattern, func, maketree)
			if maketree then
				result[filename] = deepresult
			else
				for k, v in pairs(deepresult) do table.insert(result, v) end
			end
        end
    end
    local length = 0
    for _ in pairs(result) do length = length + 1 end
    if length == 0 then result = nil end
    return result
end

return getass
