function love.load()
  --Load the classic library so we can do oop
  Object = require "libraries/classic"

  --Global variables
  gridsize = 80

  --Color variables
  colors={
    red={255,0,0},
    blue={0,0,255},
    green={0,255,0},
    cyan={0,255,255},
    purple={128,0,255},
    orange={255,128,0},
    yellow={255,255,0},
    white={255,255,255},
    black={0,0,0}
  }

  --Load our classes
  require "level"
  require "player"
  require "enemy"

  --Set the background color
  love.graphics.setBackgroundColor(colors.green)

  --Set the font
  font = love.graphics.newFont("fonts/DejaVuSansMono-Bold.ttf", 16 )
  love.graphics.setFont(font)

  --Set the window title
  love.window.setMode(gridsize*20, gridsize*15)
  love.window.setTitle("Laser Trooper")

  --Load level
  currentlevel = 1
  level = Level(currentlevel)
end

function love.update(dt)
  if love.keyboard.isDown("escape") then
    love.event.quit()
  end

  if not pressed then
      pressed = false
    end
    if love.keyboard.isDown("n") then
      if pressed == false then
        currentlevel = currentlevel + 1
        level = Level(currentlevel)
        pressed = true
      end
    else
      pressed = false
    end

  level:update(dt)
end

function love.draw()
  level:draw()
end
