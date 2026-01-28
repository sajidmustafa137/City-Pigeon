local collisionBehavior = require("collisionBehavior")

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