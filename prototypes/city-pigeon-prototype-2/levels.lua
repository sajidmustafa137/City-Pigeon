local tileSystem = require("tileSystem")
local constants = require("constants")

local levelOne = tileSystem.tileMap:new()
levelOne:newGrid(10, 10)

-- function used to initialize the world for level one, so tiles are properly generated
function levelOne:initialize(world)
    self.world = world
    self.tiles = {
        tileSystem.newTile("city", constants.CITY, 1, 10, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 2, 10, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 3, 10, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 8, 10, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 9, 10, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 10, 10, world, initializeCity),

        tileSystem.newTile("city", constants.CITY, 1, 7, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 2, 7, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 3, 7, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 8, 7, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 9, 7, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 10, 7, world, initializeCity),

        tileSystem.newTile("city", constants.CITY, 1, 4, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 2, 4, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 3, 4, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 8, 4, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 9, 4, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 10, 4, world, initializeCity),

        tileSystem.newTile("city", constants.CITY, 1, 1, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 2, 1, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 3, 1, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 4, 1, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 5, 1, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 6, 1, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 7, 1, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 8, 1, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 9, 1, world, initializeCity),
        tileSystem.newTile("city", constants.CITY, 10, 1, world, initializeCity),

        tileSystem.newTile("wind", constants.WIND, 5, 10, world, initializeWind),
        tileSystem.newTile("wind", constants.WIND, 5, 9, world, initializeWind),
        tileSystem.newTile("wind", constants.WIND, 6, 10, world, initializeWind),
        tileSystem.newTile("wind", constants.WIND, 6, 9, world, initializeWind),

        tileSystem.newTile("finish", constants.FINISH, 10, 9, world, initializeFinish),
    }
    self.tileMap = self:addTiles(self.tiles)
end

return {
    levelOne = levelOne
}