local constants = require("constants")
local worldCollisions = require("worldCollisions")
local levels = require("levels")
local player = require("player")

local background = love.graphics.newImage(constants.BACKGROUND)

local world = love.physics.newWorld(0, GRAVITY, true)

-- global functions for initializing each tile in levels 
function initializeCity(body, shape, fixture)
  fixture:setFriction(1)
end

function initializeWind(body, shape, fixture)
  fixture:setFriction(1)
  fixture:setSensor(true)
end

function initializeFinish(body, shape, fixture)
  fixture:setSensor(true)
end

-- global function for behavior when level ends
function levelEnd()
  love.event.quit(0)
end

-- load window, player, and level one
function love.load()
  love.window.setMode(constants.WINDOW_LENGTH, constants.WINDOW_HEIGHT)
  love.window.setTitle("Pigeon Life")
  player:initialize(world)
  levels.levelOne:initialize(world)
end

-- update world and player physics (level physics remain the same)
function love.update(dt)
  world:update(dt)
  player:update()
end

-- draw level one and player
function love.draw()
  love.graphics.reset()
  love.graphics.draw(background, 0, 0)

  levels.levelOne:draw()
  player:draw()
end