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
  objects.robot_body = {}
  objects.robot_body.body = love.physics.newBody(world, .5, .5)
  objects.robot_body.shape = love.physics.newRectangleShape(.1, .1)
  objects.robot_body.fixture = love.physics.newFixture(objects.robot_body.body, objects.robot_body.shape)

  objects.black_board = {}
  objects.black_board.body = love.physics.newBody(world, .5, .5)
  objects.black_board.shape = love.physics.newCircleShape(.85)
  objects.black_board.fixture = love.physics.newFixture(objects.black_board.body, objects.black_board.shape)

  objects.white_border = {}
  objects.white_border.body = love.physics.newBody(world, .5, .5)
  objects.white_border.shape = love.physics.newCircleShape(.95)
  objects.white_border.fixture = love.physics.newFixture(objects.white_border.body, objects.black_board.shape)

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
  love.graphics.setBackgroundColor(.1, .3, .8)
  love.window.setMode(650, 650) --set the window dimensions to 650 by 650 with no fullscreen, vsync on, and no antialiasing
end

function love.update(dt)
  world:update(dt) --this puts the world into motion
end

local function rectangle_points(window_width, window_height, x1, y1, x2, y2, x3, y3, x4, y4)
  local w = math.min(window_width, window_height)
  return x1 * w, y1 * w, x2 * w, y2 * w, x3 * w, y3 * w, x4 * w, y4 * w
end

local function circle_points(window_width, window_height, x, y, r)
  local w = math.min(window_width, window_height)
  return x * w, y * w, r * w/2
end

function love.draw()
  window_width, window_height = love.graphics.getDimensions( )

  love.graphics.setColor(1,1,1)
  love.graphics.circle("fill", circle_points(window_width, window_height, objects.white_border.body:getX(),
    objects.white_border.body:getY(), objects.white_border.shape:getRadius()))

  love.graphics.setColor(0,0,0)
  love.graphics.circle("fill", circle_points(window_width, window_height, objects.black_board.body:getX(),
    objects.black_board.body:getY(), objects.black_board.shape:getRadius()))

  love.graphics.setColor(.6,0,0)
  love.graphics.polygon("fill", rectangle_points(window_width, window_height, objects.robot_body.body:getWorldPoints(objects.robot_body.shape:getPoints())))

end
