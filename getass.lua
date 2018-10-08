-- Copyright (c) 2018 Ryan David Sheasby
-- 
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local function getass(dir, pattern, func)
    local result = {}
    local filenames = love.filesystem.getDirectoryItems(dir)
    for index, filename in ipairs(filenames) do
        local filepath = dir.."/"..filename
        filetype = love.filesystem.getInfo(filepath).type
        if filetype == "file" then
            if string.find(filepath, pattern) ~= nil then
                local s1, s2 = string.find(filename, pattern)
                local objectname = string.sub(filename, 1, s1 - 1)..string.sub(filename, s2 + 1)
                local s1 = string.find(objectname, "%..*$")
                if s1 ~= nil then
                    objectname = string.sub(objectname, 1, s1 - 1)
                end
                result[objectname] = func(filepath)
            end
        elseif filetype == "directory" then
            result[filename] = getass(filepath, pattern, func)
        end
    end
    return result
end

return getass