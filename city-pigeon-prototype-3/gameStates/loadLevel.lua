local levels = require("levels/getLevels")
local currentLevel = require("levels/currentLevel")
local player = require("player")
local worldCallbacks = require("worldCallbacks")

local function initialize()
    love.graphics.clear()

    levels[currentLevel]:initialize()
    levels[currentLevel].world:setCallbacks(worldCallbacks.beginContact, worldCallbacks.endContact)

    player:initialize(levels[currentLevel].world)
    player.spawnX = levels[currentLevel].spawn[1]
    player.spawnY = levels[currentLevel].spawn[2]
    player:spawn()
end

local function update(dt)
    levels[currentLevel].world:update(dt)
    player:update()
    
    if player.collisionBehavior.levelFinish then
        player.collisionBehavior.levelFinish = false
        currentLevel = currentLevel + 1
        initialize()
    end
end

local function draw()
    levels[currentLevel]:draw()
    player:draw()
end

return {
    initialize = initialize,
    update = update,
    draw = draw,
}