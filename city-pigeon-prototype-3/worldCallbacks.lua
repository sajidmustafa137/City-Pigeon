local collisionBehavior = require("collisionBehavior")

-- these functions run collision behavior
-- used as callback functions in world physics

local function beginContact(collisionOne, collisionTwo, contact)
  collisionBehavior.playerGroundedBehavior(collisionOne, collisionTwo, true)
  collisionBehavior.playerWindBehavior(collisionOne, collisionTwo, true)
  collisionBehavior.playerFinishBehavior(collisionOne, collisionTwo)
end

local function endContact(collisionOne, collisionTwo, contact)
  collisionBehavior.playerGroundedBehavior(collisionOne, collisionTwo, false)
  collisionBehavior.playerWindBehavior(collisionOne, collisionTwo, false)
end

return {
  beginContact = beginContact,
  endContact = endContact,
}