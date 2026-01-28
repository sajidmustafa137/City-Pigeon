local player = require("player")

local function collisionBetween(fixtureOneName, fixtureTwoName, fixtureOne, fixtureTwo)
    local isFixtureOneColliding = (fixtureOneName == fixtureOne:getUserData()) or (fixtureOneName == fixtureTwo:getUserData())
    local isFixtureTwoColliding = (fixtureTwoName == fixtureOne:getUserData()) or (fixtureTwoName == fixtureTwo:getUserData())
    
    return (isFixtureOneColliding and isFixtureTwoColliding)
end

local function playerWindBehavior(collisionOne, collisionTwo, windBool)
  if not collisionBetween("player", "wind", collisionOne, collisionTwo) then
    return nil
  end

  if windBool then
    player.collisionBehavior.beginContactWind = true
    player.collisionBehavior.endContactWind = false
  elseif not windBool then
    player.collisionBehavior.endContactWind = true
    player.collisionBehavior.beginContactWind = false
  end
end

local function playerGroundedBehavior(collisionOne, collisionTwo, groundedBool)
  if not collisionBetween("playerGrounded", "city", collisionOne, collisionTwo) then
    return nil
  end

  if groundedBool then
    player.collisionBehavior.beginContactGrounded = true
    player.collisionBehavior.endContactGrounded = false
  elseif not groundedBool then
    player.collisionBehavior.endContactGrounded = true
    player.collisionBehavior.beginContactGrounded = false
  end
end

local function playerFinishBehavior(collisionOne, collisionTwo)   
  if not collisionBetween("player", "finish", collisionOne, collisionTwo) then
    return nil
  end

  levelEnd()
end

return {
    playerGroundedBehavior = playerGroundedBehavior,
    playerWindBehavior = playerWindBehavior,
    playerFinishBehavior = playerFinishBehavior,
}