local tileSystem = require("levels/tileSystem")
local constants = require("constants")

local initializeCity = require("levels/initializeTiles/city")
local initializeWind = require("levels/initializeTiles/wind")
local initializeFinish = require("levels/initializeTiles/finish")

local levelTwo = tileSystem.tileMap:new()
print(levelTwo.grid)
levelTwo:newGrid(10, 10)

-- function used to initialize the world for level one
function levelTwo:initialize()
    self.name = "2"
    
    self.world = love.physics.newWorld(0, constants.GRAVITY, true)
    
    self.tiles = {
        -- first row of platforms
        tileSystem.newTile("city", constants.CITY, 1, 10, self.world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 2, 10, self.world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 3, 10, self.world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 8, 10, self.world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 9, 10, self.world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 10, 10, self.world, initializeCity),

        -- second row of platforms
        tileSystem.newTile("city", constants.CITY, 1, 7, self.world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 2, 7, self.world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 3, 7, self.world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 8, 7, self.world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 9, 7, self.world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 10, 7, self.world, initializeCity),

        -- ceiling
        tileSystem.newTile("city", constants.CITY, 1, 1, self.world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 2, 1, self.world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 3, 1, self.world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 4, 1, self.world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 5, 1, self.world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 6, 1, self.world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 7, 1, self.world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 8, 1, self.world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 9, 1, self.world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 10, 1, self.world, initializeCity),

        -- wind elements
        tileSystem.newTile("wind", constants.WIND, 5, 10, self.world, initializeWind),
        tileSystem.newTile("wind", constants.WIND, 5, 9, self.world, initializeWind),
        tileSystem.newTile("wind", constants.WIND, 6, 10, self.world, initializeWind),
        tileSystem.newTile("wind", constants.WIND, 6, 9, self.world, initializeWind),

        -- finish tile
        tileSystem.newTile("finish", constants.FINISH, 10, 9, self.world, initializeFinish),
    }

    self.tileMap = self:addTiles(self.tiles)
    self.backGround = love.graphics.newImage(constants.BACKGROUND)
    self.spawn = tileSystem.tilePos(2,8)
end

return levelTwo