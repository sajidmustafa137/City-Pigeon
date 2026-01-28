local constants = require("constants")
local worldCollisions = require("worldCollisions")
local levels = require("levels")
local player = require("player")

local background = love.graphics.newImage(constants.BACKGROUND)

local world = love.physics.newWorld(0, GRAVITY, true)

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

-- functionality for when the level is completed
function levelEnd()
  love.event.quit(0)
end

function love.load()
  love.window.setMode(constants.WINDOW_LENGTH, constants.WINDOW_HEIGHT)
  love.window.setTitle("Pigeon Life")
  player:initialize(world)
  levels.levelOne:initialize(world)
end

function love.update(dt)
  world:update(dt)
  player:update()
end

function love.draw()
  love.graphics.reset()
  love.graphics.draw(background, 0, 0)

  levels.levelOne:draw()
  player:draw()
end