local Config = require('config')
local Obstacles = require('obstacles')

local ObstacleHandler = { }

local ActiveObstacles = { }

local function addObstacle(Obstacle)
    World:add(Obstacle, Obstacle.x, Obstacle.y, Obstacle.width, Obstacle.height)
end

function spawnNewObstacle()
    -- Warning phase: 2 seconds
    ObstacleTimer:after(2, function()
        -- Remove old obstacle if it exists
        if #ActiveObstacles > 0 then
            local oldObstacle = ActiveObstacles[1]
            World:remove(oldObstacle)
            table.remove(ActiveObstacles, 1)
        end
        
        local newObstacle = Obstacles[1]
        newObstacle.x, newObstacle.y = math.random(9, Config.BASE_WIDTH - 24), Config.BASE_HEIGHT - 16
        newObstacle.vx, newObstacle.vy = 0, 0
        addObstacle(newObstacle)
        table.insert(ActiveObstacles, newObstacle)
    end)
    
    -- Visible phase: 2 seconds
    ObstacleTimer:after(2, function()
        spawnNewObstacle()
    end)
end

local function move(self, dt)
    -- Bump world

    local goalX = self.x + self.vx * dt;
    local goalY = self.y + self.vy * dt;

    local actualX, actualY, cols, len = World:move(self, goalX, goalY) -- need to resolve collsions

    self.x, self.y = actualX, actualY
end

function ObstacleHandler:update(dt)
    for _, Obstacle in pairs(ActiveObstacles) do
        move(Obstacle, dt)
        Obstacle.vy = -Obstacle.speed
    end
end

function ObstacleHandler:draw()
    for _, Obstacle in pairs(ActiveObstacles) do
        love.graphics.draw(Obstacle.image, Obstacle.x, Obstacle.y)
    end
end

return ObstacleHandler