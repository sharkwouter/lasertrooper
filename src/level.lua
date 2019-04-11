Level = Object:extend()

local playerObject, enemyObject, wallObject = 1, 2, 3

--Local functions, since they have to be defined before they can be used
local function drawrect(x, y, color)
  love.graphics.setColor(colors.black)
  love.graphics.rectangle("line", (x-1)*gridsize, (y-1)*gridsize, gridsize-1, gridsize-1)
  love.graphics.setColor(color)
  love.graphics.rectangle("fill", (x-1)*gridsize, (y-1)*gridsize, gridsize-1, gridsize-1)
end

function Level:new(tiles)
  self.tiles = tiles
  self.enemies = {}

  love.window.setMode(gridsize*#self.tiles[1], gridsize*#self.tiles)

  for y=1, #self.tiles do
    for x=1, #self.tiles[y] do
      if self.tiles[y][x] == playerObject then
        self.player = Player(x,y)
      elseif self.tiles[y][x] == enemyObject then
        table.insert(self.enemies, Enemy(x,y))
      end
    end
  end
end

function Level:update(dt)
  if self.player then
    self.player:update(dt)

    --Check if the player has walked into a wall and correct it
    for y=1, #self.tiles do
      for x=1, #self.tiles[y] do
        if self.tiles[y][x] == wallObject then
          if self.player:getX() == x and self.player:getY() == y then
            self.player:bounce()
          end
        end
      end
    end
  end

  --Update the enemies, doesn't really do anything yet
  for i, e in ipairs(self.enemies) do
    e:update(dt)
  end
end

function Level:draw()
  --Draw blocks
  for y=1, #self.tiles do
    for x=1, #self.tiles[y] do
      if self.tiles[y][x] == wallObject then
        drawrect(x,y, colors.yellow)
      end
    end
  end

  --Draw the enemies
  for i, e in ipairs(self.enemies) do
    e:draw()
  end

  --Draw the player last, so it is on top of everything
  if self.player then
    self.player:draw()
  end
end
