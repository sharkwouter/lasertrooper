Enemy = Object:extend()

function Enemy:new(x, y)
  self.x = x
  self.y = y
end

function Enemy:update(dt)

end

function Enemy:draw()
  love.graphics.setColor(colors.black)
  love.graphics.rectangle("line", (self.x-1)*gridsize, (self.y-1)*gridsize, gridsize-1, gridsize-1)
  love.graphics.setColor(colors.blue)
  love.graphics.rectangle("fill", (self.x-1)*gridsize, (self.y-1)*gridsize, gridsize-1, gridsize-1)
end
