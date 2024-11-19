local inspect = require('inspect')

function love.conf(t)
    t.title = "Sumo Bot Simulator"
    t.author = "Sam DuPlessis"
    t.version = "11.3"
end

function love.load()
  love.physics.setMeter(64) --the height of a meter our worlds will be 64px
  world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
  objects = {} -- table to hold all our physical objects

  --let's create the ground
  objects.black_circle = {}
  objects.black_circle.body = love.physics.newBody(world, 200, 200)
  objects.black_circle.shape = love.physics.newCircleShape(80)
  objects.black_circle.fixture = love.physics.newFixture(objects.black_circle.body, objects.black_circle.shape)

  -- --let's create a ball
  -- objects.ball = {}
  -- objects.ball.body = love.physics.newBody(world, 650/2, 650/2, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
  -- objects.ball.shape = love.physics.newCircleShape( 20) --the ball's shape has a radius of 20
  -- objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape, 1) -- Attach fixture to body and give it a density of 1.
  -- objects.ball.fixture:setRestitution(0.9) --let the ball bounce

  -- --let's create a couple blocks to play around with
  -- objects.block1 = {}
  -- objects.block1.body = love.physics.newBody(world, 200, 550, "dynamic")
  -- objects.block1.shape = love.physics.newRectangleShape(0, 0, 50, 100)
  -- objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 5) -- A higher density gives it more mass.

  -- objects.block2 = {}
  -- objects.block2.body = love.physics.newBody(world, 200, 400, "dynamic")
  -- objects.block2.shape = love.physics.newRectangleShape(0, 0, 100, 50)
  -- objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 2)

  --initial graphics setup
  love.graphics.setBackgroundColor(0.41, 0.53, 0.97) --set the background color to a nice blue
  love.window.setMode(650, 650) --set the window dimensions to 650 by 650 with no fullscreen, vsync on, and no antialiasing
end

function love.update(dt)
  world:update(dt) --this puts the world into motion
end

function love.draw()
  love.graphics.setColor(0.28, 0.63, 0.05)
  love.graphics.circle("fill", objects.black_circle.body:getX(), objects.black_circle.body:getY(), objects.black_circle.shape:getRadius())
  love.graphics.setColor(0.76, 0.18, 0.05)
end
