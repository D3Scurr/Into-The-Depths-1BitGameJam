local game = { }

function game:init()
    -- Wall
    local leftWall = { isWall = true }
    local rightWall = { isWall = true }

    World:add(leftWall, 0, 0, 8, Config.BASE_HEIGHT)
    World:add(rightWall, Config.BASE_WIDTH-8, 0, 8, Config.BASE_HEIGHT)

    WallImageLeft = love.graphics.newImage('res/img/Wall-left.png')
    WallImageRight = love.graphics.newImage('res/img/Wall-right.png')

    Cam = Camera()

    Cam:lookAt(16, 0)
end

function game:enter()
    ObstacleHandler:reset()
    Player:reset()

    -- Timers
    ObstacleTimer = Timer()
    ScoreTimer = Timer()

    ScoreTimer:every(0.1, function()
        Player.score = Player.score + 1
    end)

    ScoreTimer:every(10, function()
        ObstacleSpeedMult = ObstacleSpeedMult + ObstacleSpeedAdd
        ObstacleSpeedAdd = ObstacleSpeedAdd * 1.2

        ObstacleSpawnMult = ObstacleSpawnMult + ObstacleSpawnAdd
        ObstacleSpeedAdd = ObstacleSpawnAdd * 2
    end)

    spawnNewObstacle()
end

function game:update(dt)
    Player:update(dt)
    Timer.update(dt)
    ScoreTimer:update(dt)
    ObstacleTimer:update(dt)
    ObstacleHandler:update(dt)
end

-- * game:draw * --

local function drawWalls()
    love.graphics.draw(WallImageLeft, 0, 0)
    love.graphics.draw(WallImageRight, Config.BASE_WIDTH-8, 0)
end

function game:draw()
    love.graphics.scale(Config.SCALE, Config.SCALE)
    drawWalls()
    Player:draw()
    ObstacleHandler:draw()
    Ui:draw()
end

return game