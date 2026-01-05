Player = Object:extend()

function Player:new(x, y, image)
    self.x, self.y = x, y
    self.image = love.graphics.newImage(image)
end

function Player:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

return Player