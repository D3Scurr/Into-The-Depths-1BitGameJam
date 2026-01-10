local Config = require('config')
local Obstacles = require('obstacles')

local ObstacleHandler = { }

local WarnedObstacles = { }
local ActiveObstacles = { }

local minRange = 9
local maxRange = Config.BASE_WIDTH - 8

ObstacleSpeedMult = 1
ObstacleSpeedAdd = 0.1

ObstacleSpawnMult = 1
ObstacleSpawnAdd = -0.05

local bunkMeterBonus = 10

function ObstacleHandler:reset()
    WarnedObstacles = { }
    ActiveObstacles = { }
    ObstacleSpeedMult = 1
end

local function addObstacle(Obstacle)
    World:add(Obstacle, Obstacle.x, Obstacle.y, Obstacle.width, Obstacle.height)
end

local function destroyOldObstacle()
    local oldObstacle = ActiveObstacles[1]
    World:remove(oldObstacle)
    table.remove(ActiveObstacles, 1)
end

local function createObstacleInstance(obstacleTemplate)
    -- Create a new instance based on the template
    local newObstacle = {
        type = obstacleTemplate.type,
        name = obstacleTemplate.name,
        warnImage = obstacleTemplate.warnImage,
        image = obstacleTemplate.image,
        speed = obstacleTemplate.speed,
        height = obstacleTemplate.height,
        width = obstacleTemplate.width,
        bunkCharge = obstacleTemplate.bunkCharge or 0,
        isObstacle = false,
        x = 0,
        y = 0,
        vx = 0,
        vy = 0
    }
    return newObstacle
end

function spawnNewObstacle()
    local newObstacle = createObstacleInstance(Obstacles[math.random(1,3)])

    local downRange = (Player.x - 1 * 16)
    local upRange = (Player.x + 2 * 16)

    if downRange < minRange then
        downRange = minRange
    elseif downRange > maxRange - newObstacle.width then
        downRange = maxRange - newObstacle.width
    end

    if upRange < minRange then
        upRange = minRange
    elseif upRange > maxRange - newObstacle.width then
        upRange = maxRange - newObstacle.width
    end

    newObstacle.x, newObstacle.y = math.random(downRange, upRange), Config.BASE_HEIGHT - newObstacle.height
    
    table.insert(WarnedObstacles, newObstacle)
    
    -- Warning phase: 2 seconds
    ObstacleTimer:after(2 * ObstacleSpawnMult, function()
        table.remove(WarnedObstacles, 1)

        -- Remove old obstacle if it exists
        if #ActiveObstacles > 0 then
            destroyOldObstacle()
        end
        
        newObstacle.vx, newObstacle.vy = 0, 0
        newObstacle.isObstacle = true
        addObstacle(newObstacle)
        table.insert(ActiveObstacles, newObstacle)
    end)
    
    -- Visible phase: 2 seconds
    ObstacleTimer:after(2 * ObstacleSpawnMult, function()
        spawnNewObstacle()
    end)
end

local ObjectFilter = function (item, other)
    if other.isPlayer then return 'cross'
    end
end

local function resolveCollisions(cols, len)
    for i = 1, len do
        local col = cols[i]

        if col.type == 'cross' then
            sounds.destroy:play()
            if not Player.isBunk then
                sounds.hit:play()
                Player.health = Player.health - 1
                Player.bunkMeter = 0
            else
                if not (Player.vx == 0 and Player.vy == 0) then
                    Player.bunkMeter = Player.bunkMeter + col.item.bunkCharge
                    Player.score = Player.score + col.item.bunkCharge * 2
                end
            end
            Player.isBunk = false
            ScreenShake()
            destroyOldObstacle()
        end
    end
end

local function move(self, dt)
    -- Bump world

    local goalX = self.x + self.vx * dt;
    local goalY = self.y + self.vy * dt;

    local actualX, actualY, cols, len = World:move(self, goalX, goalY, ObjectFilter) -- need to resolve collsions

    self.x, self.y = actualX, actualY

    resolveCollisions(cols, len)
end

function ObstacleHandler:update(dt)
    for _, Obstacle in pairs(ActiveObstacles) do
        move(Obstacle, dt)
        Obstacle.vy = -Obstacle.speed * ObstacleSpeedMult
    end
end

function ObstacleHandler:draw()
    -- Draw warns for obstacles
    for _, Obstacle in pairs(WarnedObstacles) do
        love.graphics.draw(Obstacle.warnImage, Obstacle.x, Obstacle.y)
    end

    -- Draw active obstacles
    for _, Obstacle in pairs(ActiveObstacles) do
        love.graphics.draw(Obstacle.image, Obstacle.x, Obstacle.y)
    end
end

return ObstacleHandler