# GetAss

A small library to parse Love2D game directories for game assets and create a table-tree based on the directory structure.

## Usage:
Assuming a directory structure like so:
assets
└── sprites
    ├── sprite1.png
    └── creatures
        └── human
            ├── sprite2.png
            └── sprite3.png 

Simply invoke GetAss using the following prototype: GetAss(dir, pattern, func) where:
    "dir" is the path from the root game directory to the assets directory you want to parse,
    "pattern" is a string.match pattern that tells GetAss which files to add to the table tree, and what to cut out of the filename when adding it to the tree,
    "func" is the function that GetAss will call for each matched file like so: func(filepath), the return value of which will be added to the tree.

```lua
GetAss = require 'getass'

assets = GetAss("assets", ".png$", function(filepath) return love.graphics.newImage(filepath) end)

-- You can now access the file structure as a table-tree like so:
love.graphics.draw(assets.sprites.sprite1)
love.graphics.draw(assets.sprites.creatures.human.sprite2)
love.graphics.draw(assets.sprites.creatures.human.sprite3)```

*NOTE:* In the interest of keeping the library small and light, it does not have automatic renaming of problematic characters in filenames(spaces, commas, etc...) so you should your assets appropriately. It will, however remove the pattern that you match for and any characters after the first dot it finds(so that it will still work if the pattern is not the file extension).
