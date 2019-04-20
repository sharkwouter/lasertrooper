Level = Object:extend()

local watertile = 2

function Level:new(number)
  self.tiles = {}
  self.enemies = {}

  local filename = "levels/level"..string.format("%03d", number)..".lvl"
  print(filename)

  --Load the whole file
  file = love.filesystem.read(filename, all)

  self.player = Player(string.byte(file, 1) + 1, string.byte(file, 5) + 1)

  --The bytes 9 until 1205 contain which parts of the level are water and which parts aren't
  local x, y = 1, 1
  for b=9, 1205, 4 do
    output = string.byte(file, b)
    if output then
      if y == 16 then
        x = x + 1
        y = 1
      end
      if y == 1 then
        self.tiles[x] = {}
      end
      table.insert(self.tiles[x], output)
      y = y + 1
    end
  end

  self.description = string.sub(file, 6006, 6264)
  self.author = string.sub(file, 6265)

  print(author)
  print(description)
end

function Level:update(dt)
  if self.player then
    self.player:update(dt)

    --Check if the player has walked into a wall and correct it
    local playerx, playery = self.player:getX(), self.player:getY()
    for x=1, #self.tiles do
      for y=1, #self.tiles[x] do
        if self.tiles[x][y] == watertile then
          if playerx == x and playery == y then
            self.player:bounce()
          end
        end
      end
    end
    if playerx < 1 or playerx > 20 or playery < 1 or playery > 15 then
      self.player:bounce()
    end
  end

  --Update the enemies, doesn't really do anything yet
  for i, e in ipairs(self.enemies) do
    e:update(dt)
  end
end

function Level:draw()
  --Draw blocks
  for x=1, #self.tiles do
    for y=1, #self.tiles[x] do
      if self.tiles[x][y] == watertile then
        love.graphics.setColor(colors.blue)
        love.graphics.rectangle("fill", (x-1)*gridsize, (y-1)*gridsize, gridsize, gridsize)
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
