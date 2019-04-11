Wall = Object:extend()

function Wall:new(x, y)
  self.x = x
  self.y = y
end

function Wall:draw()
  love.graphics.setColor(colors.black)
  love.graphics.rectangle("line", x*gridsize, y*gridsize, gridsize-1, gridsize-1)
  love.graphics.setColor(colors.yellow)
  love.graphics.rectangle("fill", x*gridsize, y*gridsize, gridsize-1, gridsize-1)
end
