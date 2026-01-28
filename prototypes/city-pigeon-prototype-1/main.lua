-- constant variables that are based on what the unit is
UNIT = 64
WINDOW_LENGTH = UNIT*10
WINDOW_HEIGHT = UNIT*10
GRAVITY = UNIT*4
JUMP = UNIT*2
SPEED = UNIT*2
ACCELERATION = UNIT

-- 10x10 level grid that has x and y values for each tile to be draw in
LEVEL_GRID = {
  { {0, 0}, {UNIT, 0}, {UNIT*2, 0}, {UNIT*3, 0}, {UNIT*4, 0}, {UNIT*5, 0}, {UNIT*6, 0}, {UNIT*7, 0}, {UNIT*8, 0}, {UNIT*9, 0}, },
  { {0, UNIT}, {UNIT, UNIT}, {UNIT*2, UNIT}, {UNIT*3, UNIT}, {UNIT*4, UNIT}, {UNIT*5, UNIT}, {UNIT*6, UNIT}, {UNIT*7, UNIT}, {UNIT*8, UNIT}, {UNIT*9, UNIT}, },
  { {0, UNIT*2}, {UNI, UNIT*2}, {UNIT*2, UNIT*2}, {UNIT*3, UNIT*2}, {UNIT*4, UNIT*2}, {UNIT*5, UNIT*2}, {UNIT*6, UNIT*2}, {UNIT*7, UNIT*2}, {UNIT*8, UNIT*2}, {UNIT*9, UNIT*2}, },
  { {0, UNIT*3}, {UNIT, UNIT*3}, {UNIT*2, UNIT*3}, {UNIT*3, UNIT*3}, {UNIT*4, UNIT*3}, {UNIT*5, UNIT*3}, {UNIT*6, UNIT*3}, {UNIT*7, UNIT*3}, {UNIT*8, UNIT*3}, {UNIT*9, UNIT*3}, },
  { {0, UNIT*4}, {UNIT, UNIT*4}, {UNIT*2}, UNIT*4, {UNIT*3, UNIT*4}, {UNIT*4, UNIT*4}, {UNIT*5, UNIT*4}, {UNIT*6, UNIT*4}, {UNIT*7, UNIT*4}, {UNIT*8, UNIT*4}, {UNIT*9, UNIT*4}, },
  { {0, UNIT*5}, {UNIT, UNIT*5}, {UNIT*2, UNIT*5}, {UNIT*3, UNIT*5}, {UNIT*4, UNIT*5}, {UNIT*5, UNIT*5}, {UNIT*6, UNIT*5}, {UNIT*7, UNIT*5}, {UNIT*8, UNIT*5}, {UNIT*9, UNIT*5}, },
  { {0, UNIT*6}, {UNIT, UNIT*6}, {UNIT*2, UNIT*6}, {UNIT*3, UNIT*6}, {UNIT*4, UNIT*6}, {UNIT*5, UNIT*6}, {UNIT*6, UNIT*6}, {UNIT*7, UNIT*6}, {UNIT*8, UNIT*6}, {UNIT*9, UNIT*6}, },
  { {0, UNIT*7}, {UNIT, UNIT*7}, {UNIT*2, UNIT*7}, {UNIT*3, UNIT*7}, {UNIT*4, UNIT*7}, {UNIT*5, UNIT*7}, {UNIT*6, UNIT*7}, {UNIT*7, UNIT*7}, {UNIT*8, UNIT*7}, {UNIT*9, UNIT*7}, },
  { {0, UNIT*8}, {UNIT, UNIT*8}, {UNIT*2, UNIT*8}, {UNIT*3, UNIT*8}, {UNIT*4, UNIT*8}, {UNIT*5, UNIT*8}, {UNIT*6, UNIT*8}, {UNIT*7, UNIT*8}, {UNIT*8, UNIT*8}, {UNIT*9, UNIT*8}, },
  { {0, UNIT*9}, {UNIT, UNIT*9}, {UNIT*2, UNIT*9}, {UNIT*3, UNIT*9}, {UNIT*4, UNIT*9}, {UNIT*5, UNIT*9}, {UNIT*6, UNIT*9}, {UNIT*7, UNIT*9}, {UNIT*8, UNIT*9}, {UNIT*9, UNIT*9}, },
}

-- gridPos() function makes accessing coordinates from grid easier
function gridPos(arg_x, arg_y)
  return {
    x = LEVEL_GRID[arg_y][arg_x][1],
    y = LEVEL_GRID[arg_y][arg_x][2]
  }
end
  
world = love.physics.newWorld(0, GRAVITY, true)

-- player values include coordinates, width, height, and booleans for grounded state and flying state
player = {
  x = 0,
  y = 0,
  width = 32,
  height = 32,
  grounded = false,
  flying = false,
}

-- set up physics for player
player.body = love.physics.newBody(world, gridPos(2, 1).x, gridPos(2, 1).y, "dynamic")
player.shape = love.physics.newRectangleShape(player.width/2, player.height/2, player.width, player.height)
player.fixture = love.physics.newFixture(player.body, player.shape, 1)

-- levelOne table includes all props inside of level one
levelOne = {
  -- each prop includes values regarding coordinates, width, height, and special values for interative props
  boxOne = {
    x = gridPos(1, 10).x,
    y = gridPos(1, 10).y,
    width = UNIT*10,
    height = UNIT,
  },
  boxTwo = {
    x = gridPos(6, 5).x,
    y = gridPos(6, 5).y,
    width = UNIT*2,
    height = UNIT*5,
  },
  -- wind prop specifically has force value and apply state which is used to move the player
  wind = {
    x = gridPos(4, 8).x,
    y = gridPos(4, 8).y,
    width = UNIT,
    height = UNIT*2,
    force = {x=0, y=UNIT/2},
    apply = false,
  },
  finish = {
    x = gridPos(10, 9).x,
    y = gridPos(10, 9).y,
    width = UNIT,
    height = UNIT,
  }
}

-- set up all the physics for each of the props in levelOne
levelOne.boxOne.body = love.physics.newBody(world, levelOne.boxOne.x, levelOne.boxOne.y, "static")
levelOne.boxOne.shape = love.physics.newRectangleShape(levelOne.boxOne.width/2, levelOne.boxOne.height/2, levelOne.boxOne.width, levelOne.boxOne.height)
levelOne.boxOne.fixture = love.physics.newFixture(levelOne.boxOne.body, levelOne.boxOne.shape, 1)

levelOne.boxTwo.body = love.physics.newBody(world, levelOne.boxTwo.x, levelOne.boxTwo.y, "static")
levelOne.boxTwo.shape = love.physics.newRectangleShape(levelOne.boxTwo.width/2, levelOne.boxTwo.height/2, levelOne.boxTwo.width, levelOne.boxTwo.height)
levelOne.boxTwo.fixture = love.physics.newFixture(levelOne.boxTwo.body, levelOne.boxTwo.shape, 1)

levelOne.wind.body = love.physics.newBody(world, levelOne.wind.x, levelOne.wind.y, "static")
levelOne.wind.shape = love.physics.newRectangleShape(levelOne.wind.width/2, levelOne.wind.height/2, levelOne.wind.width, levelOne.wind.height)
levelOne.wind.fixture = love.physics.newFixture(levelOne.wind.body, levelOne.wind.shape, 1)

levelOne.finish.body = love.physics.newBody(world, levelOne.finish.x, levelOne.finish.y, "static")
levelOne.finish.shape = love.physics.newRectangleShape(levelOne.finish.width/2, levelOne.finish.height/2, levelOne.finish.width, levelOne.finish.height)
levelOne.finish.fixture = love.physics.newFixture(levelOne.finish.body, levelOne.finish.shape, 1)

-- functionality for when the level is completed
function levelEnd()
  love.event.quit(0)
end

function love.load()
  love.window.setMode(WINDOW_LENGTH, WINDOW_HEIGHT)
  love.window.setTitle("Pigeon Life")

  -- initialize behavior for player physics
  player.body:setFixedRotation(true)
  player.body:setLinearDamping(1)
  player.fixture:setFriction(0.5)

    -- initialize behavior for prop physics
  levelOne.boxOne.fixture:setFriction(1)
  levelOne.boxTwo.fixture:setFriction(1)
  levelOne.wind.fixture:setSensor(true)
  levelOne.finish.fixture:setSensor(true)
end

-- function that checks equivalency between four fixtures, fixtures CheckOne and One, and fixtures CheckTwo and Two.
-- meant to simplify code in world callbacks to make contact code readable
function checkTouching(fixtureCheckOne, fixtureOne, fixtureCheckTwo, fixtureTwo)
  if (fixtureCheckOne == fixtureOne and fixtureCheckTwo == fixtureTwo) or (fixtureCheckTwo == fixtureOne and fixtureCheckOne == fixtureTwo) then
    return true
  else
    return false
  end
end

function beginContact(collisionOne, collisionTwo, contact)
  -- initialize fixtures and coordinates for both of the collisions
  local fixtureOne, fixtureTwo = contact:getFixtures()
  local fixtureOneX, fixtureOneY = fixtureOne:getBody():getPosition()
  local fixtureTwoX, fixtureTwoY = fixtureTwo:getBody():getPosition()

  -- conditional variables that simplify code and make things readable
  local playerTouchingBoxOne = checkTouching(player.fixture, fixtureOne, levelOne.boxOne.fixture, fixtureTwo)

  local playerTouchingBoxTwo = checkTouching(player.fixture, fixtureOne, levelOne.boxTwo.fixture, fixtureTwo)

  local playerTouchingGround = playerTouchingBoxOne or playerTouchingBoxTwo

  local playerTouchingWind = checkTouching(player.fixture, fixtureOne, levelOne.wind.fixture, fixtureTwo)

  local playerTouchingFinish = checkTouching(player.fixture, fixtureOne, levelOne.finish.fixture, fixtureTwo)

  local playerAboveGround = (player.y <= fixtureOneY) or (player.y <= fixtureTwoY)

  -- updates grounded status and wind apply status
  -- also checks for if the player finishes the game
  if playerTouchingGround and playerAboveGround then
    player.grounded = true
  elseif playerTouchingWind then
    levelOne.wind.apply = true
  elseif playerTouchingFinish then
    levelEnd()
  end
end

function endContact(collisionOne, collisionTwo, contact)
  -- initialize fixtures and coordinates for both of the collisions
  local fixtureOne, fixtureTwo = contact:getFixtures()
  local fixtureOneX, fixtureOneY = fixtureOne:getBody():getPosition()
  local fixtureTwoX, fixtureTwoY = fixtureTwo:getBody():getPosition()

  -- conditional variables that simplify code and make things readable
  local playerTouchingBoxOne = checkTouching(player.fixture, fixtureOne, levelOne.boxOne.fixture, fixtureTwo)

  local playerTouchingBoxTwo = checkTouching(player.fixture, fixtureOne, levelOne.boxTwo.fixture, fixtureTwo)

  local playerTouchingGround = playerTouchingBoxOne or playerTouchingBoxTwo

  local playerTouchingWind = checkTouching(player.fixture, fixtureOne, levelOne.wind.fixture, fixtureTwo)

  local playerTouchingFinish = checkTouching(player.fixture, fixtureOne, levelOne.finish.fixture, fixtureTwo)

  local playerAboveGround = (player.y <= fixtureOneY) or (player.y <= fixtureTwoY)

  -- updates grounded status and wind apply status
  -- this time it sets both to false because endContact function is called when the two objects 'end contact'
  if playerTouchingGround then
    player.grounded = false
  end
  if playerTouchingWind then
    levelOne.wind.apply = false
  end
end

function love.update(dt)
  world:update(dt)
  world:setCallbacks(beginContact, endContact)

  local dx, dy = 0, 0 -- change in velocity
  local vx, vy = player.body:getLinearVelocity() -- current velocity


  -- conditional variables for inputs
  local flying = love.keyboard.isDown("space")
  local jump = love.keyboard.isDown({"w", "up"})
  local right = love.keyboard.isDown({"d", "right"})
  local left = love.keyboard.isDown({"a", "left"})

  -- reset fly mechanic whenever you come back to the ground
  if player.grounded then
    player.flying = false
  end

  -- general controls
  if jump and player.grounded then
    dy = -JUMP
  elseif right and vx <= SPEED then
    dx = ACCELERATION
  elseif left and vx >= -SPEED then
    dx = -ACCELERATION
  elseif flying and not player.flying then
    player.body:setLinearVelocity(vx, -JUMP*1.5) -- flight mechanic
    player.flying = true
  end

  -- apply wind to player when active
  if levelOne.wind.apply then
    dx = -levelOne.wind.force.x
    dy = -levelOne.wind.force.y
  end

  if player.flying then
    player.body:setGravityScale(0.25)
  else
    player.body:setGravityScale(1)
  end

  player.body:applyLinearImpulse(dx, dy)
  player.x, player.y = player.body:getPosition()
end

function love.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle("fill", levelOne.boxOne.x, levelOne.boxOne.y, levelOne.boxOne.width, levelOne.boxOne.height)
  love.graphics.rectangle("fill", levelOne.boxTwo.x, levelOne.boxTwo.y, levelOne.boxTwo.width, levelOne.boxTwo.height)

  love.graphics.setColor(0.8, 0.8, 1)
  love.graphics.rectangle("fill", levelOne.wind.x, levelOne.wind.y, levelOne.wind.width, levelOne.wind.height)

  love.graphics.setColor(0, 1, 0)
  love.graphics.rectangle("fill", levelOne.finish.x, levelOne.finish.y, levelOne.finish.width, levelOne.finish.height)

  love.graphics.setColor(0,0,1)
  love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end