# GetAss

A small library to parse Love2D game directories for game assets and create a table-tree based on the directory structure.

## Usage:
```lua
-- Assuming a directory structure like so:
-- assets
-- └── sprites
--     ├── sprite1.png
--     └── creatures
--         └── human
--             ├── sprite2.png
--             └── sprite3.png 

-- Simply invoke GetAss using the following prototype: GetAss(dir, pattern, func) where:
--     "dir" is the path from the root game directory to the assets directory you want to parse,
--     "pattern" is a string.match pattern that tells GetAss which files to add to the table tree, and what to cut out of the filename when adding it to the tree,
--     "func" is the function that GetAss will call for each matched file like so: func(filepath), the return value of which will be added to the tree
--     "maketree" is a boolean that specifies whether to put the assets into a table-tree or into a simple array-like table. This defaults to true if a func is set and false if a func is not set.

GetAss = require 'getass'

assets = GetAss("assets", ".png$", function(filepath) return love.graphics.newImage(filepath) end)

-- You can now access the file structure as a table-tree like so:
love.graphics.draw(assets.sprites.sprite1)
love.graphics.draw(assets.sprites.creatures.human.sprite2)
love.graphics.draw(assets.sprites.creatures.human.sprite3)

-- This will put the filepaths into a simple array-like table, because you did not specify a function.
filepaths = GetAss("assets", ".png$")

-- If you want non-nested assets but you still want a custom function, simple set maketree to false.
non_nested_assets = GetAss("assets", ".png$", function(filepath) return love.graphics.newImage(filepath) end, false)

-- Likewise, if you want the filepaths in a nested table, then you will need to add a basic function.
nested_filepaths = GetAss("assets", ".png$", function(filepath) return filepath end)

-- This library can be used for almost any type of assets including code like so:
objs = GetAss("src", ".lua$", function(filepath) return love.filesystem.load(filepath)() end, false)
```

> **NOTE:** In the interest of keeping the library small and light, it does not have automatic renaming of problematic characters in filenames(spaces, commas, etc...) so you should name your assets appropriately. It will, however remove the pattern that you match for and any characters after the first dot it finds(so that it will still work if the pattern is not the file extension).

## License
This library is licensed under MIT License meaning you are welcome to use it in any project you want and modify it to your heart's content. You need only mention me in the about page/readme/documentation of your project.
