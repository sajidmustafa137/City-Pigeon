local constants = require("constants")
local tileSystem = require("tileSystem")

local player = {
  x = tileSystem.tilePos(1, 8)[1],
  y = tileSystem.tilePos(1, 8)[2],

  vx = 0,
  vy = 0,

  dx = 0,
  dy = 0,

  width = 16,
  height = 16,

  grounded = false,
  flying = false,
  glide = false,

  windVector = {0, 0},

  collisionBehavior = {
    beginContactWind = false,
    endContactWind = false,

    beginContactGrounded = false,
    endContactGrounded = false,
  },
}

function player:initialize(world)
    self.body = love.physics.newBody(world, 0, 0, "dynamic")
    self.shape = love.physics.newRectangleShape(self.width/2, self.height/2, self.width, self.height)
    self.fixture = love.physics.newFixture(self.body, self.shape, 1)

    self.groundedSensorShape = love.physics.newRectangleShape(self.width/2, self.height, self.width/1.25, self.height/4)
    self.groundedSensorFixture = love.physics.newFixture(self.body, self.groundedSensorShape, 1)

    self.body:setFixedRotation(true)
    self.body:setLinearDamping(1)
    self.body:setX(self.x)
    self.body:setY(self.y)

    self.fixture:setUserData("player")

    self.groundedSensorFixture:setSensor(true)
    self.groundedSensorFixture:setUserData("playerGrounded")
end

function player:update()
    self.x, self.y = self.body:getPosition()
    self.vx, self.vy = self.body:getLinearVelocity()

    player:updateGrounded()
    player:updateWind()
    player:updateFly()
    player:movement()

    self.body:applyLinearImpulse(self.dx, self.dy)
    self.dx, self.dy = 0, 0
end

function player:movement()
    local fly = love.keyboard.isDown("space")
    local jump = love.keyboard.isDown({"w", "up"})
    local right = love.keyboard.isDown({"d", "right"})
    local left = love.keyboard.isDown({"a", "left"})

    if jump and self.grounded then
        self.dy = -constants.JUMP
    end
    if right and self.vx <= constants.SPEED then
        self.dx = constants.ACCELERATION
    end
    if left and self.vx >= -constants.SPEED then
        self.dx = -constants.ACCELERATION
    end
    if fly and not player.flying then
        self.body:setLinearVelocity(self.vx, -math.abs(self.vy) - constants.JUMP*2)
        player.glide = true
        player.flying = true
    end
end

function player:updateGrounded()
    if self.collisionBehavior.beginContactGrounded then
        self.grounded = true
    elseif self.collisionBehavior.endContactGrounded and not (-10 <= self.vy and self.vy <= 10) then
        self.grounded = false
    end
end

function player:updateWind()
    if self.collisionBehavior.beginContactWind then
        self.windVector = {0, -32}
    elseif self.collisionBehavior.endContactWind then
        self.windVector = {0, 0}
    end
    self.dx = self.windVector[1]
    self.dy = self.windVector[2]
end

function player:updateFly()
    if self.grounded then
        self.flying = false
    end
    
    if self.flying then
        self.body:setGravityScale(0.25)
    else
        self.body:setGravityScale(1)
    end
end

function player:draw()
    love.graphics.setColor(0,0,1)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return player