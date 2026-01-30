local constants = require("constants")

-- function creates a new tile with coordinates, graphics, physics, and initialize behavior
local function newTile(name, tileImage, gridX, gridY, world, initialize)
    local graphics = love.graphics.newImage(tileImage)

    local tileW = graphics:getWidth()
    local tileH = graphics:getHeight()

    local body = love.physics.newBody(world, tileW*gridX - tileW, tileW*gridY- tileW, "static")
    local shape = love.physics.newRectangleShape(tileW/2, tileH/2, tileW, tileH)
    local fixture = love.physics.newFixture(body, shape)

    fixture:setUserData(name)
    initialize(body, shape, fixture)

    return {
        ["graphics"] = graphics,
        ["width"] = tileW,
        ["height"] = tileH,
        ["gridX"] = gridX,
        ["gridY"] = gridY,
        ["x"] = tileW*gridX - tileW,
        ["y"] = tileW*gridY- tileW,
        ["physics"] = {
            ["body"] = body,
            ["shape"] = shape,
            ["fixture"] = fixture,
        },
    }
end

-- returns the coordinates of the specific point defined on grid
local function tilePos(gridX, gridY)
    return {gridX*constants.UNIT, gridY*constants.UNIT}
end

-- tile map class
local tileMap = {
    grid = {},
    tiles = {}
}

-- create new tile map
function tileMap:new()
    return tileMap
end

-- create a new empty grid for tile map
function tileMap:newGrid(rows, columns)
    local grid = {}
    
    for row = 1, rows do
        grid[row] = {}

        for column = 1, columns do
            grid[row][column] = ""
        end
    end
    
    self.grid = grid
end

-- add list of tiles to the current grid
function tileMap:addTiles(tiles)
    local newGrid = self.grid
    
    for index, value in ipairs(tiles) do
        local gridX = tiles[index].gridX
        local gridY = tiles[index].gridY

        newGrid[gridX][gridY] = tiles[index]
    end

    self.grid = newGrid
end

-- display the tile map onto the window
function tileMap:draw()
    for rows, row in ipairs(self.grid) do
        for column=1, #row do
            if type(row[column]) == "table" then
                love.graphics.draw(row[column].graphics, row[column].x, row[column].y)
            end
        end
    end
end

return {
    newTile = newTile,
    tilePos = tilePos,
    tileMap = tileMap,
}