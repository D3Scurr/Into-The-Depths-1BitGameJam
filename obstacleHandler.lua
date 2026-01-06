local ObstacleHandler = {
    WarnImage = love.graphics.newImage('res/img/Warn-block.png'),
    ObstacleImage = love.graphics.newImage('res/img/Obstacle-box.png')
}

local Obstacle = {
    width = 16,
    height = 16,
}

Obstacle.x = math.random(9, Config.BASE_WIDTH - 8 - Obstacle.width)

function ObstacleHandler:draw()
    if Timer.ObstacleWait >= 2 then
        if Timer.ObstacleOnScreen < 2 then
            love.graphics.draw(self.ObstacleImage, Obstacle.x, Config.BASE_HEIGHT - 16)
        else
            Timer.ObstacleWait = 0
            Timer.ObstacleOnScreen = 0
            Obstacle.x = math.random(9, Config.BASE_WIDTH-8-Obstacle.width)
        end
    else
        love.graphics.draw(self.WarnImage, Obstacle.x, Config.BASE_HEIGHT - 16)
    end
end

return ObstacleHandler