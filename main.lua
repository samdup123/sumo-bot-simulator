local inspect = require('inspect')
local colors = require('src.colors')
local object_category = require('src.object_category')

function love.conf(t)
  t.title = "Sumo Bot Simulator"
  t.author = "Sam DuPlessis"
  t.version = "11.3"
end

function love.load()
  love.physics.setMeter(64) --the height of a meter our worlds will be 64px
  world = love.physics.newWorld(0, 0, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
  objects = {}

  objects.main_robot = {}

  objects.main_robot.body = {}
  objects.main_robot.body.body = love.physics.newBody(world, .6, .6, "dynamic")
  objects.main_robot.body.shape = love.physics.newRectangleShape(.1, .1)
  objects.main_robot.body.fixture = love.physics.newFixture(objects.main_robot.body.body, objects.main_robot.body.shape)
  objects.main_robot.body.fixture:setRestitution(0.9)
  objects.main_robot.body.fixture:setCategory(object_category.robot)
  objects.main_robot.body.fixture:setMask(object_category.world, object_category.robot)
  objects.main_robot.body.color = colors.red

  objects.main_robot.left_white_line_sensor = {}
  objects.main_robot.left_white_line_sensor.body = love.physics.newBody(world, .56, .56, "dynamic")
  objects.main_robot.left_white_line_sensor.shape = love.physics.newCircleShape(.015)
  objects.main_robot.left_white_line_sensor.fixture = love.physics.newFixture(objects.main_robot.left_white_line_sensor.body, objects.main_robot.left_white_line_sensor.shape)
  objects.main_robot.left_white_line_sensor.fixture:setRestitution(0.9)
  objects.main_robot.left_white_line_sensor.fixture:setCategory(object_category.robot)
  objects.main_robot.left_white_line_sensor.fixture:setMask(object_category.world, object_category.robot)
  objects.main_robot.left_white_line_sensor.color = colors.orange
  objects.main_robot.left_white_line_sensor_joint = love.physics.newDistanceJoint(objects.main_robot.body.body, objects.main_robot.left_white_line_sensor.body, .56, .56, .56, .56)

  objects.main_robot.right_white_line_sensor = {}
  objects.main_robot.right_white_line_sensor.body = love.physics.newBody(world, .64, .56, "dynamic")
  objects.main_robot.right_white_line_sensor.shape = love.physics.newCircleShape(.015)
  objects.main_robot.right_white_line_sensor.fixture = love.physics.newFixture(objects.main_robot.right_white_line_sensor.body, objects.main_robot.right_white_line_sensor.shape)
  objects.main_robot.right_white_line_sensor.fixture:setRestitution(0.9)
  objects.main_robot.right_white_line_sensor.fixture:setCategory(object_category.robot)
  objects.main_robot.right_white_line_sensor.fixture:setMask(object_category.world, object_category.robot)
  objects.main_robot.right_white_line_sensor.color = colors.yellow
  objects.main_robot.right_white_line_sensor_joint = love.physics.newDistanceJoint(objects.main_robot.body.body, objects.main_robot.right_white_line_sensor.body, .64, .56, .64, .56)

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
  objects.opp_robot.left_white_line_sensor_joint = love.physics.newDistanceJoint(objects.opp_robot.body.body, objects.opp_robot.left_white_line_sensor.body, .44, .44, .44, .44)

  objects.opp_robot.right_white_line_sensor = {}
  objects.opp_robot.right_white_line_sensor.body = love.physics.newBody(world, .36, .44)
  objects.opp_robot.right_white_line_sensor.shape = love.physics.newCircleShape(.015)
  objects.opp_robot.right_white_line_sensor.fixture = love.physics.newFixture(objects.opp_robot.right_white_line_sensor.body, objects.opp_robot.right_white_line_sensor.shape)
  objects.opp_robot.right_white_line_sensor.color = colors.pink
  objects.opp_robot.right_white_line_sensor_joint = love.physics.newDistanceJoint(objects.opp_robot.body.body, objects.opp_robot.right_white_line_sensor.body, .36, .44, .36, .44)

  objects.black_board = {}
  objects.black_board.body = love.physics.newBody(world, .5, .5)
  objects.black_board.shape = love.physics.newCircleShape(.85)
  objects.black_board.fixture = love.physics.newFixture(objects.black_board.body, objects.black_board.shape)
  objects.black_board.fixture:setCategory(object_category.world)
  objects.black_board.fixture:setMask(object_category.world, object_category.robot)
  objects.black_board.color = colors.black

  objects.white_border = {}
  objects.white_border.body = love.physics.newBody(world, .5, .5)
  objects.white_border.shape = love.physics.newCircleShape(.95)
  objects.white_border.fixture = love.physics.newFixture(objects.white_border.body, objects.black_board.shape)
  objects.white_border.fixture:setCategory(object_category.world)
  objects.white_border.fixture:setMask(object_category.world, object_category.robot)
  objects.white_border.color = colors.white

  objects.walls = {}

  objects.walls.left = {}
  objects.walls.left.body = love.physics.newBody(world, 0, .5)
  objects.walls.left.shape = love.physics.newRectangleShape(.01, 1)
  objects.walls.left.fixture = love.physics.newFixture(objects.walls.left.body, objects.walls.left.shape)
  objects.walls.left.fixture:setCategory(object_category.walls)
  objects.walls.left.color = colors.green

  objects.walls.right = {}
  objects.walls.right.body = love.physics.newBody(world, 1, .5)
  objects.walls.right.shape = love.physics.newRectangleShape(.01, 1)
  objects.walls.right.fixture = love.physics.newFixture(objects.walls.right.body, objects.walls.right.shape)
  objects.walls.right.fixture:setCategory(object_category.walls)
  objects.walls.right.color = colors.green

  objects.walls.top = {}
  objects.walls.top.body = love.physics.newBody(world, .5, 0)
  objects.walls.top.shape = love.physics.newRectangleShape(1, .01)
  objects.walls.top.fixture = love.physics.newFixture(objects.walls.top.body, objects.walls.top.shape)
  objects.walls.top.fixture:setCategory(object_category.walls)
  objects.walls.top.color = colors.green

  objects.walls.bottom = {}
  objects.walls.bottom.body = love.physics.newBody(world, .5, 1)
  objects.walls.bottom.shape = love.physics.newRectangleShape(1, .01)
  objects.walls.bottom.fixture = love.physics.newFixture(objects.walls.bottom.body, objects.walls.bottom.shape)
  objects.walls.bottom.fixture:setCategory(object_category.walls)
  objects.walls.bottom.color = colors.green

  love.graphics.setBackgroundColor(colors.blue())
  love.window.setMode(650, 650)
end

function love.update(dt)
  world:update(dt)

  if love.keyboard.isDown("right") then
    objects.main_robot.body.body:applyForce(1, 0)
  end
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

  draw_object(objects.walls.left)
  draw_object(objects.walls.right)
  draw_object(objects.walls.top)
  draw_object(objects.walls.bottom)

  draw_object(objects.main_robot.body)
  draw_object(objects.main_robot.left_white_line_sensor)
  draw_object(objects.main_robot.right_white_line_sensor)

  draw_object(objects.opp_robot.body)
  draw_object(objects.opp_robot.left_white_line_sensor)
  draw_object(objects.opp_robot.right_white_line_sensor)

end
