local inspect = require('inspect')
local colors = require('src.colors')

function love.conf(t)
  t.title = "Sumo Bot Simulator"
  t.author = "Sam DuPlessis"
  t.version = "11.3"
end

function love.load()
  love.physics.setMeter(64) --the height of a meter our worlds will be 64px
  world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
  objects = {}

  objects.main_robot = {}

  objects.main_robot.body = {}
  objects.main_robot.body.body = love.physics.newBody(world, .6, .6)
  objects.main_robot.body.shape = love.physics.newRectangleShape(.1, .1)
  objects.main_robot.body.fixture = love.physics.newFixture(objects.main_robot.body.body, objects.main_robot.body.shape)
  objects.main_robot.body.color = colors.red

  objects.main_robot.left_white_line_sensor = {}
  objects.main_robot.left_white_line_sensor.body = love.physics.newBody(world, .56, .56)
  objects.main_robot.left_white_line_sensor.shape = love.physics.newCircleShape(.015)
  objects.main_robot.left_white_line_sensor.fixture = love.physics.newFixture(objects.main_robot.left_white_line_sensor.body, objects.main_robot.left_white_line_sensor.shape)
  objects.main_robot.left_white_line_sensor.color = colors.orange

  objects.main_robot.right_white_line_sensor = {}
  objects.main_robot.right_white_line_sensor.body = love.physics.newBody(world, .64, .56)
  objects.main_robot.right_white_line_sensor.shape = love.physics.newCircleShape(.015)
  objects.main_robot.right_white_line_sensor.fixture = love.physics.newFixture(objects.main_robot.right_white_line_sensor.body, objects.main_robot.right_white_line_sensor.shape)
  objects.main_robot.right_white_line_sensor.color = colors.yellow

  objects.opp_robot = {}

  objects.opp_robot.body = {}
  objects.opp_robot.body.body = love.physics.newBody(world, .4, .4)
  objects.opp_robot.body.shape = love.physics.newRectangleShape(.1, .1)
  objects.opp_robot.body.fixture = love.physics.newFixture(objects.opp_robot.body.body, objects.opp_robot.body.shape)
  objects.opp_robot.body.color = colors.brown

  objects.opp_robot.left_white_line_sensor = {}
  objects.opp_robot.left_white_line_sensor.body = love.physics.newBody(world, .44, .44)
  objects.opp_robot.left_white_line_sensor.shape = love.physics.newCircleShape(.015)
  objects.opp_robot.left_white_line_sensor.fixture = love.physics.newFixture(objects.opp_robot.left_white_line_sensor.body, objects.opp_robot.left_white_line_sensor.shape)
  objects.opp_robot.left_white_line_sensor.color = colors.light_purple

  objects.opp_robot.right_white_line_sensor = {}
  objects.opp_robot.right_white_line_sensor.body = love.physics.newBody(world, .36, .44)
  objects.opp_robot.right_white_line_sensor.shape = love.physics.newCircleShape(.015)
  objects.opp_robot.right_white_line_sensor.fixture = love.physics.newFixture(objects.opp_robot.right_white_line_sensor.body, objects.opp_robot.right_white_line_sensor.shape)
  objects.opp_robot.right_white_line_sensor.color = colors.pink

  objects.black_board = {}
  objects.black_board.body = love.physics.newBody(world, .5, .5)
  objects.black_board.shape = love.physics.newCircleShape(.85)
  objects.black_board.fixture = love.physics.newFixture(objects.black_board.body, objects.black_board.shape)
  objects.black_board.color = colors.black

  objects.white_border = {}
  objects.white_border.body = love.physics.newBody(world, .5, .5)
  objects.white_border.shape = love.physics.newCircleShape(.95)
  objects.white_border.fixture = love.physics.newFixture(objects.white_border.body, objects.black_board.shape)
  objects.white_border.color = colors.white



  love.graphics.setBackgroundColor(colors.blue())
  love.window.setMode(650, 650)
end

function love.update(dt)
  world:update(dt)
end

local function rectangle_points(window_width, window_height, x1, y1, x2, y2, x3, y3, x4, y4)
  local w = math.min(window_width, window_height)
  return x1 * w, y1 * w, x2 * w, y2 * w, x3 * w, y3 * w, x4 * w, y4 * w
end

local function circle_points(window_width, window_height, x, y, r)
  local w = math.min(window_width, window_height)
  return x * w, y * w, r * w/2
end

local function draw_object(object)
  love.graphics.setColor(object.color())

  local shape_type = object.shape:type()
  if shape_type == "CircleShape" then
    love.graphics.circle("fill", circle_points(window_width, window_height, object.body:getX(),
      object.body:getY(), object.shape:getRadius()))
  elseif shape_type == "PolygonShape" then
    love.graphics.polygon("fill", rectangle_points(window_width, window_height, object.body:getWorldPoints(object.shape:getPoints())))
  end
end

function love.draw()
  window_width, window_height = love.graphics.getDimensions()

  draw_object(objects.white_border)
  draw_object(objects.black_board)

  draw_object(objects.main_robot.body)
  draw_object(objects.main_robot.left_white_line_sensor)
  draw_object(objects.main_robot.right_white_line_sensor)

  draw_object(objects.opp_robot.body)
  draw_object(objects.opp_robot.left_white_line_sensor)
  draw_object(objects.opp_robot.right_white_line_sensor)

end
