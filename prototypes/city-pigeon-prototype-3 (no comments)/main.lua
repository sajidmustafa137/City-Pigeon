local constants = require("constants")
local gameState = require("gameState")

-- load window, player, and level one
function love.load()
  love.window.setMode(constants.WINDOW_LENGTH, constants.WINDOW_HEIGHT)
  love.window.setTitle("Pigeon Life")
  
  gameState.initialize()
end

-- update world and player physics (level physics remain the same)
function love.update(dt)
  gameState.update(dt)
end

-- draw level one and player
function love.draw()
  love.graphics.reset()
  gameState.draw()
end