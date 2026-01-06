local ObstacleHandler = {
    WarnImage = love.graphics.newImage('res/img/Warn-block.png'),
    ObstacleImage = love.graphics.newImage('res/img/Obstacle-box.png'),
    showObstacle = false,
    obstacleX = 0
}

function spawnNewObstacle()
    ObstacleHandler.obstacleX = math.random(9, Config.BASE_WIDTH - 24)
    ObstacleHandler.showObstacle = false
    
    -- Warning phase: 2 seconds
    ObstacleTimer:after(2, function()
        ObstacleHandler.showObstacle = true
    end)
    
    -- Visible phase: 3 seconds (2 + 3 = 5 total)
    ObstacleTimer:after(5, function()
        spawnNewObstacle()
    end)
end

function ObstacleHandler:draw()
    if self.showObstacle then
        love.graphics.draw(self.ObstacleImage, self.obstacleX, Config.BASE_HEIGHT - 16)
    else
        love.graphics.draw(self.WarnImage, self.obstacleX, Config.BASE_HEIGHT - 16)
    end
end

return ObstacleHandler