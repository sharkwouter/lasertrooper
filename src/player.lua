Player = Object:extend()

local left, down, right, up = 1, 2, 3, 4
local speed = 5

function Player:new(x, y)
  self.x = (x-1)*gridsize
  self.y = (y-1)*gridsize
  self.xprevious = self.x
  self.yprevious = self.y
  self.direction = 0
  self.aimdirection = 0
  self.moving = false
end

function Player:update(dt)
  self:setAim()
  --Stop when the grid is reached, unless the player is holding a direction button
  if self:isOnGrid() then
    --The isOnGrid check is not that precise. Correct put us back on the grid if we drifted off a little
    self:correctPosition()

    --Check if we need to stop
    if love.keyboard.isDown("left", "up", "right", "down", "a", "w", "d", "s") then
      self.moving = true
    else
      self.moving = false
    end

    --Set the direction of movement
    if love.keyboard.isDown("left", "a") then
      self.direction = left
    elseif love.keyboard.isDown("up", "w") then
      self.direction = up
    elseif love.keyboard.isDown("right", "d") then
      self.direction = right
    elseif love.keyboard.isDown("down", "s") then
      self.direction = down
    end
  end

  --Move the player character
  if self.moving then
    self.xprevious = self.x
    self.yprevious = self.y
    if self.direction == left then
      self.x = self.x-speed
    elseif self.direction == up then
      self.y = self.y-speed
    elseif self.direction == right then
      self.x = self.x+speed
    elseif self.direction == down then
      self.y = self.y+speed
    end
  end

  --Stop at the edge of the level
end

function Player:draw()
  love.graphics.setColor(colors.red)
  love.graphics.rectangle("fill", self.x, self.y, gridsize, gridsize)

  --Draw laser
  if self.aimdirection == left then
    love.graphics.line(self.x+gridsize/2, self.y+gridsize/2, self.x+gridsize/2-200, self.y+gridsize/2)
  elseif self.aimdirection == up then
    love.graphics.line(self.x+gridsize/2, self.y+gridsize/2, self.x+gridsize/2, self.y+gridsize/2-200)
  elseif self.aimdirection == right then
    love.graphics.line(self.x+gridsize/2, self.y+gridsize/2, self.x+gridsize/2+200, self.y+gridsize/2)
  elseif self.aimdirection == down then
    love.graphics.line(self.x+gridsize/2, self.y+gridsize/2, self.x+gridsize/2, self.y+gridsize/2+200)
  end
end

function Player:correctPosition()
  local x = self.x % gridsize
  local y = self.y % gridsize
  if x ~= 0 or y ~= 0 then
    self.x = self:getX()*gridsize-gridsize
    self.y = self:getY()*gridsize-gridsize
  end
end

function Player:isOnGrid()
  local x = self.x % gridsize
  local y = self.y % gridsize
  if x < speed and y < speed then
    return true
  else
    return false
  end
end

function Player:getX()
  local x = self.x % gridsize
  if self.moving and self.direction == right and x >= speed then
    return (self.x-x)/gridsize+2
  end
  return (self.x-x)/gridsize+1
end

function Player:getY()
  local y = self.y % gridsize
  if self.moving and self.direction == down and y >= speed then
    return (self.y-y)/gridsize+2
  end
  return (self.y-y)/gridsize+1
end

function Player:bounce()
  self.x = self.xprevious
  self.y = self.yprevious
  self.moving = false
end

function Player:setAim()
  local deltaX = love.mouse.getX() - self.x
  local deltaY = love.mouse.getY() - self.y
  local direction = math.atan2(deltaX, deltaY)+2
  if direction < 0 or direction > 4 then
    self.aimdirection = 4
  elseif direction < 1 then
    self.aimdirection = 1
  else
    self.aimdirection = math.floor(direction)
  end
end
